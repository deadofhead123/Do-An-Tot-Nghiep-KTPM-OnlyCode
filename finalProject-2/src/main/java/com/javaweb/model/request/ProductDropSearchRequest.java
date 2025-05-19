package com.javaweb.model.request;

import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ProductDropSearchRequest {
    String name;
    String createdAtFrom;
    String createdAtTo;
}
