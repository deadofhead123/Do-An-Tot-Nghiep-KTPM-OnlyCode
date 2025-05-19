package com.javaweb.service.order;

import com.javaweb.constant.SystemConstant;
import com.javaweb.converter.OrderConverter;
import com.javaweb.converter.OrderDetailsConverter;
import com.javaweb.entity.CartEntity;
import com.javaweb.entity.OrderDetailsEntity;
import com.javaweb.entity.OrderEntity;
import com.javaweb.entity.UserEntity;
import com.javaweb.model.dto.OrderDTO;
import com.javaweb.model.dto.OrderDetailsDTO;
import com.javaweb.model.request.OrderSearchRequest;
import com.javaweb.model.response.OrderSearchResponse;
import com.javaweb.model.response.MoneyStatisticResponse;
import com.javaweb.repository.*;
import com.javaweb.security.utils.SecurityUtils;
import com.javaweb.util.OrderStatusCode;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
@RequiredArgsConstructor
public class OrderService implements IOrderService{
    private final CartRepository cartRepository;
    private final UserRepository userRepository;
    private final OrderRepository orderRepository;
    private final OrderDetailsRepository orderDetailsRepository;
    private final ProductInventoryRepository productInventoryRepository;
    private final OrderDetailsConverter orderDetailsConverter;
    private final OrderConverter orderConverter;
    private final PasswordEncoder passwordEncoder;
    private final SupplierRepository supplierRepository;

    @Override
    public List<OrderSearchResponse> findAll(OrderSearchRequest orderSearchRequest, Pageable pageable) {
        List<OrderEntity> orderEntities = orderRepository.findAll(orderSearchRequest, pageable);

        return orderEntities.stream().map(orderConverter::convertToSearchResponseDTO).collect(Collectors.toList());
    }

    @Override
    public int countTotalItems(OrderSearchRequest orderSearchRequest) {
        return orderRepository.countTotalItems(orderSearchRequest);
    }

    @Override
    public Page<OrderDTO> findAllByUser(Pageable pageable) {
        Page<OrderEntity> orderEntities = orderRepository.findAllByUserEntity(pageable);

        return orderEntities.map(orderConverter::convertToDTO);
    }

    @Override
    public List<OrderDetailsDTO> findAllDetailsByOrderId(Long orderId) {
        return filterOrderDetails(orderRepository.getOne(orderId)).stream().map(orderDetailsConverter::convertToDTO).collect(Collectors.toList());
    }

    @Override
    public OrderDTO findOneById(Long orderId) {
        return orderConverter.convertToDTO(orderRepository.getOne(orderId));
    }

    @Override
    public Long findTotal(String date) {
        Long total = orderRepository.findTotalByDate(date);
        if(total == null) return 0L;
        else return total;
    }

    @Override
    public List<MoneyStatisticResponse> findTotalByMonth(LocalDate date) {
        List<MoneyStatisticResponse> result = new ArrayList<>();

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM");

        String formattedDate = date.format(formatter);

        Integer dateOfToday = (date.isBefore(LocalDate.now())) ? date.lengthOfMonth() : date.getDayOfMonth();
        Integer monthOfToday = date.getMonthValue();

        for(Integer i = 1 ; i <= dateOfToday ; i++) {
            String dayToFind = formattedDate + "-" + i;

            Long orderTotal = orderRepository.findTotalByDate(dayToFind);
            orderTotal = orderTotal == null ? 0 : orderTotal;

            Long importTotal = supplierRepository.findImportTotalByDate(dayToFind);
            importTotal = importTotal == null ? 0 : importTotal;

            MoneyStatisticResponse moneyStatisticResponse = new MoneyStatisticResponse();
            moneyStatisticResponse.setRevenue(orderTotal);
            moneyStatisticResponse.setImportTotal(importTotal);
            moneyStatisticResponse.setDate(i + "/" + monthOfToday);
            result.add(moneyStatisticResponse);
        }

        return result;
    }

    @Override
    public List<MoneyStatisticResponse> findTotalByYear(LocalDate date) {
        List<MoneyStatisticResponse> result = new ArrayList<>();

        Integer monthOfYear = (date.getYear() < LocalDate.now().getYear()) ? 12 : date.getMonthValue();

        for(Integer i = 1 ; i <= monthOfYear ; i++) {
            String monthToFind = date.getYear() + "-" + ((i < 10) ? ("0" + i) : i);

            Long orderTotal = orderRepository.findTotalByMonth(monthToFind);
            orderTotal = orderTotal == null ? 0 : orderTotal;

            Long importTotal = supplierRepository.findImportTotalByMonth(monthToFind);
            importTotal = importTotal == null ? 0 : importTotal;

            MoneyStatisticResponse moneyStatisticResponse = new MoneyStatisticResponse();
            moneyStatisticResponse.setRevenue(orderTotal);
            moneyStatisticResponse.setRevenue(importTotal);
            moneyStatisticResponse.setDate(i.toString());
            result.add(moneyStatisticResponse);
        }

        return result;
    }

