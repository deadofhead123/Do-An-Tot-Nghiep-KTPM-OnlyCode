package com.javaweb.controller.admin;

import com.javaweb.model.dto.UserDTO;
import com.javaweb.security.utils.SecurityUtils;
import com.javaweb.service.news.INewsService;
import com.javaweb.service.order.IOrderService;
import com.javaweb.service.productImport.IProductImportService;
import com.javaweb.service.productInventory.IProductInventoryService;
import com.javaweb.service.user.IUserService;
import com.javaweb.service.user.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.servlet.ModelAndView;

import java.time.LocalDate;

@Controller(value = "homeControllerOfAdmin")
@RequiredArgsConstructor
public class HomeController {
    private final IUserService IUserService;
    private final IOrderService orderService;
    private final INewsService newsService;
    private final IProductImportService productImportService;
    private final IProductInventoryService productInventoryService;
    private final UserService userService;

    @GetMapping(value = "/admin/home")
    public ModelAndView adminHome(){
        ModelAndView mav = new ModelAndView("/admin/home");
        return mav;
    }

    @GetMapping(value = "/admin/dashboard")
    public ModelAndView adminDashboard(){
        ModelAndView mav = new ModelAndView("/admin/dashboard");

        LocalDate today = LocalDate.now();
        String todayInString = today.toString();

        mav.addObject("revenueToday", orderService.findTotalByDate(todayInString)); // Last revenue element contains today's revenue
        mav.addObject("importToday", productImportService.findImportTotalByDate(todayInString));
        mav.addObject("userQuantity", userService.countTotalItemsByDate(todayInString));
        mav.addObject("newsViews", newsService.countTotalViews());

        return mav;
    }

    @GetMapping(value = "/admin/my-account")
    public ModelAndView adminAccount(@ModelAttribute("userEdit") UserDTO userDTO){
        ModelAndView mav = new ModelAndView("/admin/my-account");

        UserDTO userReturn = IUserService.findOneById(SecurityUtils.getPrincipal().getId());

        if(ObjectUtils.isEmpty(userDTO)){
            return new ModelAndView("redirect:/not-found");
        }

        mav.addObject("userEdit", userReturn);

        return mav;
    }


}
