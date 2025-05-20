package com.javaweb.model.response;

import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class OrderStatusQuantityResponse {
    String status;
    String name;
    Long quantity;
}
