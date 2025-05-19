package com.javaweb.util;

import java.util.LinkedHashMap;
import java.util.Map;

public enum SortType {
    DEFAULT("createdat-desc"),
    NAME("name"),
    NAME_DESC("name-desc"),
    PRICE("price"),
    PRICE_DESC("price-desc"),
    LATEST("createdat-desc"),
    OLDEST("createdat");

    private final String name;

    SortType(String name){
        this.name = name;
    }

    public String getName(){
        return this.name;
    }

    public static Map<String, String> getType(){
        Map<String, String> typeList = new LinkedHashMap<>();

        for(SortType item : SortType.values()){
            typeList.put(item.toString(), item.getName());
        }

        return typeList;
    }
}
