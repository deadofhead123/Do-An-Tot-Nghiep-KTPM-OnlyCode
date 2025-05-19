package com.javaweb.repository.custom;

import com.javaweb.entity.ContactEntity;
import com.javaweb.model.request.ContactSearchRequest;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface ContactRepositoryCustom {
    public List<ContactEntity> findAll(ContactSearchRequest contactSearchRequest, Pageable pageable);
    public int countTotalItems(ContactSearchRequest contactSearchRequest);
}
