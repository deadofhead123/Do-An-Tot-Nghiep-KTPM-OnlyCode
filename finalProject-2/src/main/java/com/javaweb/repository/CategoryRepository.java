package com.javaweb.repository;

import com.javaweb.entity.CategoryEntity;
import com.javaweb.repository.custom.CategoryRepositoryCustom;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CategoryRepository extends JpaRepository<CategoryEntity, Long>, CategoryRepositoryCustom {
    public List<CategoryEntity> findAllByParentId(Long id);
    public CategoryEntity findByNameAndIsActive(String name, Integer isActive);
}
