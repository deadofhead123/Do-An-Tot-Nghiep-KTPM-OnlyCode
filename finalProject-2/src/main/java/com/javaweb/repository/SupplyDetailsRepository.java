package com.javaweb.repository;

import com.javaweb.entity.SupplierEntity;
import com.javaweb.entity.SupplyDetailsEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface SupplyDetailsRepository extends JpaRepository<SupplyDetailsEntity, Long> {
    List<SupplyDetailsEntity> findAllBySupplierEntity(SupplierEntity supplierEntity);
}
