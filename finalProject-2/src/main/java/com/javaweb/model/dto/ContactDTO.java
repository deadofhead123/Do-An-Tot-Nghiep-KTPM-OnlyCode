package com.javaweb.model.dto;

import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

import javax.validation.constraints.Size;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ContactDTO extends AbstractDTO<ContactDTO> {
    String fullName;
    String email;

    @Size(min = 10, max = 10, message = "Số điện thoại phải có độ dài 10 chữ số!")
    String phoneNumber;

    String description;
    String reply;
}
