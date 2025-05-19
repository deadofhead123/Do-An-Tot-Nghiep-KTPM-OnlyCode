package com.javaweb.repository;

import com.javaweb.entity.OrderDetailsEntity;
import com.javaweb.entity.ProductEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface OrderDetailsRepository extends JpaRepository<OrderDetailsEntity, Long> {
    List<OrderDetailsEntity> findAllByProductEntity(ProductEntity productEntity);

    @Query(value = "SELECT od.* FROM order_details od WHERE DATE(od.createdat) = DATE(:date) ", nativeQuery = true)
    List<OrderDetailsEntity> findAllByCreatedAtModified(@Param("date") String date);
}
