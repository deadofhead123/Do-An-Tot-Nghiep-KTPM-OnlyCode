package com.javaweb.model.response;

import com.javaweb.model.dto.AbstractDTO;
import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ContactSearchResponse extends AbstractDTO<ContactSearchResponse> {
    String fullName;
    String email;
    String phoneNumber;
    String reply;
}
