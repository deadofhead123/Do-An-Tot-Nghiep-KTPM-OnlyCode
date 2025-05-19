package com.javaweb.model.request;

import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ProductInventorySearchRequest {
    Long id;
    String name;
    Long categoryId;
    String expiredAt;
    String status;
    String statusTimeFrom;
    String statusTimeTo;
    Long orderId;
    Long supplierId;
}
