package com.javaweb.controller.admin;

import com.javaweb.constant.SystemConstant;
import com.javaweb.model.dto.OrderDTO;
import com.javaweb.model.request.OrderSearchRequest;
import com.javaweb.model.response.OrderSearchResponse;
import com.javaweb.service.order.IOrderService;
import com.javaweb.util.DisplayTagUtils;
import com.javaweb.util.MessageUtils;
import com.javaweb.util.OrderStatusCode;
import com.javaweb.util.PaymentMethodCode;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang.StringUtils;
import org.displaytag.tags.TableTagParameters;
import org.displaytag.util.ParamEncoder;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

@Controller(value = "orderControllerOfAdmin")
@RequiredArgsConstructor
public class OrderController {
    private final MessageUtils messageUtil;
    private final IOrderService orderService;

    @GetMapping(value = "/admin/order-list")
    public ModelAndView orderList(@ModelAttribute("orderSearch") OrderSearchRequest orderSearchRequest, HttpServletRequest request){
        ModelAndView mav = new ModelAndView("admin/order/list");

        OrderSearchResponse orderSearchResponse = new OrderSearchResponse();

        DisplayTagUtils.of(request, orderSearchResponse);
        orderSearchResponse.setListResult(orderService.findAll(orderSearchRequest,
                                                                PageRequest.of(orderSearchResponse.getPage() - 1, orderSearchResponse.getMaxPageItems(), Sort.by(Sort.Direction.valueOf(orderSearchResponse.getSortOrder()), orderSearchResponse.getSortName()))));
        orderSearchResponse.setTotalItems(orderService.countTotalItems(orderSearchRequest));

        initMessageResponse(mav, request);
        mav.addObject("orderSearchResponse", orderSearchResponse);
        mav.addObject("statusType", OrderStatusCode.getType());
        mav.addObject("tableId", new ParamEncoder(orderSearchResponse.getTableId()).encodeParameterName(TableTagParameters.PARAMETER_PAGE));

        return mav;
    }

    @GetMapping(value = "/admin/order-edit-{id}")
    public ModelAndView addProduct(@ModelAttribute("orderEdit") OrderDTO orderDTO, @PathVariable("id") Long id, HttpServletRequest request){
        ModelAndView mav = new ModelAndView("admin/order/edit");

        OrderDTO orderResult = orderService.findOneById(id);

        if(orderResult == null){
            return new ModelAndView("redirect:/not-found");
        }

        mav.addObject("orderEdit", orderResult);
        mav.addObject("productsOfOrder", orderService.findAllDetailsByOrderId(id));
        mav.addObject("paymentMethod", PaymentMethodCode.getType());
        mav.addObject("statusType", OrderStatusCode.getType());

        initMessageResponse(mav, request);

        return mav;
    }

    private void initMessageResponse(ModelAndView mav, HttpServletRequest request) {
        String message = request.getParameter("message");

        if (message != null && StringUtils.isNotEmpty(message)) {
            Map<String, String> messageMap = messageUtil.getMessage(message);
            mav.addObject(SystemConstant.ALERT, messageMap.get(SystemConstant.ALERT));
            mav.addObject(SystemConstant.MESSAGE_RESPONSE, messageMap.get("message"));
        }
    }
}
