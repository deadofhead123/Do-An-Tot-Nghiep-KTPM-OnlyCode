package com.javaweb.model.request;

import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class UserSearchRequest {
    String email;
    String fullName;
    String phoneNumber;
    String address;
    String roleCode;
}
