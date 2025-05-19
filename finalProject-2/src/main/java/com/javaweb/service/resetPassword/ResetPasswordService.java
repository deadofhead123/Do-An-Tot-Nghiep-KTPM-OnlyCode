package com.javaweb.service.resetPassword;

import com.javaweb.converter.ResetPasswordConverter;
import com.javaweb.model.dto.ResetPasswordDTO;
import com.javaweb.repository.ResetPasswordRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class ResetPasswordService implements IResetPasswordService {
    @Autowired
    private ResetPasswordConverter resetPasswordConverter;

    @Autowired
    private ResetPasswordRepository resetPasswordRepository;

    @Override
    public void save(ResetPasswordDTO resetPasswordDTO) {
        resetPasswordRepository.save(resetPasswordConverter.convertToEntity(resetPasswordDTO));
    }

    @Override
    public ResetPasswordDTO findByToken(String token) {
        return resetPasswordConverter.convertToDTO(resetPasswordRepository.findByResetTokenAndIsUsed(token, 0));
    }
}
