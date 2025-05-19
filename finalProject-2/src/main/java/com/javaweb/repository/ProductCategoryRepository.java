package com.javaweb.repository;

import com.javaweb.entity.ProductCategoryEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ProductCategoryRepository extends JpaRepository<ProductCategoryEntity, Long> {
    List<ProductCategoryEntity> findAllByCategoryId(Long categoryId);
}
