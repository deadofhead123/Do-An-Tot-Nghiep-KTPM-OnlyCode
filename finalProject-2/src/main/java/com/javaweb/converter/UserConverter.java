package com.javaweb.converter;

import com.javaweb.entity.UserEntity;
import com.javaweb.model.dto.UserDTO;
import com.javaweb.model.response.UserSearchResponse;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.ObjectUtils;

@Component
public class UserConverter {
    @Autowired
    private ModelMapper modelMapper;

    public UserDTO convertToDTO(UserEntity userEntity){
        if(ObjectUtils.isEmpty(userEntity)) return null;
        return modelMapper.map(userEntity, UserDTO.class);
    }

    public UserEntity convertToEntity(UserDTO userDTO){
        UserEntity userEntity  = modelMapper.map(userDTO, UserEntity.class);
        return userEntity;
    }

    public UserSearchResponse convertToSearchResponse(UserEntity userEntity){
        UserSearchResponse userSearchResponse = modelMapper.map(userEntity, UserSearchResponse.class);

        String role = userEntity.getRoles().get(0).getName();
        userSearchResponse.setRole(role);

        return userSearchResponse;
    }
}
