package com.javaweb.entity;

import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

import javax.persistence.*;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
@Entity
@Table(name = "orders")
public class OrderEntity extends BaseEntity {
    @Column(name = "total")
    Long total;

    @Column(name = "discount")
    Long discount;

    @Column(name = "address")
    String address;

    @Column(name = "paymentmethod")
    String paymentMethod;

    @Column(name = "status")
    String status;

    @Column(name = "note")
    String note;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "userid")
    UserEntity userEntity;
}
