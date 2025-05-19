package com.javaweb.service.user;

import com.javaweb.model.dto.ChangePasswordDTO;
import com.javaweb.model.dto.ResetPasswordDTO;
import com.javaweb.model.dto.UserDTO;
import com.javaweb.model.request.UserSearchRequest;
import com.javaweb.model.response.UserSearchResponse;
import org.springframework.data.domain.Pageable;

import javax.mail.MessagingException;
import java.io.UnsupportedEncodingException;
import java.util.List;

public interface IUserService {
     UserDTO findOneByEmailAndIsActive(String username, Integer isActive);
     UserDTO findOneById(Long id);
     List<UserSearchResponse> findAll(UserSearchRequest userSearchRequest, Pageable pageable);

     UserDTO resetPasswordOfUser(ResetPasswordDTO resetPasswordDTO);

     UserDTO createUser(UserDTO user);
     UserDTO updateUser(UserDTO userDTO);
     Boolean applyDiscount_Admin(Long discount);

     UserDTO changePasswordOfUser(ChangePasswordDTO changePasswordDTO);

     int countTotalItems(UserSearchRequest userSearchRequest);
     Long countTotalItemsByDate(String date);

     Boolean lockOrUnlockUser(List<Long> userIds, Integer isActive) throws MessagingException, UnsupportedEncodingException;
}
