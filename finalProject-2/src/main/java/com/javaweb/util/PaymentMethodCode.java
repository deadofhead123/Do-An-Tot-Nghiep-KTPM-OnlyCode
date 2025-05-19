package com.javaweb.util;

import java.util.LinkedHashMap;
import java.util.Map;

public enum PaymentMethodCode {
    BANK_TRANSFER("Chuyển khoản"),
    CASH_ON_DELIVERY("Tiền mặt");

    private final String name;

    PaymentMethodCode(String name){
        this.name = name;
    }

    public String getName(){
        return this.name;
    }

    public static Map<String, String> getType(){
        Map<String, String> type = new LinkedHashMap<>();

        for(PaymentMethodCode item : PaymentMethodCode.values()){
            type.put(item.toString(), item.getName());
        }

        return type;
    }
}
