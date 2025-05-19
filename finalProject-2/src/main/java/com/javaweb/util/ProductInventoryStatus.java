package com.javaweb.util;

import java.util.LinkedHashMap;
import java.util.Map;

public enum ProductInventoryStatus {
    UNUSED("Nhập hàng (chưa sử dụng)"),
    LOCKED("Bị khóa"),
    CORRUPTED("Bị hỏng"),   // Destroyed, or expired
    DELIVERED("Đã giao");

    private final String name;

    ProductInventoryStatus(String name){
        this.name = name;
    }

    public String getName(){
        return this.name;
    }

    public static Map<String, String> getStatus(){
        Map<String, String> listCode = new LinkedHashMap<>();

        for(ProductInventoryStatus item : ProductInventoryStatus.values()){
            listCode.put(item.toString(), item.name);
        }

        return listCode;
    }
}
