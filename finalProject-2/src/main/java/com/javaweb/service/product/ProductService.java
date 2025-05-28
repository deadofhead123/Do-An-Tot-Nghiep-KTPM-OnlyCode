package com.javaweb.service.product;

import com.javaweb.constant.SessionConstant;
import com.javaweb.constant.SystemConstant;
import com.javaweb.converter.ProductConverter;
import com.javaweb.entity.OrderDetailsEntity;
import com.javaweb.entity.OrderEntity;
import com.javaweb.entity.ProductCategoryEntity;
import com.javaweb.entity.ProductEntity;
import com.javaweb.model.dto.ProductDTO;
import com.javaweb.model.dto.ProductDropDTO;
import com.javaweb.model.dto.ProductImport;
import com.javaweb.model.request.ProductSearchRequest;
import com.javaweb.model.response.ProductSearchResponse;
import com.javaweb.repository.*;
import com.javaweb.security.utils.SecurityUtils;
import com.javaweb.util.OrderStatusCode;
import com.javaweb.util.UploadFileUtils;
import lombok.RequiredArgsConstructor;
import org.apache.tomcat.util.codec.binary.Base64;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
@RequiredArgsConstructor
public class ProductService implements IProductService{
    private final ProductRepository productRepository;
    private final ProductCategoryRepository productCategoryRepository;
    private final CartRepository cartRepository;
    private final OrderRepository orderRepository;
    private final OrderDetailsRepository orderDetailsRepository;
    private final ProductInventoryRepository productInventoryRepository;
    private final ProductConverter productConverter;
    private final PasswordEncoder passwordEncoder;
    private final UploadFileUtils uploadFileUtils;
    private final UserRepository userRepository;

    @Override
    public List<ProductSearchResponse> findAll(ProductSearchRequest request, Pageable pageable) {
        List<ProductEntity> productEntities = productRepository.findAll(request, pageable);

        return productEntities.stream().map(productConverter::convertToSearchResponse).collect(Collectors.toList());
    }

    @Override
    public List<ProductDTO> findAllActiveWithoutPaging() {
        List<ProductEntity> productEntities = productRepository.findByIsActive(1);
        return productEntities.stream().map(productConverter::convertToDTO).collect(Collectors.toList());
    }

    @Override
    public Page<ProductSearchResponse> findAll_Web(ProductSearchRequest productSearchRequest, Pageable pageable) {
        Page<ProductEntity> productEntities = productRepository.findAll_Web(productSearchRequest, pageable);

        return productEntities.map(productConverter::convertToSearchResponse);
    }

    @Override
    public List<ProductDTO> findByNameContaining(String name) {
        List<ProductEntity> productEntities = productRepository.findByNameContainingAndIsActive(name, 1);

        return productEntities.stream().map(productConverter::convertToDTO).collect(Collectors.toList());
    }

    @Override
    public ProductDTO findOneByName(String name) {
        return productConverter.convertToDTO(productRepository.findByNameAndIsActive(name, 1));
    }

    @Override
    public ProductDTO findOneById(Long id) {
        return productConverter.convertToDTO(productRepository.findByIdAndIsActive(id, 1));
    }

    @Override
    public List<ProductDTO> findAllById(List<Long> ids) {
        List<ProductEntity> productEntities = productRepository.findAllById(ids).stream().filter(x -> x.getIsActive() == 1).collect(Collectors.toList());
        return productEntities.stream().map(productConverter::convertToDTO).collect(Collectors.toList());
    }

    @Override
    public List<ProductDTO> findAllNearOutOfQuantity() {
        List<ProductEntity> productEntities = productRepository.findAllNearOutOfQuantity(SystemConstant.NEAR_OUT_OF_QUANTITY);
        return productEntities.stream().map(productConverter::convertToDTO).collect(Collectors.toList());
    }

    @Override
    public List<ProductDTO> findRelatedProducts(Long productId, Long categoryId) {
        List<ProductDTO> productDTOList = new ArrayList<>();
        List<ProductCategoryEntity> productCategoryEntities = productCategoryRepository.findAllByCategoryId(categoryId);

        for(ProductCategoryEntity item : productCategoryEntities){
            Long productIdOfItem = item.getProductId();
            if(!productIdOfItem.equals(productId) && productDTOList.size() != 4){
                productDTOList.add(productConverter.convertToDTO(productRepository.getOne(productIdOfItem)));
            }
        }

        return productDTOList;
    }

