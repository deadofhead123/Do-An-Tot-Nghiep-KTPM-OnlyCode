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
@Table(name = "categories")
public class CategoryEntity extends BaseEntity{
    @Column(name = "name")
    String name;

    @Column(name = "description")
    String description;

    @Column(name=  "isactive")
    Integer isActive;

    @Column(name = "parentid")
    Long parentId;

//    @OneToMany(mappedBy = "categoryEntity", fetch = FetchType.LAZY)
//    List<ProductEntity> productEntities;
}
