package com.javaweb.service.category;

import com.javaweb.converter.CategoryConverter;
import com.javaweb.entity.CategoryEntity;
import com.javaweb.model.dto.CategoryDTO;
import com.javaweb.model.request.CategorySearchRequest;
import com.javaweb.model.response.CategorySearchResponse;
import com.javaweb.repository.CategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

@Service
@Transactional
public class CategoryService implements ICategoryService {
    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private CategoryConverter categoryConverter;

    @Override
    public List<CategorySearchResponse> findAll(CategorySearchRequest categorySearchRequest, Pageable pageable) {
        List<CategoryEntity> categoryEntities = categoryRepository.findAll(categorySearchRequest, pageable);
        List<CategorySearchResponse> categorySearchResponseList = new ArrayList<>();

        for(CategoryEntity categoryEntity : categoryEntities) {
            categorySearchResponseList.add(categoryConverter.convertToResponseDTO(categoryEntity));
        }

        return categorySearchResponseList;
    }

    @Override
    public Map<Long, String> findAllNotPaging() {
        List<CategoryEntity> categoryEntities = categoryRepository.findAll();
        Map<Long, String> allCategory = new LinkedHashMap<>();

        for(CategoryEntity categoryEntity : categoryEntities) {
            if(categoryEntity.getParentId() == null){
                allCategory.put(categoryEntity.getId(), "____" + categoryEntity.getName() + " (danh mục cha)");
                   List<CategoryEntity> childCategories = categoryEntities.stream().filter(x -> x.getParentId() == categoryEntity.getId()).collect(Collectors.toList());

                   for(CategoryEntity item : childCategories){
                       allCategory.put(item.getId(), "- " + item.getName());
                   }
            }
        }

        return allCategory;
    }

    @Override
    public List<CategoryDTO> findAllNotPaging_2() {
        List<CategoryEntity> categoryEntities = categoryRepository.findAll();
        List<CategoryEntity> categoryEntitiesSorted = new ArrayList<>();

        for(CategoryEntity categoryEntity : categoryEntities) {
            if(categoryEntity.getParentId() == null){
                categoryEntitiesSorted.add(categoryEntity);

                List<CategoryEntity> childCategories = categoryEntities.stream()
                                                        .filter(x -> x.getParentId() != null && x.getParentId().equals(categoryEntity.getId()))
                                                        .collect(Collectors.toList());
                for(CategoryEntity item : childCategories){
                    categoryEntitiesSorted.add(item);
                }
            }
        }

        return categoryEntitiesSorted.stream().map(categoryConverter::convertToDTO).collect(Collectors.toList());
    }

    @Override
    public CategoryDTO findOneById(Long id) {
        return categoryConverter.convertToDTO(categoryRepository.findByIdAndIsActive(id, 1));
    }

    @Override
    public CategoryEntity findOneById_Entity(Long id) {
        return categoryRepository.findById(id).get();
    }

    @Override
    public Map<Long, String> findCategories(Long categoryId) {
        List<CategoryEntity> categoryEntities = categoryRepository.findAllByParentId(categoryId);
        Map<Long, String> result = new LinkedHashMap<>();

        for(CategoryEntity categoryEntity : categoryEntities) {
            result.put(categoryEntity.getId(), categoryEntity.getName());
        }

        return result;
    }

    @Override
    public CategoryDTO findOneByNameAndIsActive(String name, Integer isActive) {
        return categoryConverter.convertToDTO(categoryRepository.findByNameAndIsActive(name, 1));
    }

    @Override
    public int countTotalItems(CategorySearchRequest categorySearchRequest) {
        return categoryRepository.countTotalItems(categorySearchRequest);
    }

    @Override
    public CategoryDTO addOrUpdateCategory(CategoryDTO categoryDTO) {
        CategoryEntity categoryEntity = new CategoryEntity();
        CategoryEntity existedCategory = categoryRepository.findByNameAndIsActive(categoryDTO.getName(), 1);

        if( categoryDTO.getId() != null ) {
            categoryEntity = categoryRepository.findById(categoryDTO.getId()).get();
        }
        else{
            if(existedCategory != null){
                throw new DataIntegrityViolationException("Tên danh mục này đã tồn tại, vui lòng nhập tên khác!");
            }
        }

        categoryEntity.setName(categoryDTO.getName());
        categoryEntity.setDescription(categoryDTO.getDescription());
        categoryEntity.setIsActive(1);

        Long parentCategory = categoryDTO.getParentId();
        if(parentCategory != null){
            categoryEntity.setParentId(parentCategory);
        }

        return categoryConverter.convertToDTO(categoryRepository.save(categoryEntity));
    }

    @Override
    public Boolean deleteCategory(List<Long> ids) {
        try{
            List<CategoryEntity> categoryEntities = categoryRepository.findAllById(ids);

            // If delete a parent category, must delete all "parentid" related to it
            categoryEntities.forEach(categoryEntity -> {
                categoryEntity.setIsActive(0);

                if(categoryEntity.getParentId() == null) {
                    List<CategoryEntity> categoryEntityList = categoryRepository.findAllByParentId(categoryEntity.getId());
                    categoryEntityList.forEach(catgoryEntityListSub ->{
                        catgoryEntityListSub.setParentId(null);
                    });
                    categoryRepository.saveAll(categoryEntityList);
                }
            });

            categoryRepository.saveAll(categoryEntities);
            return true;
        }
        catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
