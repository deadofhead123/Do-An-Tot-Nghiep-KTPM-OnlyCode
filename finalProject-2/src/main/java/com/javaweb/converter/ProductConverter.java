package com.javaweb.converter;

import com.javaweb.entity.CategoryEntity;
import com.javaweb.entity.ProductEntity;
import com.javaweb.model.dto.ProductDTO;
import com.javaweb.model.response.ProductSearchResponse;
import com.javaweb.service.category.ICategoryService;
import com.javaweb.util.HotType;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
@RequiredArgsConstructor
public class ProductConverter {
    private final ModelMapper modelMapper;
    private final ICategoryService categoryService;

    public ProductEntity convertToEntity(ProductDTO productDTO, ProductEntity oldProductEntity){
        ProductEntity latestProductEntity = modelMapper.map(productDTO, ProductEntity.class);

        if(oldProductEntity == null){
            latestProductEntity.setQuantity(0L);
            latestProductEntity.setSold(0L);
            latestProductEntity.setDiscount(0L);
            latestProductEntity.setHot(HotType.NO.toString());
        }
        else{
            latestProductEntity.setImage(oldProductEntity.getImage());
            latestProductEntity.setCreatedAt(oldProductEntity.getCreatedAt());
            latestProductEntity.setCreatedBy(oldProductEntity.getCreatedBy());
        }

        // Set product's category
        List<CategoryEntity> categoryEntities = new ArrayList<>();

        CategoryEntity categoryEntity = categoryService.findOneById_Entity(productDTO.getCategoryId());
        categoryEntities.add(categoryEntity);

        // Check if exists parent category
        if(categoryEntity.getParentId() != null){
            CategoryEntity parentCategoryEntity = categoryService.findOneById_Entity(categoryEntity.getParentId());
            categoryEntities.add(parentCategoryEntity);
        }

        latestProductEntity.setCategoryEntities(categoryEntities);


        latestProductEntity.setIsActive(1);

        return latestProductEntity;
    }

    public ProductDTO convertToDTO(ProductEntity productEntity){
        if(productEntity == null) return null;
        else{
            ProductDTO productDTO = modelMapper.map(productEntity, ProductDTO.class);

            List<CategoryEntity> categoryEntities = productEntity.getCategoryEntities();

            if(categoryEntities.size() == 1) productDTO.setCategoryId(categoryEntities.get(0).getId());
            else{
                if(categoryEntities.get(0).getParentId() != null) productDTO.setCategoryId(categoryEntities.get(0).getId());
                else productDTO.setCategoryId(categoryEntities.get(1).getId());
            }

            return productDTO;
        }
    }

    public ProductSearchResponse convertToSearchResponse(ProductEntity productEntity){
        return modelMapper.map(productEntity, ProductSearchResponse.class);
    }
}
