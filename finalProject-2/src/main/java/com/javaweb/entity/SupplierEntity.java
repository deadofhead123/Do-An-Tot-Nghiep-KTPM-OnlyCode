package com.javaweb.entity;

import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
@Entity
@Table(name = "suppliers")
public class SupplierEntity extends BaseEntity {
    @Column(name = "name")
    String name;

    @Column(name = "address")
    String address;

    @Column(name = "email")
    String email;

    @Column(name = "phonenumber")
    String phoneNumber;

    @Column(name = "note")
    String note;

    @Column(name = "total")
    Long totalOfImport;
}
