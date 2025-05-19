package com.javaweb.repository.custom;

import com.javaweb.entity.SupplierEntity;
import com.javaweb.model.request.SupplierSearchRequest;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface SupplierRepositoryCustom {
    List<SupplierEntity> findAll(SupplierSearchRequest supplierSearchRequest, Pageable pageable);
    int countTotalItems(SupplierSearchRequest supplierSearchRequest);
}
