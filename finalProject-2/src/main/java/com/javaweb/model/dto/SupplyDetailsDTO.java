package com.javaweb.model.dto;

import lombok.AccessLevel;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
@RequiredArgsConstructor
public class SupplyDetailsDTO extends AbstractDTO<SupplyDetailsDTO> {
    Long quantity;
    Long price;
    ProductDTO productDTO;
    SupplierDTO supplierDTO;
}
