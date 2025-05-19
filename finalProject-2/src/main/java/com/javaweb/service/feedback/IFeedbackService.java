package com.javaweb.service.feedback;

import com.javaweb.model.dto.FeedbackDTO;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface IFeedbackService {
    List<FeedbackDTO> findAllFeedback_Web(Long productId, Integer size);
    List<FeedbackDTO> findAllFeedback(Long productId, Pageable pageable);
    int countTotalItems(Long productId);
    FeedbackDTO createFeedback(FeedbackDTO feedbackDTO);
}
