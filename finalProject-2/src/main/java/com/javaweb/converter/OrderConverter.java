package com.javaweb.converter;

import com.javaweb.entity.OrderEntity;
import com.javaweb.model.dto.OrderDTO;
import com.javaweb.model.dto.UserDTO;
import com.javaweb.model.response.OrderSearchResponse;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class OrderConverter {
    private final ModelMapper modelMapper;

    public OrderEntity convertToEntity(OrderDTO orderDTO){
        return modelMapper.map(orderDTO, OrderEntity.class);
    }

    public OrderDTO convertToDTO(OrderEntity orderEntity){
        if(orderEntity == null) return null;
        OrderDTO orderDTO = modelMapper.map(orderEntity, OrderDTO.class);

        orderDTO.setUserDTO(modelMapper.map(orderEntity.getUserEntity(), UserDTO.class));

        return orderDTO;
    }

    public OrderSearchResponse convertToSearchResponseDTO(OrderEntity orderEntity){
        OrderSearchResponse orderSearchResponse = modelMapper.map(orderEntity, OrderSearchResponse.class);

        orderSearchResponse.setTotalFinal(orderEntity.getTotal() - orderEntity.getDiscount());

        return orderSearchResponse;
    }
}
