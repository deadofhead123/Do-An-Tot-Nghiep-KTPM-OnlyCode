package com.javaweb.api.web;

import com.javaweb.model.dto.ProductDTO;
import com.javaweb.model.response.ResponseDTO;
import com.javaweb.service.cart.ICartService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(value = "/api/carts")
@RequiredArgsConstructor
public class CartAPI_User {
    private final ICartService cartService;

    @GetMapping
    public ResponseEntity<?> getQuantitySum(){
        ResponseDTO responseDTO = new ResponseDTO();

        try{
            responseDTO.setData(cartService.getQuantitySum());
            return ResponseEntity.ok(responseDTO);
        }
        catch (Exception e){
            responseDTO.setMessage("Có lỗi khi tính số lượng sản phẩm trong giỏ hàng !");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseDTO);
        }
    }

    @PostMapping
    public ResponseEntity<?> addFromShop(@RequestBody ProductDTO productDTO) {
        ResponseDTO responseDTO = new ResponseDTO();

        try{
            cartService.addToCart(productDTO);
            responseDTO.setMessage("Thêm sản phẩm vào giỏ hàng thành công !");
            return ResponseEntity.ok(responseDTO);
        }
        catch (Exception e){
            responseDTO.setMessage("Có lỗi khi thêm sản phẩm vào giỏ !");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseDTO);
        }
    }

    @PatchMapping
    public ResponseEntity<?> changeQuantity(@RequestParam("productId") Long productId, @RequestParam("quantity") Long quantity) {
        ResponseDTO responseDTO = new ResponseDTO();

        try{
            cartService.changeQuantity(productId, quantity);

            return ResponseEntity.ok(responseDTO);
        }
        catch (Exception e){
            responseDTO.setMessage("Có lỗi khi sửa số lượng sản phẩm !");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseDTO);
        }
    }

    @DeleteMapping(value = "/{ids}")
    public ResponseEntity<?> deleteProducts(@PathVariable("ids") List<Long> ids) {
        ResponseDTO responseDTO = new ResponseDTO();

        try{
            cartService.deleteProducts(ids);
            responseDTO.setMessage("Xóa sản phẩm thành công!");
            return ResponseEntity.ok(responseDTO);
        }
        catch (Exception e){
            responseDTO.setMessage("Có lỗi khi sửa số lượng sản phẩm !");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseDTO);
        }
    }
}
