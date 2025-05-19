package com.javaweb.repository.custom;

import com.javaweb.entity.FeedbackEntity;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface FeedbackRepositoryCustom {
    List<FeedbackEntity> findAll(Long productId, Pageable pageable);
    List<FeedbackEntity> findAll_Web(Long productId, Integer size);
    int countTotalItems(Long productId);
}
