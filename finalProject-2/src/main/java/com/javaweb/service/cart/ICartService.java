package com.javaweb.service.cart;

import com.javaweb.model.dto.CartDTO;
import com.javaweb.model.dto.ProductDTO;

import java.util.List;

public interface ICartService {
    List<CartDTO> findAll();
    Long getQuantitySum();
    void addToCart(ProductDTO productDTO);
    void changeQuantity(Long productId, Long quantity);
    void deleteProducts(List<Long> productId);
}
