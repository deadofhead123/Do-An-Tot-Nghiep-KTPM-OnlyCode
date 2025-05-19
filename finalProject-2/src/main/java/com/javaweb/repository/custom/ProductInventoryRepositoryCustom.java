package com.javaweb.repository.custom;

import com.javaweb.entity.ProductInventoryEntity;
import com.javaweb.model.request.ProductInventorySearchRequest;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface ProductInventoryRepositoryCustom {
    List<ProductInventoryEntity> findAll(ProductInventorySearchRequest productInventorySearchRequest, Pageable pageable);
    int countTotalItems(ProductInventorySearchRequest productInventorySearchRequest);
}
