package com.javaweb.repository;

import com.javaweb.entity.ProductInventoryEntity;
import com.javaweb.repository.custom.ProductInventoryRepositoryCustom;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ProductInventoryRepository extends JpaRepository<ProductInventoryEntity, Long>, ProductInventoryRepositoryCustom {
    List<ProductInventoryEntity> findAllByStatus(String status);

    @Query(value = "SELECT pi.* FROM product_inventory pi WHERE TIMESTAMP(pi.expiredat) < TIMESTAMP(NOW()) AND STATUS='UNUSED' ", nativeQuery = true)
    List<ProductInventoryEntity> findAllExpired();

    @Query(value = "SELECT SUM(priceinimport) FROM product_inventory WHERE status='CORRUPTED' AND DATE(modifiedat) = DATE('2025-05-14') ", nativeQuery = true)
    Long findDropTotalByDate(@Param("date") String date);

    @Modifying
    @Query(value = "UPDATE product_inventory pi SET pi.status='LOCKED', pi.note='Sản phẩm cha đã bị xóa, phải bỏ đi', pi.modifiedat=NOW() WHERE pi.productid = :productid AND pi.status = 'UNUSED' ", nativeQuery = true)
    void lockAllByProductId(@Param("productid") Long productId);

    @Modifying
    @Query(value = "UPDATE product_inventory pi SET status = 'DELIVERED', orderid = :orderId WHERE status='UNUSED' AND productid = :productId LIMIT :quantity ", nativeQuery = true)
    void deliverWithLimit(@Param("productId") Long productId, @Param("quantity") Long quantity, @Param("orderId") Long orderId); // update status to delivery
}
