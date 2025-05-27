package com.javaweb.util;

import java.util.LinkedHashMap;
import java.util.Map;

public enum ProductDiscountStatus {
    YES("Có"),
    NO("Không");

    private final String name;

    ProductDiscountStatus(String name){
        this.name = name;
    }

    public String getName(){
        return this.name;
    }

    public static Map<String, String> getType(){
        Map<String, String> listCode = new LinkedHashMap<>();

        for(ProductDiscountStatus item : ProductDiscountStatus.values()){
            listCode.put(item.toString(), item.getName());
        }

        return listCode;
    }
}
