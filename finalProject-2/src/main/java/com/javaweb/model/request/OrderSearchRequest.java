package com.javaweb.model.request;

import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class OrderSearchRequest {
    Long id;
    String address;
    String status;
    String createdAtFrom;
    String createdAtTo;
}
