package com.javaweb.service.order;

import com.javaweb.model.dto.OrderDTO;
import com.javaweb.model.dto.OrderDetailsDTO;
import com.javaweb.model.request.OrderSearchRequest;
import com.javaweb.model.response.OrderSearchResponse;
import com.javaweb.model.response.MoneyStatisticResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.time.LocalDate;
import java.util.List;

public interface IOrderService {
    List<OrderSearchResponse> findAll(OrderSearchRequest orderSearchRequest, Pageable pageable);
    int countTotalItems(OrderSearchRequest orderSearchRequest);
    Page<OrderDTO> findAllByUser(Pageable pageable);
    List<OrderDetailsDTO> findAllDetailsByOrderId(Long orderId);
    OrderDTO findOneById(Long orderId);
    Long findTotal(String date);
    List<MoneyStatisticResponse> findTotalByMonth(LocalDate date);
    List<MoneyStatisticResponse> findTotalByYear(LocalDate date);
    Long findQuantityDelivered(String date);
    Long findOrderDelivered(String date);
    List<String> findQuantityByStatus(String date);

    OrderDTO createOrder(OrderDTO orderDTO);
    OrderDTO updateOrder(OrderDTO orderDTO);
}
