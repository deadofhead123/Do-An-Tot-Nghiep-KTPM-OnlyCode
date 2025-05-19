package com.javaweb.entity;

import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

import javax.persistence.*;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
@Entity
@Table(name = "supply_details")
public class SupplyDetailsEntity extends BaseEntity {
    @Column(name = "quantity")
    Long quantity;

    @Column(name = "price")
    Long price;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "productid")
    ProductEntity productEntity;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "supplierid")
    SupplierEntity supplierEntity;
}
