package com.javaweb.model.dto;

import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

import java.time.LocalDateTime;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ProductInventoryDTO extends AbstractDTO<ProductInventoryDTO>{
    String name;
    Long priceInImport;
    LocalDateTime expiredAt;
    String status;
    String note;
    Long orderId;
    Long supplierId;
    ProductDTO productDTO;
}
