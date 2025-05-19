package com.javaweb.model.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class OrderDTO extends AbstractDTO<OrderDTO> {
    @JsonProperty("totalOfOrder")
    Long total;
    Long discount;
    UserDTO userDTO;
    String address;
    String paymentMethod;
    String status;
    String note;
}
