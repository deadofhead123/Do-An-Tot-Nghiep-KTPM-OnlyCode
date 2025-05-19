package com.javaweb.entity;

import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.time.LocalDateTime;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
@Entity
@Table(name = "reset_password")
public class ResetPasswordEntity extends BaseEntity{
    @Column(name = "email")
    String email;

    @Column(name = "resettoken")
    String resetToken;

    @Column(name = "expired")
    LocalDateTime timeExpired;

    @Column(name = "isused")
    Integer isUsed;
}
