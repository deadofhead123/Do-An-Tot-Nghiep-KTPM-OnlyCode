package com.javaweb.entity;

import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
@Entity
@Table(name = "roles")
public class RoleEntity extends BaseEntity{
    @Column(name = "name")
    String name;

    @Column(name = "code")
    String code;

    @ManyToMany(mappedBy = "roles", fetch = FetchType.LAZY)
    List<UserEntity> users = new ArrayList<>();
}
