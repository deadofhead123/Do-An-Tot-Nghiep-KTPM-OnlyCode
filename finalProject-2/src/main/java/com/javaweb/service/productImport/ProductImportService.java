package com.javaweb.service.productImport;

import com.javaweb.converter.SupplierConverter;
import com.javaweb.converter.SupplyDetailsConverter;
import com.javaweb.entity.ProductEntity;
import com.javaweb.entity.ProductInventoryEntity;
import com.javaweb.entity.SupplierEntity;
import com.javaweb.entity.SupplyDetailsEntity;
import com.javaweb.model.dto.SupplierDTO;
import com.javaweb.model.dto.SupplyDetailsDTO;
import com.javaweb.model.request.SupplierSearchRequest;
import com.javaweb.model.dto.ProductImport;
import com.javaweb.model.response.SupplierSearchResponse;
import com.javaweb.repository.ProductInventoryRepository;
import com.javaweb.repository.ProductRepository;
import com.javaweb.repository.SupplierRepository;
import com.javaweb.repository.SupplyDetailsRepository;
import com.javaweb.util.ProductInventoryStatus;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
@RequiredArgsConstructor
public class ProductImportService implements IProductImportService{
    private final ProductRepository productRepository;
    private final SupplierRepository supplierRepository;
    private final SupplyDetailsRepository supplyDetailsRepository;
    private final ProductInventoryRepository productInventoryRepository;
    private final SupplierConverter supplierConverter;
    private final SupplyDetailsConverter supplyDetailsConverter;

    @Override
    public List<SupplierSearchResponse> findAll(SupplierSearchRequest supplierSearchRequest, Pageable pageable) {
        List<SupplierEntity> supplierEntities = supplierRepository.findAll(supplierSearchRequest, pageable);

        return supplierEntities.stream().map(supplierConverter::convertToSearchResponseDTO).collect(Collectors.toList());
    }

    @Override
    public SupplierDTO findOneById(Long id) {
        return supplierConverter.convertToDTO(supplierRepository.getOne(id));
    }

    @Override
    public List<SupplyDetailsDTO> findBySupplierId(Long supplierId) {
        List<SupplyDetailsEntity> supplyDetailsEntities = supplyDetailsRepository.findAllBySupplierEntity(supplierRepository.getOne(supplierId));
        return supplyDetailsEntities.stream().map(supplyDetailsConverter::convertToDTO).collect(Collectors.toList());
    }

    @Override
    public Long findImportTotal(String date) {
        Long importTotal = supplierRepository.findImportTotalByDate(date);
        if(importTotal == null) return 0L;
        return importTotal;
    }

    @Override
    public SupplierDTO createImport(SupplierDTO supplierDTO, HttpServletRequest request) {
        List<ProductImport> productImportList;
        HttpSession session = request.getSession();

        // Create supplier entity
        SupplierEntity supplierEntity = supplierConverter.convertToEntity(supplierDTO);
        Long total = 0L;

        if(session.getAttribute("productImportList") != null){
            productImportList = (List<ProductImport>)session.getAttribute("productImportList");
        }
        else{
            return null;
        }

        // Create supply_detail entities
        for(ProductImport productImport : productImportList){
            total += productImport.getQuantity() * productImport.getPrice();

            SupplyDetailsEntity supplyDetailsEntity = new SupplyDetailsEntity();
            supplyDetailsEntity.setQuantity(productImport.getQuantity());
            supplyDetailsEntity.setPrice(productImport.getPrice());

            ProductEntity productEntity = productRepository.getOne(productImport.getId());

            Long quantity = productImport.getQuantity();
            for(Long i = 1L ; i <= quantity ; i++){
                ProductInventoryEntity productInventoryEntity = new ProductInventoryEntity();
                productInventoryEntity.setProductEntity(productEntity);
                productInventoryEntity.setSupplierEntity(supplierEntity);
                productInventoryEntity.setPriceInImport(productImport.getPrice());
                productInventoryEntity.setExpiredAt(LocalDateTime.now().plusDays(productEntity.getExpiration()));
                productInventoryEntity.setStatus(ProductInventoryStatus.UNUSED.toString());
                productInventoryRepository.save(productInventoryEntity);
            }

            productEntity.setQuantity(productEntity.getQuantity() + productImport.getQuantity());
            supplyDetailsEntity.setProductEntity(productEntity);
            productRepository.save(productEntity);

            supplyDetailsEntity.setSupplierEntity(supplierEntity);
            supplyDetailsRepository.save(supplyDetailsEntity);
        }

        supplierEntity.setTotalOfImport(total);

        session.removeAttribute("productImportList");

        return supplierConverter.convertToDTO(supplierRepository.save(supplierEntity));
    }

    @Override
    public int countTotalItems(SupplierSearchRequest supplierSearchRequest) {
        return supplierRepository.countTotalItems(supplierSearchRequest);
    }
}
