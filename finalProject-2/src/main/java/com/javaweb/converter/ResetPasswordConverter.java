package com.javaweb.converter;

import com.javaweb.constant.SystemConstant;
import com.javaweb.entity.ResetPasswordEntity;
import com.javaweb.model.dto.ResetPasswordDTO;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.ObjectUtils;

import java.time.LocalDateTime;

@Component
public class ResetPasswordConverter {
    @Autowired
    private ModelMapper modelMapper;

    public ResetPasswordEntity convertToEntity(ResetPasswordDTO resetPasswordDTO) {
        ResetPasswordEntity resetPasswordEntity = modelMapper.map(resetPasswordDTO, ResetPasswordEntity.class);
        resetPasswordEntity.setTimeExpired(LocalDateTime.now().plusDays(SystemConstant.RESET_TOKEN_EXPIRED));

        if(resetPasswordDTO.getId() == null) resetPasswordEntity.setIsUsed(0);
        else resetPasswordEntity.setIsUsed(1);

        return resetPasswordEntity;
    }

    public ResetPasswordDTO convertToDTO(ResetPasswordEntity resetPasswordEntity) {
        if(ObjectUtils.isEmpty(resetPasswordEntity)) return null;
        else return modelMapper.map(resetPasswordEntity, ResetPasswordDTO.class);
    }
}
