package com.javaweb.model.statistic;

import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class HotProductStatistic {
    Long id;
    String name;
    String image;
    Long quantitySold;
    Long revenue;
}
