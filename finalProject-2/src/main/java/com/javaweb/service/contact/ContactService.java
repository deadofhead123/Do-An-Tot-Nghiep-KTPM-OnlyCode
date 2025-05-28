package com.javaweb.service.contact;

import com.javaweb.converter.ContactConverter;
import com.javaweb.entity.ContactEntity;
import com.javaweb.model.dto.ContactDTO;
import com.javaweb.model.request.ContactSearchRequest;
import com.javaweb.model.response.ContactSearchResponse;
import com.javaweb.repository.ContactRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@Transactional
public class ContactService implements IContactService {
    @Autowired
    private ContactRepository contactRepository;

    @Autowired
    private ContactConverter contactConverter;

    @Override
    public List<ContactSearchResponse> findAll(ContactSearchRequest contactSearchRequest, Pageable pageable) {
        List<ContactEntity> contactEntities = contactRepository.findAll(contactSearchRequest, pageable);
        List<ContactSearchResponse> responseList = new ArrayList<>();

        for(ContactEntity contactEntity : contactEntities){
            responseList.add(contactConverter.convertToResponseDTO(contactEntity));
        }

        return responseList;
    }

    @Override
    public ContactDTO findOneById(Long id) {
        return contactConverter.convertToDTO(contactRepository.findOneById(id));
    }

    @Override
    public ContactDTO addContact(ContactDTO contactDTO) {
        return contactConverter.convertToDTO(contactRepository.save(contactConverter.convertToEntity(contactDTO)));
    }

    @Override
    public ContactDTO updateContact(ContactDTO contactDTO) {
        ContactEntity contactEntity = contactRepository.findById(contactDTO.getId()).get();

        contactEntity.setReply(contactDTO.getReply());

        return contactConverter.convertToDTO(contactRepository.save(contactEntity));
    }

    @Override
    public int countTotalItems(ContactSearchRequest contactSearchRequest){
        return contactRepository.countTotalItems(contactSearchRequest);
    }
}
