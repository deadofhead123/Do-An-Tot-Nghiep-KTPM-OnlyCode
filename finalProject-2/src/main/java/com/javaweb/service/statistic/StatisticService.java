package com.javaweb.service.statistic;

import com.javaweb.entity.OrderDetailsEntity;
import com.javaweb.entity.OrderEntity;
import com.javaweb.entity.ProductEntity;
import com.javaweb.model.statistic.ExcessProductStatistic;
import com.javaweb.model.statistic.HotProductStatistic;
import com.javaweb.repository.OrderDetailsRepository;
import com.javaweb.repository.OrderRepository;
import com.javaweb.repository.ProductRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
@RequiredArgsConstructor
public class StatisticService implements IStatisticService {
    private final OrderRepository orderRepository;
    private final OrderDetailsRepository orderDetailsRepository;
    private final ProductRepository productRepository;
    private final PasswordEncoder passwordEncoder;

    @Override
    public List<HotProductStatistic> findProductWithHighestQuantitySold(String date) {
        List<OrderEntity> orderEntities = orderRepository.findAllDeliveredByDateModified(date);
        List<OrderDetailsEntity> orderDetailsEntities = new ArrayList<>();
        List<HotProductStatistic> hotProductStatisticList = new ArrayList<>();
        List<HotProductStatistic> finalHotProductStatisticList = new ArrayList<>();

        for(OrderEntity orderEntity : orderEntities) {
            orderDetailsEntities.addAll(filterOrderDetails(orderEntity));
        }

        orderDetailsEntities.sort(Comparator.comparing(od_dt -> od_dt.getProductEntity().getId()));

        HotProductStatistic hotProductStatistic = new HotProductStatistic();
        hotProductStatistic.setId(-1L);

        int idx = -1;
        for(OrderDetailsEntity orderDetailsEntity : orderDetailsEntities) {
            Long productId = orderDetailsEntity.getProductEntity().getId();

            if(!productId.equals(hotProductStatistic.getId())){ // not exist, create new
                HotProductStatistic newHotProductStatistic = new HotProductStatistic();
                newHotProductStatistic.setId(productId);
                newHotProductStatistic.setQuantitySold(orderDetailsEntity.getQuantity());
                newHotProductStatistic.setRevenue(orderDetailsEntity.getQuantity() * orderDetailsEntity.getPriceInPurchase());
                newHotProductStatistic.setImage(orderDetailsEntity.getProductEntity().getImage());
                newHotProductStatistic.setName(orderDetailsEntity.getProductEntity().getName());

                hotProductStatisticList.add(newHotProductStatistic);
                idx++;
            }
            else{ // existed, plus
                HotProductStatistic hotProductStatisticSub = hotProductStatisticList.get(idx);
                hotProductStatisticList.get(idx).setQuantitySold(hotProductStatisticSub.getQuantitySold() + orderDetailsEntity.getQuantity());
                hotProductStatisticList.get(idx).setRevenue(hotProductStatisticSub.getRevenue() + orderDetailsEntity.getQuantity() * orderDetailsEntity.getPriceInPurchase());
            }
        }

        hotProductStatisticList.sort(Comparator.comparing(HotProductStatistic::getQuantitySold));

        if(!hotProductStatisticList.isEmpty()){
            Integer idxMax = hotProductStatisticList.size() - 1;
            Long quantityMax = hotProductStatisticList.get(idxMax).getQuantitySold();

            // Find all product with Max quantity 1st
            for( ; idxMax >= 0L ; idxMax--){
                HotProductStatistic item = hotProductStatisticList.get(idxMax);

                if(item.getQuantitySold().equals(quantityMax)){
                    finalHotProductStatisticList.add(item);
                }
                else break;
            }

            if(idxMax != -1){
                quantityMax = hotProductStatisticList.get(idxMax).getQuantitySold();

                // Find all product with Max quantity 2nd
                for( ; idxMax >= 0L ; idxMax--){
                    HotProductStatistic item = hotProductStatisticList.get(idxMax);

                    if(item.getQuantitySold().equals(quantityMax)){
                        finalHotProductStatisticList.add(item);
                    }
                    else break;
                }
            }
        }

        return finalHotProductStatisticList;
    }

