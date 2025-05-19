package com.javaweb.api.admin;

import com.javaweb.constant.SystemConstant;
import com.javaweb.model.dto.CategoryDTO;
import com.javaweb.model.response.ResponseDTO;
import com.javaweb.service.category.ICategoryService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(value = "/api/admin/categories")
@RequiredArgsConstructor
public class CategoryAPI {
    private final ICategoryService categoryService;

    @PostMapping
    public ResponseEntity<?> addOrUpdateCategory(@RequestBody CategoryDTO categoryDTO) {
        ResponseDTO responseDTO = new ResponseDTO();

        try{
            if(categoryDTO.getId() == null){
                CategoryDTO checkExistCategory = categoryService.findOneByNameAndIsActive(categoryDTO.getName(), 1);

                if(!ObjectUtils.isEmpty(checkExistCategory)){
                    responseDTO.setMessage("Danh mục có tên này đã tồn tại!");
                    return ResponseEntity.badRequest().body(responseDTO);
                }
            }

            CategoryDTO checkEdit = categoryService.addOrUpdateCategory(categoryDTO);

            if(ObjectUtils.isEmpty(checkEdit)){
                responseDTO.setMessage("Lỗi khi thêm danh mục!");
                return ResponseEntity.badRequest().body(responseDTO);
            }

            if(categoryDTO.getId() == null) responseDTO.setData(SystemConstant.INSERT_SUCCESS);
            else responseDTO.setData(SystemConstant.UPDATE_SUCCESS);

            responseDTO.setMessage("Thêm danh mục thành công!");
            return ResponseEntity.ok(responseDTO);
        }
        catch (Exception ex){
            responseDTO.setMessage(ex.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseDTO);
        }
    }

    @PatchMapping(value = "/{ids}")
    public ResponseEntity<?> deleteCategories(@PathVariable("ids") List<Long> ids){
        ResponseDTO responseDTO = new ResponseDTO();

        try{
            if(ids.isEmpty()){
                responseDTO.setMessage("Bạn chưa chọn danh mục cần xóa!");
                return ResponseEntity.badRequest().body(responseDTO);
            }

            Boolean checkDelete = categoryService.deleteCategory(ids);

            if(!checkDelete){
                responseDTO.setMessage("Lỗi khi xóa danh mục!");
                return ResponseEntity.badRequest().body(responseDTO);
            }

            responseDTO.setData(SystemConstant.DELETE_SUCCESS);

            responseDTO.setMessage("Xóa danh mục thành công!");
            return ResponseEntity.ok(responseDTO);
        }
        catch (Exception ex){
            responseDTO.setData(SystemConstant.ERROR_SYSTEM);
            responseDTO.setMessage("Lỗi máy chủ, vui lòng thử lại!");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseDTO);
        }
    }
}
