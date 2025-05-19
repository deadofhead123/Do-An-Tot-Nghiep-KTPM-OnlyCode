package com.javaweb.repository.custom;

import com.javaweb.entity.CategoryEntity;
import com.javaweb.model.request.CategorySearchRequest;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface CategoryRepositoryCustom {
    List<CategoryEntity> findAll(CategorySearchRequest request, Pageable pageable);
    int countTotalItems(CategorySearchRequest request);
}
