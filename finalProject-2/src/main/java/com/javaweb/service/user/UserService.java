package com.javaweb.service.user;

import com.javaweb.converter.FeedbackConverter;
import com.javaweb.converter.UserConverter;
import com.javaweb.entity.ResetPasswordEntity;
import com.javaweb.entity.RoleEntity;
import com.javaweb.entity.UserEntity;
import com.javaweb.model.dto.ChangePasswordDTO;
import com.javaweb.model.dto.ResetPasswordDTO;
import com.javaweb.model.dto.UserDTO;
import com.javaweb.model.request.UserSearchRequest;
import com.javaweb.model.response.UserSearchResponse;
import com.javaweb.repository.*;
import com.javaweb.security.utils.SecurityUtils;
import com.javaweb.service.mail.IMailService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.mail.MessagingException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Service
@Transactional
@RequiredArgsConstructor
public class UserService implements IUserService {
    private final IMailService IMailService;
    private final ResetPasswordRepository resetPasswordRepository;
    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final FeedbackRepository feedbackRepository;
    private final OrderRepository orderRepository;
    private final OrderDetailsRepository orderDetailsRepository;
    private final ProductRepository productRepository;
    private final UserConverter userConverter;
    private final PasswordEncoder passwordEncoder;
    private final FeedbackConverter feedbackConverter;

    @Override
    public List<UserSearchResponse> findAll(UserSearchRequest userSearchRequest, Pageable pageable) {
        List<UserEntity> listUser = userRepository.findAll(userSearchRequest, pageable);

        List<UserSearchResponse> listUserSearchResponse = new ArrayList<>();

        for(UserEntity user : listUser){
            listUserSearchResponse.add(userConverter.convertToSearchResponse(user));
        }

        return listUserSearchResponse;
    }

    @Override
    public UserDTO findOneByEmailAndIsActive(String email, Integer isActive) {
        return userConverter.convertToDTO(userRepository.findByEmailAndIsActive(email, 1));
    }

    @Override
    public UserDTO findOneById(Long id) {
        return userConverter.convertToDTO(userRepository.getOne(id));
    }

    // When inserting, "CreatedAt", "CreatedBy", "ModifiedAt", "ModifiedBy", "RolesEntity" doesn't exist so we can use ModelMapper
    @Override
    public UserDTO createUser(UserDTO userDTO) {
        RoleEntity role = roleRepository.getOneByCode(userDTO.getRoleCode());

        UserEntity userEntity = userConverter.convertToEntity(userDTO);
        userEntity.setRoles(Stream.of(role).collect(Collectors.toList()));
        userEntity.setPassword(passwordEncoder.encode(userDTO.getPassword()));
        userEntity.setFullName(userDTO.getEmail().split("@")[0]);
        userEntity.setDiscount(0L);
        userEntity.setIsActive(1);

        return userConverter.convertToDTO(userRepository.save(userEntity));
    }

    // When updating, if we use ModelMapper to map from UserDTO to UserEntity, "CreatedAt", "CreatedBy", "ModifiedAt", "ModifiedBy", "RolesEntity" will be deleted,
    // so we don't use
    @Override
    public UserDTO updateUser(UserDTO userDTO) {
        UserEntity userEntity = userRepository.findById(SecurityUtils.getPrincipal().getId()).get();
        UserEntity checkUsersPhoneNumber = userRepository.findByPhoneNumberContains(userDTO.getPhoneNumber());

        if(checkUsersPhoneNumber == null || userDTO.getEmail().equals(checkUsersPhoneNumber.getEmail()) ) {
            // Number of field will be set is 3, so we don't have to use Reflection
            userEntity.setFullName(userDTO.getFullName());
            userEntity.setPhoneNumber(userDTO.getPhoneNumber());
            userEntity.setAddress(userDTO.getAddress());
            SecurityUtils.getPrincipal().setFullName(userDTO.getFullName());

            return userConverter.convertToDTO(userRepository.save(userEntity));
        }

        return null;
    }

    @Override
    public Boolean applyDiscount_Admin(Long discount) {
        try{
            List<UserEntity> userEntities = userRepository.findAll();

            for (UserEntity userEntity : userEntities) {
                userEntity.setDiscount(discount);
            }

            userRepository.saveAll(userEntities);

            return true;
        } catch (Exception e) {
            return false;
        }
    }

    @Override
    public UserDTO changePasswordOfUser(ChangePasswordDTO changePasswordDTO) {
        UserEntity userEntity = userRepository.findById(SecurityUtils.getPrincipal().getId()).get();
        Boolean matches = passwordEncoder.matches(changePasswordDTO.getOldPassword(), userEntity.getPassword());

        if(matches){
            userEntity.setPassword(passwordEncoder.encode(changePasswordDTO.getNewPassword()));
            return userConverter.convertToDTO(userRepository.save(userEntity));
        }

        return null;
    }

    @Override
    public UserDTO resetPasswordOfUser(ResetPasswordDTO resetPasswordDTO) {
        ResetPasswordEntity resetPasswordEntity = resetPasswordRepository.findByResetTokenAndIsUsed(resetPasswordDTO.getToken(), 0);
        resetPasswordEntity.setIsUsed(1);
        resetPasswordRepository.save(resetPasswordEntity);

        UserEntity userEntity = userRepository.findByEmailAndIsActive(resetPasswordEntity.getEmail(), 1);
        userEntity.setPassword(passwordEncoder.encode(resetPasswordDTO.getPassword()));

        return userConverter.convertToDTO(userRepository.save(userEntity));
    }

    @Override
    public int countTotalItems(UserSearchRequest userSearchRequest) {
        return userRepository.countTotalItems(userSearchRequest);
    }

    @Override
    public Long countTotalItemsByDate(String date) {
        Long total = userRepository.countAllCreatedByDate(date);

        if(total == null) return 0L;
        return total;
    }

    @Override
    public Boolean lockOrUnlockUser(List<Long> userIds, Integer isActive) throws MessagingException, UnsupportedEncodingException {
        List<UserEntity> userEntities = userRepository.findAllById(userIds);

        for(int i = 0 ; i < userIds.size() ; i++){
            UserEntity userEntity = userEntities.get(i);
            userEntity.setIsActive(isActive);

            Boolean checkSendingEmail = IMailService.lockOrUnlockAccount(userEntity.getEmail(), isActive);

            if(!checkSendingEmail) return false;
        }

        userRepository.saveAll(userEntities);

        return true;
    }
}
