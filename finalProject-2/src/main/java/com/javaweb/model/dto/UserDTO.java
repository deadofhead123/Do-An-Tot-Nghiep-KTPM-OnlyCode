package com.javaweb.model.dto;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class UserDTO extends AbstractDTO<UserDTO>{
    /*
        Valid Email:
        Cho phép các ký tự số từ 0 đến 9
        Cho phép cả chữ hoa và chữ thường từ a đến z
        Cho phép các ký tự đặc biệt gạch dưới “_”, gạch nối “-” và dấu chấm “.”
        Dấu chấm không được phép ở đầu và cuối phần local part
        Các dấu chấm liền nhau sẽ vi phạm
        Đối với phần local part, số lượng ký tự đối ta là 64
     */
    @Pattern(regexp = "^(?=.{1,64}@)[A-Za-z0-9_-]+(\\.[A-Za-z0-9_-]+)*@[^-][A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z]{2,})$", message = "Email sai định dạng")
    String email;

    String fullName;

    @Size(min = 10, max = 10, message = "Số điện thoại phải có độ dài 10 ký tự!")
    String phoneNumber;

    String address;
    Integer isActive;
    Long discount;
    String password;
    String role;
    String roleCode;
    List<RoleDTO> roles;
}
