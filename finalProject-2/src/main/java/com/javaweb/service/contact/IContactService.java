package com.javaweb.service.contact;

import com.javaweb.model.dto.ContactDTO;
import com.javaweb.model.request.ContactSearchRequest;
import com.javaweb.model.response.ContactSearchResponse;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface IContactService {
    public List<ContactSearchResponse> findAll(ContactSearchRequest contactSearchRequest, Pageable pageable);
    public ContactDTO findOneById(Long id);
    public ContactDTO addContact(ContactDTO contactDTO);
    public ContactDTO updateContact(ContactDTO contactDTO);
    public int countTotalItems(ContactSearchRequest contactSearchRequest);
}
