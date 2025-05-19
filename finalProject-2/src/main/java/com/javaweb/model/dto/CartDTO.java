package com.javaweb.model.dto;

import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class CartDTO extends AbstractDTO<CartDTO> {
    UserDTO userDTO;
    ProductDTO productDTO;
    Long quantity;
}
