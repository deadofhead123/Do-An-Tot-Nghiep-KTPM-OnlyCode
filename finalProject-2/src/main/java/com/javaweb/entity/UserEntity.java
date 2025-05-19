package com.javaweb.entity;

import lombok.*;
import lombok.experimental.FieldDefaults;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
@Entity
@Table(name = "users")
public class UserEntity extends BaseEntity {
    @Column(name = "email")
    String email;

    @Column(name = "password")
    String password;

    @Column(name = "fullname")
    String fullName;

    @Column(name = "discount")
    Long discount;

    @Column(name = "phonenumber")
    String phoneNumber;

    @Column(name = "address")
    String address;

    @Column(name = "isactive")
    Integer isActive;

    @ManyToMany(fetch = FetchType.LAZY, cascade = {CascadeType.PERSIST})
    @JoinTable(name = "user_role",
            joinColumns = @JoinColumn(name = "userid", nullable = false),
            inverseJoinColumns = @JoinColumn(name = "roleid", nullable = false)
    )
    List<RoleEntity> roles = new ArrayList<>();
}
