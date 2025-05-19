package com.javaweb.model.request;

import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ProductSearchRequest {
    String name;
    Long priceFrom;
    Long priceTo;
    Long quantity;
    Long discount;
    Long categoryId;
    String sortBy;
    String hot;
    String isOutOfQuantity;
}
