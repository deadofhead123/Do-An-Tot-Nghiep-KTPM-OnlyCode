package com.javaweb.model.request;

import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class NewsSearchRequest {
    String type;
    String name;
    String description;
    Long viewFrom;
    Long viewTo;
    String hot;
}
