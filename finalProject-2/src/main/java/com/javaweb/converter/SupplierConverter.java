package com.javaweb.converter;

import com.javaweb.entity.SupplierEntity;
import com.javaweb.model.dto.SupplierDTO;
import com.javaweb.model.response.SupplierSearchResponse;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class SupplierConverter {
    private final ModelMapper modelMapper;

    public SupplierEntity convertToEntity(SupplierDTO supplierDTO){
        return modelMapper.map(supplierDTO, SupplierEntity.class);
    }

    public SupplierDTO convertToDTO(SupplierEntity supplierEntity){
        if(supplierEntity == null) return null;
        return modelMapper.map(supplierEntity, SupplierDTO.class);
    }

    public SupplierSearchResponse convertToSearchResponseDTO(SupplierEntity supplierEntity){
        return modelMapper.map(supplierEntity, SupplierSearchResponse.class);
    }
}
