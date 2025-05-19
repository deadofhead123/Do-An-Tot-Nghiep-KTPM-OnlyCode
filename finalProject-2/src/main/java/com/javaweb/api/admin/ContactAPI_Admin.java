package com.javaweb.api.admin;

import com.javaweb.constant.SystemConstant;
import com.javaweb.model.dto.ContactDTO;
import com.javaweb.model.response.ResponseDTO;
import com.javaweb.service.contact.IContactService;
import com.javaweb.service.mail.IMailService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(value = "/api/admin/contacts")
@RequiredArgsConstructor
public class ContactAPI_Admin {
    private final IContactService IContactService;
    private final IMailService IMailService;

    @PutMapping
    public ResponseEntity<?> replyContact(@RequestBody ContactDTO contactDTO) {
        ResponseDTO responseDTO = new ResponseDTO();

        try{
            ContactDTO checkUpdateContact = IContactService.updateContact(contactDTO);

            if(ObjectUtils.isEmpty(checkUpdateContact)){
                responseDTO.setMessage("Lỗi khi lưu trả lời liên hệ, vui lòng thử lại!");
                return ResponseEntity.badRequest().body(responseDTO);
            }

            Boolean checkReplyEmail = IMailService.replyContact(checkUpdateContact.getEmail(), checkUpdateContact.getReply(), checkUpdateContact.getCreatedAt());

            if(!checkReplyEmail){
                responseDTO.setMessage("Lỗi khi gửi mail trả lời liên hệ, vui lòng thử lại!");
                return ResponseEntity.badRequest().body(responseDTO);
            }

            responseDTO.setData(SystemConstant.UPDATE_SUCCESS);
            responseDTO.setMessage("Trả lời liên hệ thành công!");
            return ResponseEntity.ok(responseDTO);
        }
        catch (Exception ex){
            responseDTO.setData(SystemConstant.ERROR_SYSTEM);
            responseDTO.setMessage("Lỗi máy chủ, vui lòng thử lại!");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseDTO);
        }
    }
}
