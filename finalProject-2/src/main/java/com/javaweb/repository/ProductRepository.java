package com.javaweb.repository;

import com.javaweb.entity.ProductEntity;
import com.javaweb.repository.custom.ProductRepositoryCustom;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ProductRepository extends JpaRepository<ProductEntity, Long>, ProductRepositoryCustom {
    ProductEntity findByNameAndIsActive(String name, Integer isActive);
    List<ProductEntity> findByIsActive(Integer isActive);
    List<ProductEntity> findByNameContainingAndIsActive(String name, Integer isActive);

    @Query(value = "SELECT p.* FROM products p WHERE p.hot = 'YES' ORDER BY p.name LIMIT 4 ", nativeQuery = true)
    List<ProductEntity> findHotWithLimit();

    @Query(value = "SELECT p.* FROM products p WHERE p.quantity <= :quantity AND p.isactive = 1", nativeQuery = true)
    List<ProductEntity> findAllNearOutOfQuantity(@Param("quantity") Integer quantity);
}
