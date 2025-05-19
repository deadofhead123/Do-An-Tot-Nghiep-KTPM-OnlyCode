package com.javaweb.entity;

import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

import javax.persistence.*;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
@Entity
@Table(name = "order_details")
public class OrderDetailsEntity extends BaseEntity{
    @Column(name = "orderid")
    String orderId;

    @Column(name = "quantity")
    Long quantity;

    @Column(name = "priceinpurchase")
    Long priceInPurchase;

    @ManyToOne(fetch = FetchType.LAZY, cascade = {CascadeType.MERGE})
    @JoinColumn(name = "productid")
    ProductEntity productEntity;
}
