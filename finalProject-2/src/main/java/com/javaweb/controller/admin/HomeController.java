package com.javaweb.controller.admin;

import com.javaweb.model.dto.UserDTO;
import com.javaweb.model.response.MoneyStatisticResponse;
import com.javaweb.security.utils.SecurityUtils;
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
import java.util.List;

@Controller(value = "homeControllerOfAdmin")
@RequiredArgsConstructor
public class HomeController {
    private final IUserService IUserService;
    private final IOrderService orderService;
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
        List<MoneyStatisticResponse> revenueOfThisMonth = orderService.findTotalByMonth(today);

        Long userQuantity = userService.countTotalItemsByDate(todayInString);
        Long quantitySold = orderService.findQuantityDelivered(todayInString);
        Long orderDelivered = orderService.findOrderDelivered(todayInString);

        mav.addObject("userQuantity", userQuantity);
        mav.addObject("quantitySold", quantitySold);
        mav.addObject("orderDelivered", orderDelivered);

        String yesterday = LocalDate.now().minusDays(1L).toString();

        Long revenueToday = revenueOfThisMonth.get(revenueOfThisMonth.size() - 1).getRevenue(); // Last revenue element contains today's revenue
        Long revenueYesterday = orderService.findTotal(yesterday);
        revenueYesterday = (revenueYesterday < 0) ? 0 : revenueYesterday;

        Long userQuantityYesterday = userService.countTotalItemsByDate(yesterday);
        Long quantitySoldYesterday = orderService.findQuantityDelivered(yesterday);
        Long orderDeliveredYesterday = orderService.findOrderDelivered(yesterday);

        Double revenuePercent = 1.0 * ((revenueYesterday == 0) ? 0 : (revenueToday / revenueYesterday));
        Double userQuantityPercent = (userQuantityYesterday == 0) ? 0 : (1.0 * userQuantity / userQuantityYesterday);
        Double quantitySoldPercent = (quantitySoldYesterday == 0) ? 0 :  (1.0 * quantitySold / quantitySoldYesterday);
        Double orderDeliveredPercent = (orderDeliveredYesterday == 0) ? 0 :  (1.0 * orderDelivered / orderDeliveredYesterday);

        mav.addObject("revenueToday", revenueToday);
        mav.addObject("revenuePercent", 100 - Math.round(revenuePercent * 10000) / 100);
        mav.addObject("userQuantityPercent", 100 - Math.round(userQuantityPercent * 10000) / 100);
        mav.addObject("quantitySoldPercent", 100 - Math.round(quantitySoldPercent * 10000) / 100);
        mav.addObject("orderDeliveredPercent", 100 - Math.round(orderDeliveredPercent * 10000) / 100);

        mav.addObject("orderStatusQuantities", orderService.findQuantityByStatus(todayInString));

        mav.addObject("revenueListOfMonth", revenueOfThisMonth);

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
