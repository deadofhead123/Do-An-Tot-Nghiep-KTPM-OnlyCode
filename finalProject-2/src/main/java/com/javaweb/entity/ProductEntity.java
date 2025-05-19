package com.javaweb.entity;

import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

import javax.persistence.*;
import java.util.List;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
@Table
@Entity(name = "products")
public class ProductEntity extends BaseEntity {
    @Column(name = "name")
    String name;

    @Column(name = "price")
    Long price;

    @Column(name = "description")
    String description;

    @Column(name = "expiration")
    Long expiration;

    @Column(name = "isactive")
    Integer isActive;

    @Column(name = "quantity")
    Long quantity;

    @Column(name = "discount")
    Long discount;

    @Column(name = "image")
    String image;

    @Column(name = "hot")
    String hot;

    @ManyToMany(fetch = FetchType.LAZY, cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    @JoinTable(name = "product_category",
            joinColumns = @JoinColumn(name = "productid", nullable = false),
            inverseJoinColumns = @JoinColumn(name = "categoryid", nullable = false)
    )
//    @OneToMany(mappedBy = "productEntity", fetch = FetchType.LAZY, cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    List<CategoryEntity> categoryEntities;
}
