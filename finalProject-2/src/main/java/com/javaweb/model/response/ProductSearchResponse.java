package com.javaweb.model.response;

import com.javaweb.model.dto.AbstractDTO;
import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ProductSearchResponse extends AbstractDTO<ProductSearchResponse> {
    String name;
    Long price;
    Long quantity;
    Long discount;
    String image;
}
