package com.javaweb.api.web;

import com.javaweb.model.dto.FeedbackDTO;
import com.javaweb.model.response.ResponseDTO;
import com.javaweb.service.feedback.IFeedbackService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(value = "/api/feedback")
@RequiredArgsConstructor
public class FeedbackAPI_User {
    private final IFeedbackService feedbackService;

    @GetMapping
    public ResponseEntity<?> getFeedback(@RequestParam("productId") Long productId, @RequestParam("size") Integer size){
        ResponseDTO responseDTO = new ResponseDTO();

        try{
            List<FeedbackDTO> allFeedback_Web = feedbackService.findAllFeedback_Web(productId, size);

            responseDTO.setData(allFeedback_Web);
            return ResponseEntity.ok(responseDTO);
        }
        catch(Exception ex){
            responseDTO.setMessage("Lỗi máy chủ, vui lòng thử lại!");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseDTO);
        }
    }

    @PostMapping
    public ResponseEntity<?> createFeedback(@RequestBody FeedbackDTO feedbackDTO){
        ResponseDTO responseDTO = new ResponseDTO();

        try{
            FeedbackDTO feedbackResult = feedbackService.createFeedback(feedbackDTO);

            if(ObjectUtils.isEmpty(feedbackResult)){
                responseDTO.setMessage("Bạn chưa mua sản phẩm này, không thể đánh giá!");
                return ResponseEntity.badRequest().body(responseDTO);
            }

            responseDTO.setMessage("Đánh giá sản phẩm thành công!");
            return ResponseEntity.ok(responseDTO);
        }
        catch(Exception ex){
            responseDTO.setMessage("Lỗi máy chủ, vui lòng thử lại!");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseDTO);
        }
    }
}
