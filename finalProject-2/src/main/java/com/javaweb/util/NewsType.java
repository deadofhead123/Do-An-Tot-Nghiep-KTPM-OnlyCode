package com.javaweb.util;

import java.util.LinkedHashMap;
import java.util.Map;

public enum NewsType {
    RAU_CU("Rau củ"),
    TRAI_CAY("Trái cây"),
    NUOC_EP("Nước ép"),
    HAT_KHO("Hạt khô"),
    KHAC("Khác");

    private final String name;

    public String getName(){
        return name;
    }

    NewsType(String name){
        this.name = name;
    }

    public static Map<String, String> listType(){
        Map<String, String> types =  new LinkedHashMap<String, String>();

        for(NewsType type : NewsType.values()){
            types.put(type.toString(), type.getName());
        }

        return types;
    }
}
