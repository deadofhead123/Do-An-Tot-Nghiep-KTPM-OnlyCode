package com.javaweb.model.response;

import com.javaweb.model.dto.AbstractDTO;
import com.javaweb.model.dto.ProductDTO;
import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ProductInventorySearchResponse extends AbstractDTO<ProductInventorySearchResponse> {
    Long priceInImport;
    String status;
    ProductDTO productDTO;
}
