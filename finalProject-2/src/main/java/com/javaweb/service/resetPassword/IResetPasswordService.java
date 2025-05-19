package com.javaweb.service.resetPassword;

import com.javaweb.model.dto.ResetPasswordDTO;

public interface IResetPasswordService {
    public void save(ResetPasswordDTO resetAccountDTO);
    public ResetPasswordDTO findByToken(String token);
}
