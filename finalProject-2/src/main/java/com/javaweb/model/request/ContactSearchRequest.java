package com.javaweb.model.request;

import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ContactSearchRequest {
    String fullName;
    String email;
    String phoneNumber;
    String status;
}
