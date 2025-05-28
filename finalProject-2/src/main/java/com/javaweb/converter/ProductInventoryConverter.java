package com.javaweb.converter;

import com.javaweb.entity.ProductInventoryEntity;
import com.javaweb.model.dto.ProductDTO;
import com.javaweb.model.dto.ProductInventoryDTO;
import com.javaweb.model.response.ProductInventorySearchResponse;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class ProductInventoryConverter {
    @Autowired
    private ModelMapper modelMapper;

    public ProductInventorySearchResponse convertToSearchResponse(ProductInventoryEntity productInventoryEntity){
        ProductInventorySearchResponse productInventorySearchResponse = modelMapper.map(productInventoryEntity, ProductInventorySearchResponse.class);

        productInventorySearchResponse.setProductDTO(modelMapper.map(productInventoryEntity.getProductEntity(), ProductDTO.class));

        return productInventorySearchResponse;
    }

    public ProductInventoryDTO convertToDTO(ProductInventoryEntity productInventoryEntity){
        if(productInventoryEntity == null) return null;

        ProductInventoryDTO productInventoryDTO = modelMapper.map(productInventoryEntity, ProductInventoryDTO.class);

        productInventoryDTO.setName(productInventoryEntity.getProductEntity().getName());
        productInventoryDTO.setProductDTO(modelMapper.map(productInventoryEntity.getProductEntity(), ProductDTO.class));
        productInventoryDTO.setSupplierId(productInventoryEntity.getSupplierEntity().getId());

        return productInventoryDTO;
    }
}
