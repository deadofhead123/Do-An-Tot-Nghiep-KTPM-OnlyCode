package com.javaweb.converter;

import com.javaweb.entity.ContactEntity;
import com.javaweb.model.dto.ContactDTO;
import com.javaweb.model.response.ContactSearchResponse;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class ContactConverter {
    @Autowired
    private ModelMapper modelMapper;

    public ContactEntity convertToEntity(ContactDTO contactDTO){
        return modelMapper.map(contactDTO, ContactEntity.class);
    }

    public ContactDTO convertToDTO(ContactEntity contactEntity){
        if(contactEntity == null) return null;
        return modelMapper.map(contactEntity, ContactDTO.class);
    }

    public ContactSearchResponse convertToResponseDTO(ContactEntity contactEntity){
        return modelMapper.map(contactEntity, ContactSearchResponse.class);
    }
}
