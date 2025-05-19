package com.javaweb.model.request;

import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class SupplierSearchRequest {
    String name;
    String address;
    String email;
    String phoneNumber;
    String createdAtFrom;
    String createdAtTo;
}
