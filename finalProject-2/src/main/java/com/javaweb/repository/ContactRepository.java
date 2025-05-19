package com.javaweb.repository;

import com.javaweb.entity.ContactEntity;
import com.javaweb.repository.custom.ContactRepositoryCustom;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ContactRepository extends JpaRepository<ContactEntity, Long>, ContactRepositoryCustom {
}
