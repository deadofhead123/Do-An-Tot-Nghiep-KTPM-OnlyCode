package com.javaweb.api.admin;

import com.javaweb.constant.SystemConstant;
import com.javaweb.model.response.ResponseDTO;
import com.javaweb.service.statistic.IStatisticService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(value = "/api/admin/statistic")
@RequiredArgsConstructor
public class StatisticAPI_Admin {
    private final IStatisticService statisticService;

    @GetMapping("/hotProduct")
    public ResponseEntity<?> getHotProduct(@RequestParam(name = "month") String month){
        ResponseDTO responseDTO = new ResponseDTO();

        try{
            responseDTO.setData(statisticService.findProductWithHighestQuantitySold(month));
            return ResponseEntity.ok(responseDTO);
        }
        catch (Exception e){
            responseDTO.setMessage(SystemConstant.SYSTEM_ERROR_MESSAGE);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseDTO);
        }
    }

    @GetMapping("/excessProduct")
    public ResponseEntity<?> getExcessProduct(@RequestParam(name = "month") String month){
        ResponseDTO responseDTO = new ResponseDTO();

        try{
            responseDTO.setData(statisticService.findProductWithLowestQuantitySold(month));
            return ResponseEntity.ok(responseDTO);
        }
        catch (Exception e){
            responseDTO.setMessage(SystemConstant.SYSTEM_ERROR_MESSAGE);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseDTO);
        }
    }
}
