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
@Table(name = "news")
public class NewsEntity extends BaseEntity {
    @Column(name = "types")
    String type;

    @Column(name = "name")
    String name;

    @Column(name = "description")
    String description;

    @Column(name = "content")
    String content;

    @Column(name = "image")
    String image;

    @Column(name = "views")
    Long view;

    @Column(name = "hot")
    String hot;

    @Column(name = "isactive")
    Integer isActive;
}
