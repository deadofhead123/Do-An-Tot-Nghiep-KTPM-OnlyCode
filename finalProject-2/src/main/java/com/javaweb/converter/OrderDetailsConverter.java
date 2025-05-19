package com.javaweb.converter;

import com.javaweb.entity.OrderDetailsEntity;
import com.javaweb.model.dto.OrderDetailsDTO;
import com.javaweb.model.dto.ProductDTO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class OrderDetailsConverter {
    private final ModelMapper modelMapper;

    public OrderDetailsDTO convertToDTO(OrderDetailsEntity orderDetailsEntity){
        if(orderDetailsEntity == null) return null;

        OrderDetailsDTO orderDetailsDTO = modelMapper.map(orderDetailsEntity, OrderDetailsDTO.class);

        orderDetailsDTO.setProductDTO(modelMapper.map(orderDetailsEntity.getProductEntity(), ProductDTO.class));

        return orderDetailsDTO;
    }
}
