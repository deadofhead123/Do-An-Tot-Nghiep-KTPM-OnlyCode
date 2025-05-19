package com.javaweb.model.response;

import com.javaweb.model.dto.AbstractDTO;
import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class UserSearchResponse extends AbstractDTO<UserSearchResponse> {
    String email;
    String fullName;
    String phoneNumber;
    String address;
    Long discount;
    Integer isActive;
    String role;
}
