package com.javaweb.repository.custom;

import com.javaweb.entity.OrderEntity;
import com.javaweb.model.request.OrderSearchRequest;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface OrderRepositoryCustom {
    List<OrderEntity> findAll(OrderSearchRequest orderSearchRequest, Pageable pageable);
    int countTotalItems(OrderSearchRequest orderSearchRequest);

    Page<OrderEntity> findAllByUserEntity(Pageable pageable);
    int countTotalItems_Web();
}
