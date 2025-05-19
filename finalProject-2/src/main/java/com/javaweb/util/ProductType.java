package com.javaweb.util;

import java.util.LinkedHashMap;
import java.util.Map;

public enum ProductType {
    TUI("Túi"),
    THUNG("Thùng"),
    CAN("Cân"),
    LANG("Lạng");

    private final String name;

    ProductType(String name){
        this.name = name;
    }

    public String getName(){
        return this.name;
    }

    public static Map<String, String> getType(){
        Map<String, String> listCode = new LinkedHashMap<>();

        for(ProductType item : ProductType.values()){
            listCode.put(item.toString(), item.name);
        }

        return listCode;
    }
}
