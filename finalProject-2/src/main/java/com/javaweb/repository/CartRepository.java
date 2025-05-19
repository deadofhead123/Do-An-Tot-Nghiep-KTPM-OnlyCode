package com.javaweb.repository;

import com.javaweb.entity.CartEntity;
import com.javaweb.entity.ProductEntity;
import com.javaweb.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CartRepository extends JpaRepository<CartEntity, Long> {
    CartEntity findOneByUserEntityAndProductEntity(UserEntity userEntity, ProductEntity productEntity);
    List<CartEntity> findAllByUserEntity(UserEntity userEntity);
    void deleteAllByUserEntityAndProductEntity(UserEntity userEntity, ProductEntity productEntity);
    void deleteAllByProductEntity(ProductEntity productEntity);
}
