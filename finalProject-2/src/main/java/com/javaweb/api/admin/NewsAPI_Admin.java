package com.javaweb.api.admin;

import com.javaweb.constant.SystemConstant;
import com.javaweb.model.dto.NewsDTO;
import com.javaweb.model.response.ResponseDTO;
import com.javaweb.service.news.INewsService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping(value = "/api/admin/news")
@RequiredArgsConstructor
public class NewsAPI_Admin {
    private final INewsService newsService;

    @PostMapping
    public ResponseEntity<?> createOrUpdateNews(@Valid @RequestBody NewsDTO newsDTO, BindingResult bindingResult) {
        ResponseDTO responseDTO = new ResponseDTO();

        try{
            if(bindingResult.hasErrors()){
                List<String> errors = bindingResult.getFieldErrors()
                        .stream()
                        .map(FieldError::getDefaultMessage)
                        .collect(Collectors.toList());
                responseDTO.setMessage("Lỗi nhập dữ liệu:");
                responseDTO.setDetails(errors);
            }

            newsService.editNews(newsDTO);

            if(newsDTO.getId() == null){
                responseDTO.setMessage("Thêm tin tức thành công!");
                responseDTO.setData(SystemConstant.INSERT_SUCCESS);
            }
            else{
                responseDTO.setMessage("Sửa tin tức thành công!");
                responseDTO.setData(SystemConstant.UPDATE_SUCCESS);
            }

            return ResponseEntity.ok(responseDTO);
        }
        catch (Exception ex){
            responseDTO.setData(SystemConstant.ERROR_SYSTEM);
            responseDTO.setMessage("Lỗi máy chủ, vui lòng thử lại!");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseDTO);
        }
    }

    @PatchMapping(value = "/{ids}")
    public ResponseEntity<?> deleteNews(@PathVariable("ids") List<Long> ids) {
        ResponseDTO responseDTO = new ResponseDTO();

        try{
            newsService.deleteAllNewsSelected(ids);

            responseDTO.setMessage("Xóa tin tức thành công!");
            responseDTO.setData(SystemConstant.DELETE_SUCCESS);
            return ResponseEntity.ok(responseDTO);
        }
        catch (Exception ex){
            responseDTO.setData(SystemConstant.ERROR_SYSTEM);
            responseDTO.setMessage("Lỗi máy chủ, vui lòng thử lại!");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseDTO);
        }
    }
}
