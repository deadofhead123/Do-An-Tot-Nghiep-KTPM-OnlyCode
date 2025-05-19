package com.javaweb.util;

import java.util.LinkedHashMap;
import java.util.Map;

public enum ContactStatus {
    SOLVED("Đã giải quyết"),
    UNSOLVED("Chưa giải quyết");

    private final String name;

    ContactStatus(String name){
        this.name = name;
    }

    public String getName(){
        return name;
    }

    public static Map<String, String> typeContact(){
        Map<String, String> listType = new LinkedHashMap<>();

        for(ContactStatus contactStatus : ContactStatus.values()){
            listType.put(contactStatus.toString(), contactStatus.getName());
        }

        return listType;
    }
}
