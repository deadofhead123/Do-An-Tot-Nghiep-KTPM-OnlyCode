package com.javaweb.entity;


import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Getter
@Setter
@MappedSuperclass
@EntityListeners(AuditingEntityListener.class)
public class BaseEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;

    @Column(name = "createdat")
    @CreatedDate
    Date createdAt;

    @Column(name = "createdby")
    @CreatedBy
    String createdBy;

    @Column(name = "modifiedat")
    @LastModifiedDate
    Date modifiedAt;

    @Column(name = "modifiedby")
    @LastModifiedBy
    String modifiedBy;

    @PrePersist
    public void prePersist(){
        this.modifiedAt = null;
        this.modifiedBy = null;
    }
}
