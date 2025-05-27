package com.javaweb.service.feedback;

import com.javaweb.converter.FeedbackConverter;
import com.javaweb.entity.FeedbackEntity;
import com.javaweb.entity.ProductEntity;
import com.javaweb.entity.UserEntity;
import com.javaweb.model.dto.FeedbackDTO;
import com.javaweb.repository.*;
import com.javaweb.security.utils.SecurityUtils;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
@RequiredArgsConstructor
public class FeedbackService implements IFeedbackService{
    private final FeedbackRepository feedbackRepository;
    private final ProductRepository productRepository;
    private final UserRepository userRepository;
    private final OrderRepository orderRepository;
    private final OrderDetailsRepository orderDetailsRepository;
    private final FeedbackConverter feedbackConverter;
    private final PasswordEncoder passwordEncoder;

    @Override
    public List<FeedbackDTO> findAllFeedback_Web(Long productId, Integer size) {
        List<FeedbackEntity> feedbackEntities = feedbackRepository.findAll_Web(productId, size);

        return feedbackEntities.stream().map(feedbackConverter::convertToDTO).collect(Collectors.toList());
    }

    @Override
    public List<FeedbackDTO> findAllFeedback(Long productId, Pageable pageable) {
        List<FeedbackEntity> feedbackEntities = feedbackRepository.findAll(productId, pageable);

        return feedbackEntities.stream().map(feedbackConverter::convertToDTO).collect(Collectors.toList());
    }

    @Override
    public int countTotalItems(Long productId) {
        return feedbackRepository.countTotalItems(productId);
    }

    @Override
    public FeedbackDTO createFeedback(FeedbackDTO feedbackDTO) {
        UserEntity userEntity = userRepository.getOne(SecurityUtils.getPrincipal().getId());
        ProductEntity productEntity = productRepository.getOne(feedbackDTO.getProductId());

        String productBought = userEntity.getProductBought();

        if(productBought != null){
            String[] productBoughtSplit = productBought.split(",");
            String productIdString = productEntity.getId().toString();

            for(String item : productBoughtSplit){
                if(item.equals(productIdString)){
                    // Create feedback
                    FeedbackEntity feedbackEntity = new FeedbackEntity();

                    feedbackEntity.setUserEntity(userEntity);
                    feedbackEntity.setProductEntity(productEntity);
                    feedbackEntity.setContent(feedbackDTO.getContent());
                    feedbackEntity.setRating(feedbackDTO.getRating());

                    return feedbackConverter.convertToDTO(feedbackRepository.save(feedbackEntity));
                }
            }
        }

        return null;
    }
}
