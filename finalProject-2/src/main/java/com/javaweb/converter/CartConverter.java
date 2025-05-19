package com.javaweb.converter;

import com.javaweb.entity.CartEntity;
import com.javaweb.model.dto.CartDTO;
import com.javaweb.model.dto.ProductDTO;
import com.javaweb.model.dto.UserDTO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class CartConverter {
    private final ModelMapper modelMapper;

    public CartDTO convertToDTO(CartEntity cartEntity) {
        if(cartEntity == null) return null;
        CartDTO cartDTO = modelMapper.map(cartEntity, CartDTO.class);

        cartDTO.setProductDTO(modelMapper.map(cartEntity.getProductEntity(), ProductDTO.class));
        cartDTO.setUserDTO(modelMapper.map(cartEntity.getUserEntity(), UserDTO.class));

        return cartDTO;
    }
}
