package com.javaweb.api.admin;

import com.javaweb.constant.SystemConstant;
import com.javaweb.model.dto.OrderDTO;
import com.javaweb.model.response.ResponseDTO;
import com.javaweb.model.response.MoneyStatisticResponse;
import com.javaweb.service.order.OrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/api/admin/orders")
@RequiredArgsConstructor
public class OrderAPI_Admin {
    private final OrderService orderService;

    @PutMapping
    public ResponseEntity<?> updateOrder(@RequestBody OrderDTO orderDTO){
        ResponseDTO responseDTO = new ResponseDTO();

        try{
            OrderDTO orderResult = orderService.updateOrder(orderDTO);

            if(ObjectUtils.isEmpty(orderResult)){
                responseDTO.setMessage("Đơn hàng chưa giao, không thể hoàn thành!");
                return ResponseEntity.badRequest().body(responseDTO);
            }

            responseDTO.setMessage("Cập nhật đơn hàng thành công!");
            responseDTO.setData(SystemConstant.UPDATE_SUCCESS);
            return ResponseEntity.ok(responseDTO);
        }
        catch(Exception e){
            responseDTO.setMessage("Lỗi máy chủ! Vui lòng thử lại!");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseDTO);
        }
    }

    @GetMapping("/totalByMonth")
    public ResponseEntity<?> getTotalByMonth(@RequestParam(name = "date") String date){
        ResponseDTO responseDTO = new ResponseDTO();

        try{
            List<MoneyStatisticResponse> moneyStatisticRespons = orderService.findTotalByMonth(LocalDate.parse(date));

            responseDTO.setData(moneyStatisticRespons);
            return ResponseEntity.ok(responseDTO);
        }
        catch(Exception e){
            responseDTO.setMessage("Lỗi máy chủ! Vui lòng thử lại!");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseDTO);
        }
    }

    @GetMapping("/totalByYear")
    public ResponseEntity<?> getTotalByYear(@RequestParam(name = "date") String date){
        ResponseDTO responseDTO = new ResponseDTO();

        try{
            List<MoneyStatisticResponse> moneyStatisticRespons = orderService.findTotalByYear(LocalDate.parse(date));

            responseDTO.setData(moneyStatisticRespons);
            return ResponseEntity.ok(responseDTO);
        }
        catch(Exception e){
            responseDTO.setMessage("Lỗi máy chủ! Vui lòng thử lại!");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseDTO);
        }
    }
}
