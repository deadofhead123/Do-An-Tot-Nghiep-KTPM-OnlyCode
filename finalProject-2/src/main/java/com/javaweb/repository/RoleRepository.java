package com.javaweb.repository;

import com.javaweb.entity.RoleEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RoleRepository extends JpaRepository<RoleEntity, Long> {
    public RoleEntity getOneByCode(String code);
}
