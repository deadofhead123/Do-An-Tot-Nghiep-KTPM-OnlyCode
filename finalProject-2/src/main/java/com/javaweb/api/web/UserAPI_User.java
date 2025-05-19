package com.javaweb.api.web;

import com.javaweb.model.dto.ChangePasswordDTO;
import com.javaweb.model.dto.ResetPasswordDTO;
import com.javaweb.model.dto.UserDTO;
import com.javaweb.model.response.ResponseDTO;
import com.javaweb.service.feedback.IFeedbackService;
import com.javaweb.service.mail.IMailService;
import com.javaweb.service.resetPassword.IResetPasswordService;
import com.javaweb.service.user.IUserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.ObjectUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@RestController
@RequestMapping(value = "/api/users")
@RequiredArgsConstructor
public class UserAPI_User {
    private final IFeedbackService feedbackService;
    private final IUserService userService;
    private final IMailService mailService;
    private final IResetPasswordService resetPasswordService;

    @PostMapping
    public ResponseEntity<?> signup(@RequestBody UserDTO userDTO){
        ResponseDTO responseDTO = new ResponseDTO();

        try{
            // Account existed
            if(!ObjectUtils.isEmpty(userService.findOneByEmailAndIsActive(userDTO.getEmail(), 1))){
                responseDTO.setMessage("Tài khoản đã tồn tại!");
                return ResponseEntity.badRequest().body(responseDTO);
            }

            responseDTO.setData(userService.createUser(userDTO));
            responseDTO.setMessage("Đăng ký thành công!");

            return ResponseEntity.ok(responseDTO);
        }
        catch (Exception ex){
            ex.printStackTrace();
            responseDTO.setMessage(ex.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseDTO);
        }
    }

    @PutMapping
    public ResponseEntity<?> update(@Valid @RequestBody UserDTO userDTO, BindingResult bindingResult){
        ResponseDTO responseDTO = new ResponseDTO();
        List<String> errors = new ArrayList<>();

        try{
            // Collect all errors from validation
            if(bindingResult.hasErrors()){
                errors = bindingResult.getFieldErrors()
                        .stream()
                        .map(FieldError::getDefaultMessage)
                        .collect(Collectors.toList());

                responseDTO.setMessage("Lỗi nhập dữ liệu\n");
                responseDTO.setDetails(errors);

                return ResponseEntity.badRequest().body(responseDTO);
            }

            UserDTO userDTO1 = userService.updateUser(userDTO);

            if(ObjectUtils.isEmpty(userDTO1) ){
                errors.add("Số điện thoại này đã được sử dụng!");

                responseDTO.setMessage("Lỗi khi cập nhật dữ liệu!");
                responseDTO.setDetails(errors);

                return ResponseEntity.badRequest().body(responseDTO);
            }

            responseDTO.setMessage("Cập nhật thông tin thành công!");
            return ResponseEntity.ok(responseDTO);
        } catch (Exception ex) {
            responseDTO.setMessage("Lỗi máy chủ!");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseDTO);
        }
    }

    @PostMapping(value = "/forgot-password")
    public ResponseEntity<?> sendEmailResetPassword(@RequestBody String email, HttpServletRequest request){
        ResponseDTO responseDTO = new ResponseDTO();

        try{
            // Find Email in system
            UserDTO userDTO = userService.findOneByEmailAndIsActive(email, 1);

            if( ObjectUtils.isEmpty(userDTO)){
                responseDTO.setMessage("Email của bạn không tồn tại trong hệ thống!");
                return ResponseEntity.badRequest().body(responseDTO);
            }

            String token = UUID.randomUUID().toString();

            // Create url to send in email. This url contains:
            String URL = mailService.generateURL(request)       //web's site
                    + "/reset-password?token="      // page to redirect
                    + token;      // token

            // Send email
            boolean sendEmail = mailService.sendEmailAboutResetPassword(email, URL);

            // Save token
            ResetPasswordDTO resetPasswordDTO = new ResetPasswordDTO();
            resetPasswordDTO.setEmail(email);
            resetPasswordDTO.setToken(token);

            resetPasswordService.save(resetPasswordDTO);

            if(sendEmail){
                responseDTO.setMessage("Gửi email thành công, hãy kiểm tra hòm thư của bạn!");
            }
            else{
                responseDTO.setMessage("Có lỗi xảy ra khi gửi email!");
            }

            return ResponseEntity.ok(responseDTO);
        }
        catch(Exception ex){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(ex.getMessage());
        }
    }

    @PutMapping(value = "/reset-password")
    public ResponseEntity<?> resetPassword(@RequestBody ResetPasswordDTO resetPasswordDTO){
        ResponseDTO responseDTO = new ResponseDTO();

        try{
            UserDTO userDTO = userService.resetPasswordOfUser(resetPasswordDTO);

            if( !ObjectUtils.isEmpty(userDTO) ){
                responseDTO.setMessage("Đặt lại mật khẩu thành công!");
            }
            else{
                responseDTO.setMessage("Đặt lại mật khẩu thất bại!");
            }

            return ResponseEntity.ok(responseDTO);
        }
        catch(Exception ex){
            responseDTO.setMessage("Lỗi hệ thống!");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseDTO);
        }
    }

    @PutMapping(value = "/change-password")
    public ResponseEntity<?> changePassword(@RequestBody ChangePasswordDTO changePasswordDTO){
        ResponseDTO responseDTO = new ResponseDTO();

        try{
            UserDTO userDTO = userService.changePasswordOfUser(changePasswordDTO);

            if(ObjectUtils.isEmpty(userDTO)){
                responseDTO.setMessage("Mật khẩu cũ không khớp!");
                return ResponseEntity.badRequest().body(responseDTO);
            }

            responseDTO.setMessage("Đổi mật khẩu thành công!");
            return ResponseEntity.ok(responseDTO);
        }
        catch(Exception ex){
            responseDTO.setMessage("Lỗi máy chủ, vui lòng thử lại!");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseDTO);
        }
    }
}
