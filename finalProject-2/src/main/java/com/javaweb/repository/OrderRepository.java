package com.javaweb.repository;

import com.javaweb.entity.OrderEntity;
import com.javaweb.entity.UserEntity;
import com.javaweb.repository.custom.OrderRepositoryCustom;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface OrderRepository extends JpaRepository<OrderEntity, Long>, OrderRepositoryCustom {
    OrderEntity findOneById(Long orderId);
    List<OrderEntity> findAllByUserEntityAndStatus(UserEntity userEntity, String status);
    List<OrderEntity> findAllByStatus(String status);

//    @Query(value = "SELECT SUM(total - discount) FROM orders WHERE status='DELIVERED' AND MONTH(modifiedat) = MONTH(:month) AMD YEAR(modifiedat) = YEAR(:year) ", nativeQuery = true)
//    List<OrderEntity> findAllDeliveredByMonthModified(@Param("month") int month, @Param("year") int year );
    @Query(value = "SELECT * FROM orders WHERE createdat LIKE CONCAT(:date, '%') AND modifiedat LIKE CONCAT(:date, '%')", nativeQuery = true)
    List<OrderEntity> findAllByTime(@Param("date") String date);

    @Query(value = "SELECT * FROM orders WHERE status='DELIVERED' AND DATE(modifiedat) = DATE(:date) ", nativeQuery = true)
    List<OrderEntity> findAllDeliveredByDateModified(@Param("date") String date);

    @Query(value = "SELECT SUM(total - discount) FROM orders WHERE status='DELIVERED' AND DATE(modifiedat) = DATE(:date) ", nativeQuery = true)
    Long findTotalByDate(@Param("date") String date);

    @Query(value = "SELECT SUM(total - discount) FROM orders WHERE status='DELIVERED' AND modifiedat LIKE CONCAT(:date, '%');", nativeQuery = true)
    Long findTotalByMonth(@Param("date") String date);

    @Query(value = "SELECT COUNT(*) FROM (SELECT id FROM orders WHERE status='DELIVERED' AND DATE(modifiedat) = DATE(:date) )od_rec ", nativeQuery = true)
    Long countOrderDelivered(String date);
}
