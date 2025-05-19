package com.javaweb.util;

import java.util.LinkedHashMap;
import java.util.Map;

public enum RoleCode {
    STAFF("Nhân viên bán hàng"),
    USER("Người dùng");

    private final String name;

    RoleCode(String name){
        this.name = name;
    }

    public String getName(){
        return this.name;
    }

    public static Map<String, String> getListCode(){
        Map<String, String> listCode = new LinkedHashMap<>();

        for(RoleCode item : RoleCode.values()){
            listCode.put(item.toString(), item.name);
        }

        return listCode;
    }
}
