package com.javaweb.service.category;

import com.javaweb.entity.CategoryEntity;
import com.javaweb.model.dto.CategoryDTO;
import com.javaweb.model.request.CategorySearchRequest;
import com.javaweb.model.response.CategorySearchResponse;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Map;

public interface ICategoryService {
     List<CategorySearchResponse> findAll(CategorySearchRequest parentRequest, Pageable pageable);
     Map<Long, String> findAllNotPaging();
     List<CategoryDTO> findAllNotPaging_2();
     CategoryDTO findOneById(Long id);
     CategoryEntity findOneById_Entity(Long id);
     Map<Long, String> findCategories(Long categoryId);
     CategoryDTO findOneByNameAndIsActive(String name, Integer isActive);

     int countTotalItems(CategorySearchRequest request);

     CategoryDTO addOrUpdateCategory(CategoryDTO categoryDTO);
     Boolean deleteCategory(List<Long> ids);
}
