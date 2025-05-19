package com.javaweb.model.dto;

import lombok.AccessLevel;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

import javax.validation.constraints.Pattern;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
@RequiredArgsConstructor
public class SupplierDTO extends AbstractDTO<SupplierDTO> {
    String name;

    String address;

    /*
        Valid Email:
        Cho phép các ký tự số từ 0 đến 9
        Cho phép cả chữ hoa và chữ thường từ a đến z
        Cho phép các ký tự đặc biệt gạch dưới “_”, gạch nối “-” và dấu chấm “.”
        Dấu chấm không được phép ở đầu và cuối phần local part
        Các dấu chấm liền nhau sẽ vi phạm
        Đối với phần local part, số lượng ký tự tối đa là 64
     */
    @Pattern(regexp = "^(?=.{1,64}@)[A-Za-z0-9_-]+(\\.[A-Za-z0-9_-]+)*@[^-][A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z]{2,})$", message = "Email sai định dạng")
    String email;

    String phoneNumber;

    String note;
}
