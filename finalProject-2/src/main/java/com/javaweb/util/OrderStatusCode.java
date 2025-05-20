package com.javaweb.util;

import java.util.LinkedHashMap;
import java.util.Map;

public enum OrderStatusCode {
    IN_PROGRESS("Chờ xử lý"),
    CANCELED("Đã hủy"),
    DELIVERING("Đang giao hàng"),
    DELIVERED("Đã hoàn thành");

    private final String name;

    OrderStatusCode(String name){
        this.name = name;
    }

    public String getName(){
        return this.name;
    }

    public static Map<String, String> getType(){
        Map<String, String> type = new LinkedHashMap<>();

        for(OrderStatusCode item : OrderStatusCode.values()){
            type.put(item.toString(), item.getName());
        }

        return type;
    }
}
