package com.javaweb.repository;

import com.javaweb.entity.UserEntity;
import com.javaweb.repository.custom.UserRepositoryCustom;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface UserRepository extends JpaRepository<UserEntity, Long>, UserRepositoryCustom {
    UserEntity findByEmailAndIsActive(String email, Integer isActive);
    UserEntity findByPhoneNumberContains(String phoneNumber);

    @Query(value = "SELECT COUNT(*) FROM (SELECT * FROM users WHERE DATE(createdat) = DATE(:date) ) u_rec ", nativeQuery = true)
    Long countAllCreatedByDate(@Param("date") String date);
}
