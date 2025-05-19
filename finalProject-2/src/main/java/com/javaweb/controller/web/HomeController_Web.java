package com.javaweb.controller.web;

import com.javaweb.model.dto.ResetPasswordDTO;
import com.javaweb.model.request.ResetPasswordRequest;
import com.javaweb.service.product.IProductService;
import com.javaweb.service.resetPassword.IResetPasswordService;
import com.javaweb.service.user.IUserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.time.LocalDateTime;

@Controller(value = "homeControllerOfWeb")
@RequiredArgsConstructor
public class HomeController_Web {
    private final IResetPasswordService IResetPassword;
    private final IUserService IUserService;
    private final IProductService productService;

    @RequestMapping(value = "/home", method = RequestMethod.GET)
    public ModelAndView homePage(){
        ModelAndView mav = new ModelAndView("/web/home");

        mav.addObject("hotProducts", productService.findAllHotProduct());
        
        return mav;
    }

    @GetMapping(value = "/about")
    public ModelAndView aboutPage(){
        ModelAndView mav = new ModelAndView("/web/about");
        return mav;
    }

    @GetMapping(value = "/contact")
    public ModelAndView contactPage(){
        ModelAndView mav = new ModelAndView("/web/contact");
        return mav;
    }

    @GetMapping(value = "/wishlist")
    public ModelAndView wishlistPage(){
        ModelAndView mav = new ModelAndView("/web/wishlist");
        return mav;
    }

    @GetMapping(value = "/login")
    public ModelAndView login(){
        ModelAndView mav = new ModelAndView("login");
        return mav;
    }

    @GetMapping(value = "/signup")
    public ModelAndView signup(){
        ModelAndView mav = new ModelAndView("signup");
        return mav;
    }

    @GetMapping(value = "/forgot-password")
    public ModelAndView forgotPassword(){
        ModelAndView mav = new ModelAndView("forgot-password");
        return mav;
    }

    @GetMapping(value = "/reset-password")
    public ModelAndView resetPassword(@ModelAttribute(name = "modelReset") ResetPasswordRequest params, @RequestParam String token){
        ModelAndView mav = new ModelAndView("reset-password");

        ResetPasswordDTO resetPasswordDTO = IResetPassword.findByToken(token);

        // Check if the token existed and time_expired is available
        if(resetPasswordDTO != null && !resetPasswordDTO.getTimeExpired().isBefore(LocalDateTime.now())){
            mav.addObject("token", resetPasswordDTO.getToken());
        }
        else mav.addObject("token", null);

        return mav;
    }

    // Error page
    @GetMapping(value = "/not-found")
    public ModelAndView notFound(){
        ModelAndView mav = new ModelAndView("/error/404");
        return mav;
    }

    @RequestMapping(value = "/access-denied", method = RequestMethod.GET)
    public ModelAndView accessDenied() {
        return new ModelAndView("redirect:/login?accessDenied");
    }

    // Logout function custom (If you don't use logout() of Spring Security)
//    @GetMapping(value = "/logout")
//    public ModelAndView logout(HttpServletRequest request, HttpServletResponse response){
//        // Get current account
//        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
//
//        // Clear current account's information on server
//        if(auth != null){
//            new SecurityContextLogoutHandler().logout(request, response, auth);
//        }
//
//        return new ModelAndView("redirect:/home");
//    }
}
