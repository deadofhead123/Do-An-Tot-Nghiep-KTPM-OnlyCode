package com.javaweb.controller.web;

import com.javaweb.model.dto.OrderDTO;
import com.javaweb.model.dto.UserDTO;
import com.javaweb.security.utils.SecurityUtils;
import com.javaweb.service.order.IOrderService;
import com.javaweb.service.user.IUserService;
import com.javaweb.util.OrderStatusCode;
import com.javaweb.util.PaymentMethodCode;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller(value="userControllerOfWeb")
@RequiredArgsConstructor
public class UserController_Web {
    private final IUserService IUserService;
    private final IOrderService orderService;

    // Account details
    @GetMapping(value = "/my-account")
    public ModelAndView accountDetails(@ModelAttribute(name = "userEdit") UserDTO userDTO){
        ModelAndView mav = new ModelAndView("web/user/my-account/account-details");

        UserDTO userReturn = IUserService.findOneById(SecurityUtils.getPrincipal().getId());

        if(ObjectUtils.isEmpty(userReturn)){
            return new ModelAndView("redirect:/not-found");
        }

        mav.addObject("userEdit", userReturn);

        return mav;
    }

    // Change password
    @GetMapping(value = "/change-password")
    public ModelAndView changePassword(@ModelAttribute(name = "userEdit") UserDTO userDTO){
        ModelAndView mav = new ModelAndView("web/user/my-account/change-password");

        UserDTO userReturn = IUserService.findOneById(SecurityUtils.getPrincipal().getId());

        if(ObjectUtils.isEmpty(userReturn)){
            return new ModelAndView("redirect:/not-found");
        }

        mav.addObject("userEdit", userReturn);

        return mav;
    }

    @GetMapping(value = "/my-orders")
    public ModelAndView myOrders(@RequestParam(value = "page", defaultValue = "0") int page,
                                 @RequestParam(value = "maxPageItems", defaultValue = "4") int maxPageItems){
        ModelAndView mav = new ModelAndView("web/user/my-account/my-orders");

        mav.addObject("orders", orderService.findAllByUser(PageRequest.of(page, maxPageItems)));
        mav.addObject("statusType", OrderStatusCode.getType());

        return mav;
    }

    @GetMapping(value = "/my-order-details-{orderId}")
    public ModelAndView myOrders(@PathVariable("orderId") Long orderId){
        ModelAndView mav = new ModelAndView("web/user/my-account/my-order-details");

        OrderDTO orderResult = orderService.findOneById(orderId);

        if(ObjectUtils.isEmpty(orderResult)){
            return new ModelAndView("redirect:/not-found");
        }

        // Other user's order accessible is unauthorized
        if(!orderResult.getUserDTO().getId().equals(SecurityUtils.getPrincipal().getId())){
            return new ModelAndView("redirect:/access-denied");
        }

        mav.addObject("orderInfo", orderResult);
        mav.addObject("productsOfOrder", orderService.findAllDetailsByOrderId(orderId));
        mav.addObject("paymentMethod", PaymentMethodCode.getType());

        return mav;
    }
}
