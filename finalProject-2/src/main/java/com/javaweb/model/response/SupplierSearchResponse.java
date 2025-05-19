package com.javaweb.model.response;

import com.javaweb.model.dto.AbstractDTO;
import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class SupplierSearchResponse extends AbstractDTO<SupplierSearchResponse> {
    String name;
    String address;
    String email;
    String phoneNumber;
}
