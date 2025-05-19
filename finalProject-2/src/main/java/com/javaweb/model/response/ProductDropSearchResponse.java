package com.javaweb.model.response;

import com.javaweb.model.dto.AbstractDTO;
import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ProductDropSearchResponse extends AbstractDTO<ProductDropSearchResponse> {
    String name;
    Long quantity;
    String description;
}
