package com.javaweb.model.dto;

import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class FeedbackDTO extends AbstractDTO<FeedbackDTO> {
    Long productId;

    UserDTO userDTO;

    Integer rating;

    String content;
}
