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
import com.javaweb.model.response.MoneyStatisticResponse;
import com.javaweb.model.response.OrderSearchResponse;
import com.javaweb.model.response.OrderStatusQuantityResponse;
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
import java.util.stream.Stream;

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
    public Long findTotalByDate(String date) {
        Long total = orderRepository.findTotalByDate(date);
        if(total == null) return 0L;
        else return total;
    }

    @Override
    public List<MoneyStatisticResponse> findTotalByMonth(LocalDate date) {
        List<MoneyStatisticResponse> result = new ArrayList<>();

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM");
        String formattedDate = date.format(formatter);
        Integer dateOfToday;
        String monthToCompare;

        LocalDate now = LocalDate.now();
        if(!date.isEqual(now)){ // Random month, compare with current year
            dateOfToday = date.lengthOfMonth();
            monthToCompare = now.format(formatter);
        }
        else{ // Random month, compare with current year
            dateOfToday = date.getDayOfMonth();
            monthToCompare = now.minusMonths(1).format(formatter);
        }

        Integer monthOfToday = date.getMonthValue();

        for(Integer i = 1 ; i <= dateOfToday ; i++) {
            String dayToFind = formattedDate + "-" + ((i < 10) ? ("0" + i) : i);

            Long orderTotal = orderRepository.findTotalByDate(dayToFind);
            orderTotal = orderTotal == null ? 0 : orderTotal;

            Long importTotal = supplierRepository.findImportTotalByTime(dayToFind);
            importTotal = importTotal == null ? 0 : importTotal;

            MoneyStatisticResponse moneyStatisticResponse = new MoneyStatisticResponse();
            moneyStatisticResponse.setRevenue(orderTotal);
            moneyStatisticResponse.setImportTotal(importTotal);
            moneyStatisticResponse.setDate(i + "/" + monthOfToday);
            result.add(moneyStatisticResponse);
        }

        Long orderTotal = orderRepository.findTotalByMonth(monthToCompare);
        orderTotal = orderTotal == null ? 0 : orderTotal;

        Long importTotal = supplierRepository.findImportTotalByTime(monthToCompare);
        importTotal = importTotal == null ? 0 : importTotal;

        MoneyStatisticResponse moneyStatisticResponse = new MoneyStatisticResponse();
        moneyStatisticResponse.setRevenue(orderTotal);
        moneyStatisticResponse.setImportTotal(importTotal);
        result.add(moneyStatisticResponse);

        return result;
    }

    @Override
    public List<MoneyStatisticResponse> findTotalByYear(LocalDate date) {
        List<MoneyStatisticResponse> result = new ArrayList<>();
        Integer monthOfYear;
        Integer yearOfDateProvided = date.getYear();
        String yearToCompare;

        Integer yearNow = LocalDate.now().getYear();
        if(!yearOfDateProvided.equals(yearNow)){
            monthOfYear = 12;
            yearToCompare = yearNow + "";
        }
        else{ // Compare with previous year
            monthOfYear = date.getMonthValue();
            yearToCompare = (yearOfDateProvided - 1) + "";
        }

        for(Integer i = 1 ; i <= monthOfYear ; i++) {
            String monthToFind = yearOfDateProvided + "-" + ((i < 10) ? ("0" + i) : i);

            Long orderTotal = orderRepository.findTotalByMonth(monthToFind);
            orderTotal = orderTotal == null ? 0 : orderTotal;

            Long importTotal = supplierRepository.findImportTotalByTime(monthToFind);
            importTotal = importTotal == null ? 0 : importTotal;

            MoneyStatisticResponse moneyStatisticResponse = new MoneyStatisticResponse();
            moneyStatisticResponse.setRevenue(orderTotal);
            moneyStatisticResponse.setImportTotal(importTotal);
            moneyStatisticResponse.setDate(i.toString());
            result.add(moneyStatisticResponse);
        }

        Long orderTotal = orderRepository.findTotalByYear(yearToCompare);
        orderTotal = orderTotal == null ? 0 : orderTotal;

        Long importTotal = supplierRepository.findImportTotalByTime(yearToCompare);
        importTotal = importTotal == null ? 0 : importTotal;

        MoneyStatisticResponse moneyStatisticResponse = new MoneyStatisticResponse();
        moneyStatisticResponse.setRevenue(orderTotal);
        moneyStatisticResponse.setImportTotal(importTotal);
        result.add(moneyStatisticResponse);

        return result;
    }

    @Override
    public List<OrderStatusQuantityResponse> findHighestQuantityByTime(String date) {
        List<OrderStatusQuantityResponse> highestOfMonthAndYear = new ArrayList<>();
        OrderStatusQuantityResponse highestOfMonth = new OrderStatusQuantityResponse();
        OrderStatusQuantityResponse highestOfYear = new OrderStatusQuantityResponse();

        highestOfMonth.setQuantity(-1L);
        highestOfYear.setQuantity(-1L);

        String[] dateSplitted = date.split("-");
        Integer thisDay = Integer.parseInt(dateSplitted[2]);
        Integer thisMonth = Integer.parseInt(dateSplitted[1]);

        for(Integer i = 1 ; i <= thisDay ; i++){
            Long quantity = 1L * orderRepository.findAllByTime(dateSplitted[0] + "-" + dateSplitted[1] + "-" + ((i < 10) ? ("0" + i) : i)).size();
            if(highestOfMonth.getQuantity() < quantity){
                highestOfMonth.setQuantity(quantity);
                highestOfMonth.setDate(i + " tháng " + dateSplitted[1]);
            }
        }
        for(Integer i = 1 ; i <= thisMonth ; i++){
            Long quantity = 1L * orderRepository.findAllByTime(dateSplitted[0] + "-" + ((i < 10) ? ("0" + i) : i)).size();
            if(highestOfYear.getQuantity() < quantity){
                highestOfYear.setQuantity(quantity);
                highestOfYear.setDate(i + "");
            }
        }

        highestOfMonthAndYear.add(highestOfMonth);
        highestOfMonthAndYear.add(highestOfYear);

        return highestOfMonthAndYear;
    }

    @Override
    public List<OrderStatusQuantityResponse> findQuantityByStatus_Time(String date) {
        List<OrderStatusQuantityResponse> quantities = new ArrayList<>();
        List<OrderEntity> orderEntities = orderRepository.findAllByTime(date);

        for(OrderStatusCode item : OrderStatusCode.values()){
            OrderStatusQuantityResponse orderStatusQuantityResponse = new OrderStatusQuantityResponse();
            Long statusQuantity = 1L * orderEntities.stream().filter(x -> x.getStatus().equals(item.toString())).collect(Collectors.toList()).size();

            orderStatusQuantityResponse.setStatus(item.toString());
            orderStatusQuantityResponse.setName(item.getName());
            orderStatusQuantityResponse.setQuantity(statusQuantity);

            quantities.add(orderStatusQuantityResponse);
        }

        return quantities;
    }

    @Override
    public List<OrderStatusQuantityResponse> findQuantityByStatus_All() {
        List<OrderStatusQuantityResponse> quantities = new ArrayList<>();
        List<OrderEntity> orderEntities = orderRepository.findAll();

        for(OrderStatusCode item : OrderStatusCode.values()){
            OrderStatusQuantityResponse orderStatusQuantityResponse = new OrderStatusQuantityResponse();
            Long statusQuantity = 1L * orderEntities.stream().filter(x -> x.getStatus().equals(item.toString())).collect(Collectors.toList()).size();

            orderStatusQuantityResponse.setStatus(item.toString());
            orderStatusQuantityResponse.setName(item.getName());
            orderStatusQuantityResponse.setQuantity(statusQuantity);

            quantities.add(orderStatusQuantityResponse);
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

            // Export sub product from inventory
            for(OrderDetailsEntity item : orderDetailsMatches) {
                productInventoryRepository.deliverWithLimit(item.getProductEntity().getId(), item.getQuantity(), orderId);
            }

            orderDetailsRepository.saveAll(orderDetailsMatches);
        }

        // Must complete delivery to update to "DELIVERED"
        if( orderDTO.getStatus().equals(OrderStatusCode.DELIVERED.toString()) ){
            if(!orderEntity.getStatus().equals(OrderStatusCode.DELIVERING.toString())){
                return null;
            }
            else{
                List<OrderDetailsEntity> orderDetailsMatches = filterOrderDetails(orderEntity);

                for(OrderDetailsEntity item : orderDetailsMatches) {
                    // Save to product bought of user
                    String productBought = orderEntity.getUserEntity().getProductBought();

                    if(productBought != null){
                        StringBuilder builderProductBought = new StringBuilder(productBought);
                        String productIdInString = item.getProductEntity().getId().toString();

                        List<String> checkProductBought = Stream.of(productBought.split(",")).filter(x -> x.equals(productIdInString)).collect(Collectors.toList());

                        if(checkProductBought.isEmpty()){
                            builderProductBought.append("," + productIdInString);
                        }

                        orderEntity.getUserEntity().setProductBought(builderProductBought.toString());
                    }

                    // Increase quantity sold, decrease quantity remaining
                    item.getProductEntity().setQuantity(item.getProductEntity().getQuantity() - item.getQuantity());
                    item.getProductEntity().setSold(item.getProductEntity().getSold() + item.getQuantity());
                }

                orderDetailsRepository.saveAll(orderDetailsMatches);
            }
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
        List<OrderDetailsEntity> orderDetailsEntities = orderDetailsRepository.findAllByCreatedAtModified(orderEntity.getCreatedAt().toString().split(" ")[0]);
        String orderIdString = orderEntity.getId().toString();

        return orderDetailsEntities.stream()
                .filter(x -> passwordEncoder.matches(orderIdString, x.getOrderId()))
                .collect(Collectors.toList());
    }
}
