package com.javaweb.entity;

import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

import javax.persistence.*;
import java.time.LocalDateTime;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
@Table
@Entity(name = "product_inventory")
public class ProductInventoryEntity extends BaseEntity{
    @Column(name = "priceinimport")
    Long priceInImport;

    @Column(name = "expiredat")
    LocalDateTime expiredAt;

    @Column(name = "status")
    String status;

    @Column(name = "note")
    String note;

    @Column(name = "orderid")
    Long orderId;

    @ManyToOne(fetch = FetchType.LAZY, cascade = {CascadeType.MERGE})
    @JoinColumn(name = "productid")
    ProductEntity productEntity;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "supplierid")
    SupplierEntity supplierEntity;
}
