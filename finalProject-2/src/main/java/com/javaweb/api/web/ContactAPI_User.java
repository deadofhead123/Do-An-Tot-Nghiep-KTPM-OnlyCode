package com.javaweb.api.web;

import com.javaweb.model.dto.ContactDTO;
import com.javaweb.model.response.ResponseDTO;
import com.javaweb.service.contact.IContactService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.ObjectUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping(value = "/api/contacts")
public class ContactAPI_User {
    @Autowired
    private IContactService IContactService;

    @PostMapping
    public ResponseEntity<?> addContact(@Valid @RequestBody ContactDTO contactDTO, BindingResult bindingResult){
        ResponseDTO responseDTO = new ResponseDTO();

        try{
            if(bindingResult.hasErrors()){
                List<String> errors = bindingResult.getFieldErrors().stream().map(FieldError::getDefaultMessage).collect(Collectors.toList());

                responseDTO.setMessage("Lỗi nhập dữ liệu!");
                responseDTO.setDetails(errors);

                return ResponseEntity.badRequest().body(responseDTO);
            }

            ContactDTO checkAddContact = IContactService.addContact(contactDTO);

            if(ObjectUtils.isEmpty(checkAddContact)){
                responseDTO.setMessage("Lỗi khi gửi liên hệ, vui lòng thử lại!");
                return ResponseEntity.badRequest().body(responseDTO);
            }

            responseDTO.setMessage("Gửi liên hệ thành công!");
            return ResponseEntity.ok(responseDTO);
        }
        catch (Exception ex){
            responseDTO.setMessage("Lỗi máy chủ, vui lòng thử lại!");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseDTO);
        }
    }
}
