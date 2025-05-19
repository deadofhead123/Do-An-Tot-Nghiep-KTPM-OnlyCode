package com.javaweb.api.web;

import com.javaweb.constant.SystemConstant;
import com.javaweb.model.response.ResponseDTO;
import com.javaweb.service.category.ICategoryService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/categories")
@RequiredArgsConstructor
public class CategoryAPI_User {
    private final ICategoryService categoryService;

    @GetMapping
    public ResponseEntity<?> getAllCategories(@RequestParam(name = "categoryId", required = false) Long categoryId) {
        ResponseDTO responseDTO = new ResponseDTO();

        try{
            responseDTO.setData(categoryService.findAllNotPaging_2());
            return ResponseEntity.ok(responseDTO);
        }
        catch (Exception e){
            responseDTO.setMessage(SystemConstant.SYSTEM_ERROR_MESSAGE);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseDTO);
        }
    }
}
