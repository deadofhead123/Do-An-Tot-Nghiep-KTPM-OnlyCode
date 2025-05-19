package com.javaweb.repository;

import com.javaweb.entity.ResetPasswordEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ResetPasswordRepository extends JpaRepository<ResetPasswordEntity, Long> {
    public ResetPasswordEntity findByResetTokenAndIsUsed(String token, Integer isUsed);
}
