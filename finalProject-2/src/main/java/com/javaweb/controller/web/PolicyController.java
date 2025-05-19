package com.javaweb.controller.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class PolicyController {
    @GetMapping(value = "/change-return-policy")
    public ModelAndView changeAndReturn(){
        ModelAndView mav = new ModelAndView("/web/policy/change-return-product");
        return mav;
    }

    @GetMapping(value = "/delivery-policy")
    public ModelAndView delivery(){
        ModelAndView mav = new ModelAndView("/web/policy/delivery");
        return mav;
    }

    @GetMapping(value = "/condition-service-policy")
    public ModelAndView conditionAndService(){
        ModelAndView mav = new ModelAndView("/web/policy/condition-service");
        return mav;
    }

    @GetMapping(value = "/security-policy")
    public ModelAndView security(){
        ModelAndView mav = new ModelAndView("/web/policy/security");
        return mav;
    }

    @GetMapping(value = "/payment-policy")
    public ModelAndView payment(){
        ModelAndView mav = new ModelAndView("/web/policy/payment");
        return mav;
    }

    @GetMapping(value = "/order-policy")
    public ModelAndView order(){
        ModelAndView mav = new ModelAndView("/web/policy/order");
        return mav;
    }
}
