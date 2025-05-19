package com.javaweb.converter;

import com.javaweb.entity.CategoryEntity;
import com.javaweb.model.dto.CategoryDTO;
import com.javaweb.model.response.CategorySearchResponse;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.ObjectUtils;

@Component
public class CategoryConverter {
    @Autowired
    private ModelMapper modelMapper;

    public CategoryEntity convertToEntity(CategoryDTO categoryDTO){
        return modelMapper.map(categoryDTO, CategoryEntity.class);
    }

    public CategoryDTO convertToDTO(CategoryEntity categoryEntity){
        if(ObjectUtils.isEmpty(categoryEntity)) return null;
        return modelMapper.map(categoryEntity, CategoryDTO.class);
    }

    public CategorySearchResponse convertToResponseDTO(CategoryEntity categoryEntity){
        return modelMapper.map(categoryEntity, CategorySearchResponse.class);
    }
}
