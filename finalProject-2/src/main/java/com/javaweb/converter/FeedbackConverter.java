package com.javaweb.converter;

import com.javaweb.entity.FeedbackEntity;
import com.javaweb.model.dto.FeedbackDTO;
import com.javaweb.model.dto.UserDTO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class FeedbackConverter {
    private final ModelMapper modelMapper;

    public FeedbackDTO convertToDTO(FeedbackEntity feedbackEntity){
        if(feedbackEntity == null) return null;

        FeedbackDTO feedbackDTO = modelMapper.map(feedbackEntity, FeedbackDTO.class);

        feedbackDTO.setUserDTO(modelMapper.map(feedbackEntity.getUserEntity(), UserDTO.class));

        return feedbackDTO;
    }
}
