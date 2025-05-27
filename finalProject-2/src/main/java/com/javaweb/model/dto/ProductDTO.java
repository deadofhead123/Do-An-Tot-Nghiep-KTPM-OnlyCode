package com.javaweb.model.dto;

import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ProductDTO extends AbstractDTO<ProductDTO> {
    String name;
    Long price;
    String description;
    Long expiration;
    Long quantity;
    Long sold;
    Long discount;

    String image;
    String imageName;
    String imageBase64;

    Long categoryId;
    String hot;
    Integer isActive;

    public String getImageBase64() {
        if (imageBase64 != null) {
            return imageBase64.split(",")[1];
        }
        return null;
    }
}
