package com.javaweb.repository;

import com.javaweb.entity.SupplierEntity;
import com.javaweb.repository.custom.SupplierRepositoryCustom;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface SupplierRepository extends JpaRepository<SupplierEntity, Long>, SupplierRepositoryCustom {
    SupplierEntity findOneById(Long id);

    @Query(value = "SELECT SUM(total) FROM suppliers WHERE createdat LIKE CONCAT(:date, '%');", nativeQuery = true)
    Long findImportTotalByTime(@Param("date") String date);
}
