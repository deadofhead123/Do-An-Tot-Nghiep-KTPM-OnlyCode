package com.javaweb.repository.custom;

import com.javaweb.entity.ProductEntity;
import com.javaweb.model.request.ProductSearchRequest;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface ProductRepositoryCustom {
    List<ProductEntity> findAll(ProductSearchRequest request, Pageable pageable);
    Page<ProductEntity> findAll_Web(ProductSearchRequest request, Pageable pageable);
    int countTotalItems(ProductSearchRequest request);
}
