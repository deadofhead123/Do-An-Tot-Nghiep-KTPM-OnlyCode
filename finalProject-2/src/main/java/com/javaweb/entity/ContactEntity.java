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
@Table(name = "contact")
public class ContactEntity extends BaseEntity{
    @Column(name = "fullname")
    String fullName;

    @Column(name = "email")
    String email;

    @Column(name = "phonenumber")
    String phoneNumber;

    @Column(name = "description")
    String description;

    @Column(name = "reply")
    String reply;
}
