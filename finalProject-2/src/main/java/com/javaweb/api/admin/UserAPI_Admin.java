package com.javaweb.api.admin;

import com.javaweb.constant.SystemConstant;
import com.javaweb.model.dto.UserDTO;
import com.javaweb.model.response.ResponseDTO;
import com.javaweb.service.user.IUserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.ObjectUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping(value = "/api/admin/users")
@RequiredArgsConstructor
public class UserAPI_Admin {
    private final IUserService IUserService;

    @PostMapping
    public ResponseEntity<?> insertUser(@Valid @RequestBody UserDTO userDTO, BindingResult bindingResult) {
        ResponseDTO responseDTO = new ResponseDTO();

        try{
            // Valid data
            if(bindingResult.hasErrors()){
                List<String> errors = bindingResult.getFieldErrors()
                                .stream()
                                .map(FieldError::getDefaultMessage)
                                .collect(Collectors.toList());

                responseDTO.setMessage("Lỗi dữ liệu:");
                responseDTO.setDetails(errors);

                return ResponseEntity.badRequest().body(responseDTO);
            }

            // Check if email existed
            UserDTO checkUser = IUserService.findOneByEmailAndIsActive(userDTO.getEmail(), 1);

            if(!ObjectUtils.isEmpty(checkUser)){
                responseDTO.setMessage("Email này đã được dùng để đăng ký tài khoản khác!");
                return ResponseEntity.badRequest().body(responseDTO);
            }

            // Insert user
            userDTO.setPassword(SystemConstant.PASSWORD_DEFAULT);

            UserDTO resultUser = IUserService.createUser(userDTO);

            if(ObjectUtils.isEmpty(resultUser)){
                responseDTO.setMessage("Lỗi khi thêm tài khoản, vui lòng thử lại!");
                return ResponseEntity.badRequest().body(responseDTO);
            }

            responseDTO.setData(SystemConstant.INSERT_SUCCESS);
            responseDTO.setMessage("Thêm tài khoản thành công!");

            return ResponseEntity.ok(responseDTO);
        }
        catch (Exception ex){
            responseDTO.setMessage("Lỗi máy chủ!");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseDTO);
        }
    }

    @PatchMapping(value = "/lock/{userIds}")
    public ResponseEntity<?> lockOrUnlockUser(@PathVariable List<Long> userIds, @RequestParam(name = "action") Integer isActive){
        ResponseDTO responseDTO = new ResponseDTO();

        try{
            Boolean resultLockOrUnlock = IUserService.lockOrUnlockUser(userIds, isActive);

            if(!resultLockOrUnlock){
                responseDTO.setMessage("Lỗi khi thao tác với tài khoản!");
                return ResponseEntity.badRequest().body(responseDTO);
            }

            if(isActive == 0) responseDTO.setMessage("Khóa thành công!");
            else responseDTO.setMessage("Mở khóa thành công!");

            return ResponseEntity.ok(responseDTO);
        }
        catch (Exception ex){
            responseDTO.setMessage("Lỗi máy chủ!");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseDTO);
        }
    }

    @PatchMapping(value = "/discount")
    public ResponseEntity<?> applyDiscount(@RequestParam("discount") Long discount){
        ResponseDTO responseDTO = new ResponseDTO();

        try{
            Boolean resultApply = IUserService.applyDiscount_Admin(discount);

            if(!resultApply){
                responseDTO.setMessage("Lỗi khi thao tác với tài khoản!");
                return ResponseEntity.badRequest().body(responseDTO);
            }

            responseDTO.setMessage("Áp dụng thành công!");
            return ResponseEntity.ok(responseDTO);
        }
        catch (Exception ex){
            responseDTO.setMessage("Lỗi máy chủ!");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseDTO);
        }
    }
}
