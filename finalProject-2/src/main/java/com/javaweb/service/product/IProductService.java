package com.javaweb.service.product;

import com.javaweb.model.dto.ProductDTO;
import com.javaweb.model.request.ProductSearchRequest;
import com.javaweb.model.response.ProductSearchResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface IProductService {
    List<ProductSearchResponse> findAll(ProductSearchRequest request, Pageable pageable);
    List<ProductDTO> findAllActiveWithoutPaging();
    Page<ProductSearchResponse> findAll_Web(ProductSearchRequest request, Pageable pageable);
    List<ProductDTO> findByNameContaining(String name);
    ProductDTO findOneByName(String name);
    ProductDTO findOneById(Long id);
    List<ProductDTO> findAllById(List<Long> ids);
    List<ProductDTO> findAllNearOutOfQuantity();
    List<ProductDTO> findRelatedProducts(Long productId, Long categoryId);
    Long findQuantitySold(Long productId);
    List<ProductDTO> findAllHotProduct();
    List<ProductDTO> findAllByUser();

    int countTotalItems(ProductSearchRequest request);
    void editProduct(ProductDTO productDTO);
    void deleteProducts(List<Long> ids, HttpServletRequest request);
    void applyDiscount(List<Long> ids, Long discount);
}
