package com.javaweb.api.web;

import com.javaweb.model.dto.OrderDTO;
import com.javaweb.model.response.ResponseDTO;
import com.javaweb.service.order.OrderService;
import lombok.RequiredArgsConstructor;
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
@RequestMapping("/api/orders")
@RequiredArgsConstructor
public class OrderAPI_User {
    private final OrderService orderService;

    @PostMapping
    public ResponseEntity<?> createOrder(@Valid @RequestBody OrderDTO orderDTO, BindingResult bindingResult){
        ResponseDTO responseDTO = new ResponseDTO();

        try{
            if(bindingResult.hasErrors()){
                List<String> errors = bindingResult.getFieldErrors().stream().map(FieldError::getDefaultMessage).collect(Collectors.toList());
                responseDTO.setDetails(errors);
                responseDTO.setMessage("Lỗi nhập dữ liệu: ");
                return ResponseEntity.badRequest().body(responseDTO);
            }

            OrderDTO orderResult = orderService.createOrder(orderDTO);

            if(ObjectUtils.isEmpty(orderResult)){
                responseDTO.setMessage("Không thể đặt hàng !");
                return ResponseEntity.badRequest().body(responseDTO);
            }

            responseDTO.setMessage("Đặt hàng thành công !");
            return ResponseEntity.ok(responseDTO);
        }
        catch (Exception e){
            responseDTO.setMessage("Lỗi máy chủ ! Vui lòng thử lại !");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseDTO);
        }
    }
}
