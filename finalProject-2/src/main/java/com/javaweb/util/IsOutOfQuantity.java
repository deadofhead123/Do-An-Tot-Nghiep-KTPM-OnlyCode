package com.javaweb.util;

import java.util.LinkedHashMap;
import java.util.Map;

public enum IsOutOfQuantity {
    YES("Sắp hết hàng"),
    NO("Còn hàng");

    private final String name;

    IsOutOfQuantity(String name){
        this.name = name;
    }

    public String getName(){
        return this.name;
    }

    public static Map<String, String> getType(){
        Map<String, String> listCode = new LinkedHashMap<>();

        for(IsOutOfQuantity item : IsOutOfQuantity.values()){
            listCode.put(item.toString(), item.getName());
        }

        return listCode;
    }
}
