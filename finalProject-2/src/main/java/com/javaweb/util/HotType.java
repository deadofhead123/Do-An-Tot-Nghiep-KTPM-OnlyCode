package com.javaweb.util;

import java.util.LinkedHashMap;
import java.util.Map;

public enum HotType {
    YES("Có"),
    NO("Không");

    private final String name;

    HotType(String name){
        this.name = name;
    }

    public String getName(){
        return this.name;
    }

    public static Map<String, String> getType(){
        Map<String, String> listCode = new LinkedHashMap<>();

        for(HotType item : HotType.values()){
            listCode.put(item.toString(), item.getName());
        }

        return listCode;
    }
}
