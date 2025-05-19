package com.javaweb.model.dto;

import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class OrderDetailsDTO extends AbstractDTO<OrderDetailsDTO>{
    String orderId;
    Long quantity;
    Long priceInPurchase;
    ProductDTO productDTO;
}
