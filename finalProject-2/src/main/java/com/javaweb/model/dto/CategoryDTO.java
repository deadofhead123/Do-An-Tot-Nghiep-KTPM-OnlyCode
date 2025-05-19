package com.javaweb.model.dto;

import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class CategoryDTO extends AbstractDTO<CategoryDTO> {
    String name;
    String description;
    Long parentId;
}
