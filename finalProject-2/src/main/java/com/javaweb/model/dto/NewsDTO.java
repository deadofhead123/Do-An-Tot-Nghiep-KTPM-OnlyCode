package com.javaweb.model.dto;

import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class NewsDTO extends AbstractDTO<NewsDTO>{
    String type;

    String name;

    String description;

    String content;

    String image;
    String imageBase64;
    String imageName;

    Long view;
    String hot;

    public String getImageBase64() {
        if (imageBase64 != null) {
            return imageBase64.split(",")[1];
        }
        return null;
    }
}