    @Override
    public Long findQuantityDelivered(String date) {
        List<OrderEntity> orderEntities = orderRepository.findAllDeliveredByDateModified(date);
        List<OrderDetailsEntity> orderDetailsEntities = new ArrayList<>();
        Long quantityOrdered = 0L;

        for(OrderEntity item : orderEntities){
            orderDetailsEntities.addAll(filterOrderDetails(item));
        }

        for(OrderDetailsEntity item : orderDetailsEntities){
            quantityOrdered += item.getQuantity();
        }

        return quantityOrdered;
    }

    @Override
    public Long findOrderDelivered(String date) {
        return orderRepository.countOrderDelivered(date);
    }

    @Override
    public List<String> findQuantityByStatus(String date) {
        List<String> quantities = new ArrayList<>();
        List<OrderEntity> orderEntities = orderRepository.findAll();

        for(OrderStatusCode item : OrderStatusCode.values()){
            Long statusQuantity = 1L * orderEntities.stream().filter(x -> x.getStatus().equals(item.toString())).collect(Collectors.toList()).size();
            quantities.add("'" + item.toString() + "." + item.getName() + "." + statusQuantity + "'");
        }

        return quantities;
    }

    @Override
    public OrderDTO createOrder(OrderDTO orderDTO) {
        OrderEntity orderEntity = orderConverter.convertToEntity(orderDTO);

        UserEntity userEntity = userRepository.getOne(SecurityUtils.getPrincipal().getId());

        Long discountOfUser = userEntity.getDiscount();
        discountOfUser = discountOfUser == null ? 0 : discountOfUser;
        orderEntity.setDiscount(discountOfUser);

        orderEntity.setUserEntity(userEntity);
        orderEntity.setStatus(SystemConstant.DEFAULT_ORDER_STATUS);

        OrderEntity orderEntityAfterSave = orderRepository.save(orderEntity);

        List<CartEntity> cartEntities = cartRepository.findAllByUserEntity(userEntity);

        String orderId = passwordEncoder.encode(orderEntityAfterSave.getId().toString());

        for(CartEntity cartEntity : cartEntities) {
            OrderDetailsEntity orderDetailsEntity = new OrderDetailsEntity();

            orderDetailsEntity.setOrderId(orderId);
            orderDetailsEntity.setProductEntity(cartEntity.getProductEntity());
            orderDetailsEntity.setQuantity(cartEntity.getQuantity());

            Long price = orderDetailsEntity.getProductEntity().getPrice();
            Long discount = cartEntity.getProductEntity().getDiscount();
            if(discount == null) discount = 0L;
            orderDetailsEntity.setPriceInPurchase(price - price * discount / 100);

            orderDetailsRepository.save(orderDetailsEntity);

            cartRepository.delete(cartEntity);
        }

        return orderConverter.convertToDTO(orderEntityAfterSave);
    }

    @Override
    public OrderDTO updateOrder(OrderDTO orderDTO) {
        Long orderId = orderDTO.getId();
        OrderEntity orderEntity = orderRepository.getOne(orderId);

        // Deliver
        if(orderDTO.getStatus().equals(OrderStatusCode.DELIVERING.toString()) && !orderEntity.getStatus().equals(OrderStatusCode.DELIVERING.toString())){
            List<OrderDetailsEntity> orderDetailsMatches = filterOrderDetails(orderEntity);

            for(OrderDetailsEntity item : orderDetailsMatches) {
                item.getProductEntity().setQuantity(item.getProductEntity().getQuantity() - item.getQuantity());
                productInventoryRepository.deliverWithLimit(item.getProductEntity().getId(), item.getQuantity(), orderId);
            }

            orderDetailsRepository.saveAll(orderDetailsMatches);
        }

        // Must complete delivery to update to "DELIVERED"
        if(orderDTO.getStatus().equals(OrderStatusCode.DELIVERED.toString()) && !orderEntity.getStatus().equals(OrderStatusCode.DELIVERING.toString())){
            return null;
        }

        orderEntity.setStatus(orderDTO.getStatus());
        orderEntity.setNote(orderDTO.getNote());

        return orderConverter.convertToDTO(orderRepository.save(orderEntity));
    }

//    public List<OrderDetailsEntity> filterOrderDetails(Long orderId){
//        List<OrderDetailsEntity> orderDetailsEntities = orderDetailsRepository.findAll();
//        String orderIdString = orderId.toString();
//
//        return orderDetailsEntities.stream()
//                .filter(x -> passwordEncoder.matches(orderIdString, x.getOrderId()))
//                .collect(Collectors.toList());
//    }

    public List<OrderDetailsEntity> filterOrderDetails(OrderEntity orderEntity){
        List<OrderDetailsEntity> orderDetailsEntities = orderDetailsRepository.findAllByCreatedAtModified(orderEntity.getCreatedAt().toString());
        String orderIdString = orderEntity.getId().toString();

        return orderDetailsEntities.stream()
                .filter(x -> passwordEncoder.matches(orderIdString, x.getOrderId()))
                .collect(Collectors.toList());
    }
}
