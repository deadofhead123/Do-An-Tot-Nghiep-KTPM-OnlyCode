package com.javaweb.service.productInventory;

import com.javaweb.constant.SessionConstant;
import com.javaweb.converter.ProductInventoryConverter;
import com.javaweb.entity.ProductInventoryEntity;
import com.javaweb.model.dto.ProductDropDTO;
import com.javaweb.model.dto.ProductInventoryDTO;
import com.javaweb.model.request.ProductInventorySearchRequest;
import com.javaweb.model.response.ProductInventorySearchResponse;
import com.javaweb.repository.ProductInventoryRepository;
import com.javaweb.util.ProductInventoryStatus;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
@RequiredArgsConstructor
public class ProductInventoryService implements IProductInventoryService {
    private final ProductInventoryRepository productInventoryRepository;
    private final ProductInventoryConverter productInventoryConverter;

    @Override
    public List<ProductInventorySearchResponse> findAll(ProductInventorySearchRequest productInventorySearchRequest, Pageable pageable) {
        List<ProductInventoryEntity> productInventoryEntities = productInventoryRepository.findAll(productInventorySearchRequest, pageable);
        return productInventoryEntities.stream().map(productInventoryConverter::convertToSearchResponse).collect(Collectors.toList());
    }

    @Override
    public List<ProductInventoryDTO> findAllUnusedNotPaging() {
        List<ProductInventoryEntity> productInventoryEntities = productInventoryRepository.findAllByStatus(ProductInventoryStatus.UNUSED.toString());
        return productInventoryEntities.stream().map(productInventoryConverter::convertToDTO).collect(Collectors.toList());
    }

    @Override
    public List<ProductInventoryDTO> findAllByIdNotPaging(List<Long> ids) {
        List<ProductInventoryEntity> productInventoryEntities = productInventoryRepository.findAllById(ids);
        return productInventoryEntities.stream().map(productInventoryConverter::convertToDTO).collect(Collectors.toList());
    }

    @Override
    public List<ProductInventoryDTO> findAllExpiredNotPaging() {
        List<ProductInventoryEntity> productInventoryEntities = productInventoryRepository.findAllExpired();
        return productInventoryEntities.stream().map(productInventoryConverter::convertToDTO).collect(Collectors.toList());
    }

    @Override
    public List<ProductInventoryDTO> findAllLockedNotPaging() {
        List<ProductInventoryEntity> productInventoryEntities = productInventoryRepository.findAllByStatus(ProductInventoryStatus.LOCKED.toString());
        return productInventoryEntities.stream().map(productInventoryConverter::convertToDTO).collect(Collectors.toList());
    }

    @Override
    public ProductInventoryDTO findOneById(Long id) {
        return productInventoryConverter.convertToDTO(productInventoryRepository.findOneById(id));
    }

    @Override
    public Long findDropTotal(String date) {

        return 0L;
    }

    @Override
    public Boolean updateProductInventory(HttpServletRequest request) {
        List<ProductDropDTO> productDropList;
        HttpSession session = request.getSession();

        if (session.getAttribute(SessionConstant.PRODUCT_DROP_LIST_SESSION_NAME) != null) {
            productDropList = (List<ProductDropDTO>) session.getAttribute(SessionConstant.PRODUCT_DROP_LIST_SESSION_NAME);
        } else {
            return false;
        }

        // Create product_drop entities
        for (ProductDropDTO productDropDTO : productDropList) {
            ProductInventoryEntity productInventoryEntity = productInventoryRepository.getOne(productDropDTO.getId());

            productInventoryEntity.setStatus(ProductInventoryStatus.CORRUPTED.toString());
            productInventoryEntity.setNote(productDropDTO.getNote());
            productInventoryEntity.getProductEntity().setQuantity(productInventoryEntity.getProductEntity().getQuantity() - 1);

            productInventoryRepository.save(productInventoryEntity);
        }

        session.removeAttribute("productDropList");

        return true;
    }

    @Override
    public int countTotalItems(ProductInventorySearchRequest productInventorySearchRequest) {
        return productInventoryRepository.countTotalItems(productInventorySearchRequest);
    }
}
