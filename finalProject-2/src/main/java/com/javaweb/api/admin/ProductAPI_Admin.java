package com.javaweb.api.admin;

import com.javaweb.constant.SystemConstant;
import com.javaweb.model.dto.ProductDTO;
import com.javaweb.model.response.ResponseDTO;
import com.javaweb.service.product.IProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@RestController
@RequestMapping(value = "/api/admin/products")
@RequiredArgsConstructor
public class ProductAPI_Admin {
    private final IProductService productService;

    @PostMapping
    public ResponseEntity<?> createOrUpdateProducts(@Valid @RequestBody ProductDTO productDTO, BindingResult bindingResult) {
        ResponseDTO responseDTO = new ResponseDTO();

        try{
            if(bindingResult.hasErrors()){
                List<String> errors = bindingResult.getFieldErrors()
                        .stream()
                        .map(FieldError::getDefaultMessage)
                        .collect(Collectors.toList());
                responseDTO.setMessage("Lỗi nhập dữ liệu:");
                responseDTO.setDetails(errors);
                return ResponseEntity.badRequest().body(responseDTO);
            }

            productService.editProduct(productDTO);

            if(productDTO.getId() == null){
                responseDTO.setMessage("Thêm sản phẩm thành công!");
                responseDTO.setData(SystemConstant.INSERT_SUCCESS);
            }
            else{
                responseDTO.setMessage("Sửa sản phẩm thành công!");
                responseDTO.setData(SystemConstant.UPDATE_SUCCESS);
            }

            return ResponseEntity.ok(responseDTO);
        }
        catch (Exception ex){
            responseDTO.setData(SystemConstant.ERROR_SYSTEM);
            responseDTO.setMessage(SystemConstant.SYSTEM_ERROR_MESSAGE);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseDTO);
        }
    }

    @GetMapping(value = "/search")
    public ResponseEntity<?> getProductByName(@RequestParam Map<String, Object> params) {
        ResponseDTO responseDTO = new ResponseDTO();

        try{
            List<ProductDTO> products;

            if(params.get("name") != null){
                products = productService.findByNameContaining(params.get("name").toString());
            }
            else if(params.get("ids") != null){
                products = productService.findAllById(Arrays.stream(params.get("ids").toString().split(",")).map(Long::parseLong).collect(Collectors.toList()));
            }
            else if(params.get("isOutOfQuantity") != null){
                products = productService.findAllNearOutOfQuantity();
            }
            else{
                products = productService.findAllActiveWithoutPaging();
            }

            if(products.isEmpty()){
                responseDTO.setMessage("Không tìm thấy sản phẩm");
            }

            responseDTO.setData(products);

            return ResponseEntity.ok(responseDTO);
        }
        catch (Exception ex){
            responseDTO.setData(SystemConstant.ERROR_SYSTEM);
            responseDTO.setMessage(SystemConstant.SYSTEM_ERROR_MESSAGE);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseDTO);
        }
    }

    @PatchMapping(value = "/{ids}")
    public ResponseEntity<?> deleteProducts(@PathVariable(name = "ids") List<Long> ids, HttpServletRequest request) {
        ResponseDTO responseDTO = new ResponseDTO();

        try{
            productService.deleteProducts(ids, request);

            responseDTO.setMessage("Xóa sản phẩm thành công!");
            responseDTO.setData(SystemConstant.DELETE_SUCCESS);
            return ResponseEntity.ok(responseDTO);
        }
        catch (Exception ex){
            responseDTO.setData(SystemConstant.ERROR_SYSTEM);
            responseDTO.setMessage(SystemConstant.SYSTEM_ERROR_MESSAGE);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseDTO);
        }
    }

    @PatchMapping(value = "/discount")
    public ResponseEntity<?> applyDiscount(@RequestParam(name = "ids") String ids, @RequestParam(name = "discountValue") Long discount) {
        ResponseDTO responseDTO = new ResponseDTO();

        try{
            productService.applyDiscount(Stream.of(ids.split(",")).map(Long::parseLong).collect(Collectors.toList()), discount);

            responseDTO.setMessage("Áp dụng giảm giá thành công!");
            responseDTO.setData(SystemConstant.DELETE_SUCCESS);
            return ResponseEntity.ok(responseDTO);
        }
        catch (Exception ex){
            responseDTO.setData(SystemConstant.ERROR_SYSTEM);
            responseDTO.setMessage(SystemConstant.SYSTEM_ERROR_MESSAGE);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseDTO);
        }
    }
}
