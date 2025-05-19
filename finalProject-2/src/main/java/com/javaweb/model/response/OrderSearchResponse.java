package com.javaweb.model.response;

import com.javaweb.model.dto.AbstractDTO;
import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class OrderSearchResponse extends AbstractDTO<OrderSearchResponse> {
    Long totalFinal;

    String address;

    String paymentMethod;

    String status;
}
