package com.javaweb.model.dto;

import lombok.AccessLevel;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
@RequiredArgsConstructor
public class ProductImport {
    Long id;
    String image;
    String name;
    Long quantity;
    Long price;
    Long priceInPurchase;
}