    @Override
    public List<ExcessProductStatistic> findProductWithLowestQuantitySold(String date) {
        List<OrderEntity> orderEntities = orderRepository.findAllDeliveredByDateModified(date);
        List<String> orderIdEncodedList = orderDetailsRepository.findAllDistinct();
        List<OrderDetailsEntity> orderDetailsEntities = new ArrayList<>();
        List<ExcessProductStatistic> excessProductStatisticList = new ArrayList<>();
        List<ExcessProductStatistic> finalExcessProductStatisticList = new ArrayList<>();
        List<ProductEntity> productEntities = productRepository.findAllByIsActive(1);

        for(OrderEntity orderEntity : orderEntities) {
            String orderId = orderEntity.getId().toString();
            String orderIdEncoded = orderIdEncodedList.stream().filter(x -> passwordEncoder.matches(orderId, x)).collect(Collectors.toList()).get(0);
            orderIdEncodedList.stream().filter(x -> x.equals(orderIdEncoded)).findFirst().ifPresent(orderIdEncodedList::remove);
            orderDetailsEntities.addAll(orderDetailsRepository.findAllByOrderIdEquals(orderIdEncoded));
        }

        orderDetailsEntities.sort(Comparator.comparing(od_dt -> od_dt.getProductEntity().getId()));

        ExcessProductStatistic excessProductStatistic = new ExcessProductStatistic();
        excessProductStatistic.setId(-1L);

        int idx = -1;
        for(OrderDetailsEntity orderDetailsEntity : orderDetailsEntities) {
            Long productId = orderDetailsEntity.getProductEntity().getId();

            if(!productId.equals(excessProductStatistic.getId())){ // not exist, create new
                ExcessProductStatistic newExcessProductStatistic = new ExcessProductStatistic();
                newExcessProductStatistic.setId(productId);
                newExcessProductStatistic.setQuantitySold(orderDetailsEntity.getQuantity());
                newExcessProductStatistic.setRevenue(orderDetailsEntity.getQuantity() * orderDetailsEntity.getPriceInPurchase());
                newExcessProductStatistic.setImage(orderDetailsEntity.getProductEntity().getImage());
                newExcessProductStatistic.setName(orderDetailsEntity.getProductEntity().getName());

                excessProductStatisticList.add(newExcessProductStatistic);
                idx++;
            }
            else{ // existed, plus
                ExcessProductStatistic excessProductStatisticSub = excessProductStatisticList.get(idx);
                excessProductStatisticList.get(idx).setQuantitySold(excessProductStatisticSub.getQuantitySold() + orderDetailsEntity.getQuantity());
                excessProductStatisticList.get(idx).setRevenue(excessProductStatisticSub.getRevenue() + orderDetailsEntity.getQuantity() * orderDetailsEntity.getPriceInPurchase());
            }
        }

        for(ProductEntity item : productEntities){
            long check = 0;

            for(ExcessProductStatistic excessProductStatisticSub : excessProductStatisticList){
                if(item.getId().equals(excessProductStatisticSub.getId())){
                    check = 1;
                    break;
                }
            }

            if(check == 0){
                ExcessProductStatistic newExcessProductStatistic = new ExcessProductStatistic();

                newExcessProductStatistic.setQuantitySold(0L);
                newExcessProductStatistic.setImage(item.getImage());
                newExcessProductStatistic.setName(item.getName());
                newExcessProductStatistic.setRevenue(0L);
                excessProductStatisticList.add(newExcessProductStatistic);
            }
        }

        excessProductStatisticList.sort(Comparator.comparing(ExcessProductStatistic::getQuantitySold));

        if(!excessProductStatisticList.isEmpty()){
            Integer idxMin = 0;
            Long quantityMin = excessProductStatisticList.get(idxMin).getQuantitySold();

            // Find all product with Max quantity 1st
            for( ; idxMin < excessProductStatisticList.size() ; idxMin++){
                ExcessProductStatistic item = excessProductStatisticList.get(idxMin);

                if(item.getQuantitySold().equals(quantityMin)){
                    finalExcessProductStatisticList.add(item);
                }
                else break;
            }

            if(idxMin != excessProductStatisticList.size()){
                quantityMin = excessProductStatisticList.get(idxMin).getQuantitySold();

                // Find all product with Max quantity 2nd
                for( ; idxMin < excessProductStatisticList.size() ; idxMin++){
                    ExcessProductStatistic item = excessProductStatisticList.get(idxMin);

                    if(item.getQuantitySold().equals(quantityMin)){
                        finalExcessProductStatisticList.add(item);
                    }
                    else break;
                }
            }
        }

        return finalExcessProductStatisticList;
    }

    public List<OrderDetailsEntity> filterOrderDetails(OrderEntity orderEntity){
        List<OrderDetailsEntity> orderDetailsEntities = orderDetailsRepository.findAllByCreatedAtModified(orderEntity.getCreatedAt().toString().split(" ")[0]);
        String orderIdString = orderEntity.getId().toString();

        return orderDetailsEntities.stream()
                .filter(x -> passwordEncoder.matches(orderIdString, x.getOrderId()))
                .collect(Collectors.toList());
    }
}
