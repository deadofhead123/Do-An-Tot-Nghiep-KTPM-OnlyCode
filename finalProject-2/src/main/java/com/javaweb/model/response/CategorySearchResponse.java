package com.javaweb.model.response;

import com.javaweb.model.dto.AbstractDTO;
import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class CategorySearchResponse extends AbstractDTO<CategorySearchResponse> {
    String name;
    String description;
    Integer isActive;
}
