package com.javaweb.api.web;

import com.javaweb.constant.SystemConstant;
import com.javaweb.model.dto.ProductDTO;
import com.javaweb.model.response.ResponseDTO;
import com.javaweb.service.product.IProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/products")
@RequiredArgsConstructor
public class ProductAPI_User {
    private final IProductService productService;

    @GetMapping(value = "/search")
    public ResponseEntity<?> getProductName(@RequestParam("name") String name) {
        ResponseDTO responseDTO = new ResponseDTO();

        try{
            List<ProductDTO> products = productService.findByNameContaining(name);

            if(products.isEmpty()){
                responseDTO.setMessage("Không tìm thấy sản phẩm");
            }

            responseDTO.setData(products);

            return ResponseEntity.ok(responseDTO);
        }
        catch (Exception ex){
            responseDTO.setData(SystemConstant.ERROR_SYSTEM);
            responseDTO.setMessage(ex.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseDTO);
        }
    }

//    @GetMapping(value = "/bought")
//    public ResponseEntity<?> getProductBought(@RequestParam("name") String name) {
//        ResponseDTO responseDTO = new ResponseDTO();
//
//        try{
//            List<ProductDTO> products = productService.findByNameContaining(name);
//
//            if(products.isEmpty()){
//                responseDTO.setMessage("Không tìm thấy sản phẩm");
//            }
//
//            responseDTO.setData(products);
//
//            return ResponseEntity.ok(responseDTO);
//        }
//        catch (Exception ex){
//            responseDTO.setData(SystemConstant.ERROR_SYSTEM);
//            responseDTO.setMessage(ex.getMessage());
//            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseDTO);
//        }
//    }
}
