package com.javaweb.service.cart;

import com.javaweb.converter.CartConverter;
import com.javaweb.entity.CartEntity;
import com.javaweb.entity.ProductEntity;
import com.javaweb.entity.UserEntity;
import com.javaweb.model.dto.CartDTO;
import com.javaweb.model.dto.ProductDTO;
import com.javaweb.repository.CartRepository;
import com.javaweb.repository.CategoryRepository;
import com.javaweb.repository.ProductRepository;
import com.javaweb.repository.UserRepository;
import com.javaweb.security.utils.SecurityUtils;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
@RequiredArgsConstructor
public class CartService implements ICartService{
    private final CartRepository cartRepository;
    private final UserRepository userRepository;
    private final ProductRepository productRepository;
    private final CartConverter cartConverter;
    private final CategoryRepository categoryRepository;

    @Override
    public List<CartDTO> findAll() {
        List<CartEntity> cartEntities = cartRepository.findAllByUserEntity(userRepository.getOne(SecurityUtils.getPrincipal().getId()));
        return cartEntities.stream().map(cartConverter::convertToDTO).collect(Collectors.toList());
    }

    @Override
    public Long getQuantitySum() {
        List<CartEntity> cartEntities = cartRepository.findAllByUserEntity(userRepository.getOne(SecurityUtils.getPrincipal().getId()));
        Long quantitySum = 0L;

        for(CartEntity item : cartEntities) quantitySum += item.getQuantity();

        return quantitySum;
    }

    @Override
    public void addToCart(ProductDTO productDTO) {
        UserEntity userEntity = userRepository.getOne(SecurityUtils.getPrincipal().getId());

        ProductEntity productEntity = productRepository.getOne(productDTO.getId());

        CartEntity cartEntity = cartRepository.findOneByUserEntityAndProductEntity(userEntity, productEntity);

        if(cartEntity == null){
            cartEntity = new CartEntity();
            cartEntity.setProductEntity(productEntity);
            cartEntity.setUserEntity(userEntity);
            cartEntity.setQuantity(productDTO.getQuantity());
        }
        else{
            cartEntity.setQuantity(cartEntity.getQuantity() + productDTO.getQuantity());
        }

        cartRepository.save(cartEntity);
    }

    @Override
    public void changeQuantity(Long productId, Long quantity) {
        UserEntity userEntity = userRepository.getOne(SecurityUtils.getPrincipal().getId());

        ProductEntity productEntity = productRepository.getOne(productId);

        CartEntity cartEntity = cartRepository.findOneByUserEntityAndProductEntity(userEntity, productEntity);

        cartEntity.setQuantity(quantity);

        cartRepository.save(cartEntity);
    }

    @Override
    public void deleteProducts(List<Long> productIds) {
        UserEntity userEntity = userRepository.getOne(SecurityUtils.getPrincipal().getId());
        List<ProductEntity> productEntities = productRepository.findAllById(productIds);

        for(ProductEntity productEntity : productEntities){
            cartRepository.deleteAllByUserEntityAndProductEntity(userEntity, productEntity);
        }
    }
}
