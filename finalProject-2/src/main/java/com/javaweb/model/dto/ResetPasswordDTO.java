package com.javaweb.model.dto;

import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

import java.time.LocalDateTime;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ResetPasswordDTO extends AbstractDTO<ResetPasswordDTO>{
    String email;
    String token;
    String password;
    LocalDateTime timeExpired;
    Integer isUsed;
}
