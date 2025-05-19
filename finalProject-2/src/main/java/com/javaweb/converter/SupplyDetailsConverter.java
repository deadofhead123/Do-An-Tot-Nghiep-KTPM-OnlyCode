package com.javaweb.converter;

import com.javaweb.entity.SupplyDetailsEntity;
import com.javaweb.model.dto.ProductDTO;
import com.javaweb.model.dto.SupplyDetailsDTO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class SupplyDetailsConverter {
    private final ModelMapper modelMapper;

    public SupplyDetailsDTO convertToDTO(SupplyDetailsEntity supplyDetailsEntity){
        if(supplyDetailsEntity == null) return null;
        SupplyDetailsDTO supplyDetailsDTO = modelMapper.map(supplyDetailsEntity, SupplyDetailsDTO.class);

        supplyDetailsDTO.setProductDTO(modelMapper.map(supplyDetailsEntity.getProductEntity(), ProductDTO.class));

        return supplyDetailsDTO;
    }
}