    @Override
    public Long findQuantitySold(Long productId) {
        List<OrderEntity> orderDelivered = orderRepository.findAllByStatus(OrderStatusCode.DELIVERED.toString());
        List<OrderDetailsEntity> orderDetailsEntities = orderDetailsRepository.findAllByProductEntity(productRepository.getOne(productId));
        Long quantitySold = 0L;

        for(OrderEntity item : orderDelivered){
            String orderId = item.getId().toString();
            List<OrderDetailsEntity> orderDetailsFiltered = orderDetailsEntities
                                                            .stream()
                                                            .filter(x -> passwordEncoder.matches(orderId, x.getOrderId()))
                                                            .collect(Collectors.toList());

            for(OrderDetailsEntity itemFilter : orderDetailsFiltered){
                quantitySold += itemFilter.getQuantity();
            }
        }

        return quantitySold;
    }

    @Override
    public List<ProductDTO> findAllHotProduct() {
        List<ProductEntity> productEntities = productRepository.findHotWithLimit();

        return productEntities.stream().map(productConverter::convertToDTO).collect(Collectors.toList());
    }

    @Override
    public List<ProductDTO> findAllByUser() {
        String productBought = userRepository.getOne(SecurityUtils.getPrincipal().getId()).getProductBought();
        List<ProductEntity> productEntities = new ArrayList<>();

        if(productBought != null){
            String[] productBoughtSplit = productBought.split(",");

            for(String item : productBoughtSplit){
                Long id = Long.parseLong(item);

                productEntities.add(productRepository.getOne(id));
            }
        }

        return productEntities.stream().filter(x -> x.getIsActive() == 1).map(productConverter::convertToDTO).collect(Collectors.toList());
    }

    @Override
    public int countTotalItems(ProductSearchRequest request) {
        return productRepository.countTotalItems(request);
    }

    @Override
    public void editProduct(ProductDTO productDTO) {
        ProductEntity productEdit;
        ProductEntity existedProduct = productRepository.findByNameAndIsActive(productDTO.getName(), 1);

        if(productDTO.getId() != null){
            existedProduct = productRepository.findById(productDTO.getId()).get();
        }
        else{
            if(existedProduct != null){
                throw new DataIntegrityViolationException("Tên sản phẩm này đã tồn tại, vui lòng nhập tên khác!");
            }
        }

        productEdit = productConverter.convertToEntity(productDTO, existedProduct);

        saveImages(productDTO, productEdit);

        productRepository.save(productEdit);
    }

    @Override
    public void deleteProducts(List<Long> ids, HttpServletRequest request) {
        List<ProductEntity> productEntities = productRepository.findAllById(ids);
        HttpSession session = request.getSession();

        // "Delete" in tables: products, product_inventory
        // Delete in session, cart
        productEntities.forEach(productEntity -> {
            productEntity.setIsActive(0);

            cartRepository.deleteAllByProductEntity(productEntity);

            List<ProductImport> productImportList = (List<ProductImport>) session.getAttribute(SessionConstant.PRODUCT_IMPORT_LIST_SESSION_NAME);
            if(productImportList != null){
                productImportList.stream().filter(x -> x.getId().equals(productEntity.getId())).findFirst().ifPresent(productImportList::remove);
            }

            List<ProductDropDTO> productDropList = (List<ProductDropDTO>) session.getAttribute(SessionConstant.PRODUCT_DROP_LIST_SESSION_NAME);
            if(productDropList != null){
                productDropList.stream().filter(x -> x.getId().equals(productEntity.getId())).findFirst().ifPresent(productDropList::remove);
            }

            productInventoryRepository.lockAllByProductId(productEntity.getId());
        });

        productRepository.saveAll(productEntities);
    }

    @Override
    public void applyDiscount(List<Long> ids, Long discount) {
        List<ProductEntity> productEntities = productRepository.findAllById(ids);

        for(int i = 0 ; i < productEntities.size() ; i++){
            productEntities.get(i).setDiscount(discount);
        }

        productRepository.saveAll(productEntities);
    }

    // Save images
    private void saveImages(ProductDTO productDTO, ProductEntity productEntity) {
        String path = "/products/" + productDTO.getImageName();

        if ( productDTO.getImageBase64() != null ) {
            if ( productEntity.getImage() != null ) {
                if (!path.equals(productEntity.getImage())) {
                    File file = new File(SystemConstant.IMAGE_SAVE_PATH + productEntity.getImage());
                    file.delete();
                }
            }

            byte[] bytes = Base64.decodeBase64(productDTO.getImageBase64().getBytes());

            uploadFileUtils.writeOrUpdate(path, bytes);
            productEntity.setImage(path);
        }
    }
}
