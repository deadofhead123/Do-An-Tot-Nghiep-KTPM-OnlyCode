package com.javaweb.entity;

import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.FieldDefaults;

import javax.persistence.*;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
@Entity
@Table(name = "product_category")
public class ProductCategoryEntity extends BaseEntity {
    @Column(name = "productid")
    Long productId;

    @Column(name = "categoryid")
    Long categoryId;
}
