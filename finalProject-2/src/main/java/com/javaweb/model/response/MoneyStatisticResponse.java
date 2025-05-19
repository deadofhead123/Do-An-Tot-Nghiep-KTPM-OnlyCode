package com.javaweb.model.response;

import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class MoneyStatisticResponse {
    Long revenue;
    Long importTotal;
    String date;
}
