package com.javaweb.service.productInventory;

import com.javaweb.model.dto.ProductInventoryDTO;
import com.javaweb.model.request.ProductInventorySearchRequest;
import com.javaweb.model.response.ProductInventorySearchResponse;
import org.springframework.data.domain.Pageable;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface IProductInventoryService {
    List<ProductInventorySearchResponse> findAll(ProductInventorySearchRequest productInventorySearchRequest, Pageable pageable);
    List<ProductInventoryDTO> findAllUnusedNotPaging();
    List<ProductInventoryDTO> findAllByIdNotPaging(List<Long> ids);
    List<ProductInventoryDTO> findAllExpiredNotPaging();
    List<ProductInventoryDTO> findAllLockedNotPaging();
    ProductInventoryDTO findOneById(Long id);
    Long findDropTotal(String date);

    Boolean updateProductInventory(HttpServletRequest request);
    int countTotalItems(ProductInventorySearchRequest productInventorySearchRequest);
}
