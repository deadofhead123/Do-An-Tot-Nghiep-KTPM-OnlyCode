package com.javaweb.model.dto;

import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ProductDropDTO extends AbstractDTO<ProductDropDTO>{
    String name;
    Long priceInImport;
    String note;
    String image;
}
