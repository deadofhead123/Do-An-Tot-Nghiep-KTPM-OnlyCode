package com.javaweb.controller.web;

import com.javaweb.model.dto.CartDTO;
import com.javaweb.model.dto.FeedbackDTO;
import com.javaweb.model.dto.ProductDTO;
import com.javaweb.model.dto.UserDTO;
import com.javaweb.model.request.ProductSearchRequest;
import com.javaweb.model.response.ProductSearchResponse;
import com.javaweb.security.utils.SecurityUtils;
import com.javaweb.service.cart.ICartService;
import com.javaweb.service.category.ICategoryService;
import com.javaweb.service.feedback.IFeedbackService;
import com.javaweb.service.product.IProductService;
import com.javaweb.service.user.IUserService;
import com.javaweb.util.PaymentMethodCode;
import com.javaweb.util.SortType;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller(value = "shopControllerOfAdmin")
@RequiredArgsConstructor
public class ShopController_Web {
    private final ICategoryService categoryService;
    private final IUserService userService;
    private final IProductService productService;
    private final IFeedbackService feedbackService;
    private final ICartService cartService;

    @GetMapping(value = "/shop")
    public ModelAndView shopPage(@ModelAttribute("productSearch") ProductSearchRequest productSearchRequest,
                                 HttpServletRequest request,
                                 @RequestParam(defaultValue = "0") int page){
        ModelAndView mav = new ModelAndView("/web/shop-files/shop");
        String categoryName = request.getParameter("categoryId");
        String productName = request.getParameter("productName");
        String sortBy = request.getParameter("sortBy");
        String sortName = "Mặc định";
        Integer size = 12;

        if(categoryName != null){
            Long categoryId = Long.parseLong(request.getParameter("categoryId"));
            categoryName = categoryService.findOneById(categoryId).getName();

            productSearchRequest.setCategoryId(categoryId);
        }
        else{
            categoryName = "Tất cả sản phẩm";
        }

        if(productName != null){
            productSearchRequest.setName(productName);
        }
        if(sortBy != null){
            productSearchRequest.setSortBy(sortBy);

            if(sortBy.equals(SortType.DEFAULT.getName())) sortName = "Mặc định";
            else if(sortBy.equals(SortType.NAME.getName())) sortName = "A -> Z";
            else if(sortBy.equals(SortType.NAME_DESC.getName())) sortName = "Z -> A";
            else if(sortBy.equals(SortType.PRICE.getName())) sortName = "Giá tăng dần";
            else if(sortBy.equals(SortType.PRICE_DESC.getName())) sortName = "Giá giảm dần";
            else if(sortBy.equals(SortType.LATEST.getName())) sortName = "Hàng mới nhất";
            else sortName = "Hàng cũ nhất";
        }

        Page<ProductSearchResponse> productSearchResponses = productService.findAll_Web(productSearchRequest, PageRequest.of(page, size));

        mav.addObject("productList", productSearchResponses);
        mav.addObject("categoryName", categoryName);
        mav.addObject("sortName", sortName);

        return mav;
    }

    @GetMapping(value = "/product-single-{id}")
    public ModelAndView productSingle(@PathVariable Long id){
        ModelAndView mav = new ModelAndView("/web/shop-files/product-single");

        ProductDTO productReturn = productService.findOneById(id);

        if(ObjectUtils.isEmpty(productReturn)){
            return new ModelAndView("redirect:/not-found");
        }

        List<FeedbackDTO> allFeedback_Web = feedbackService.findAllFeedback_Web(id, 3);
        List<FeedbackDTO> numberOfFeedback_Web = feedbackService.findAllFeedback_Web(id, 0);

        mav.addObject("productSingle", productReturn);
        mav.addObject("relatedProducts", productService.findRelatedProducts(productReturn.getId(), productReturn.getCategoryId()));

        Double finalRating = 0D;
        if(!numberOfFeedback_Web.isEmpty()){
            for(FeedbackDTO feedbackDTO : numberOfFeedback_Web){
                finalRating = finalRating + feedbackDTO.getRating();
            }
            mav.addObject("finalRating", Math.floor(finalRating / numberOfFeedback_Web.size()));
        }
        else mav.addObject("finalRating", 0);

        mav.addObject("allFeedback", allFeedback_Web);
        mav.addObject("numberOfFeedback", numberOfFeedback_Web.size());

        return mav;
    }

    // Cart
    @GetMapping(value = "/cart")
    public ModelAndView cart(){
        ModelAndView mav = new ModelAndView("web/user/cart");

        List<CartDTO> cartsResult = cartService.findAll();
        UserDTO userDTO = userService.findOneById(SecurityUtils.getPrincipal().getId());

        mav.addObject("carts", cartsResult);
        mav.addObject("discount", userDTO.getDiscount());

        return mav;
    }

    // Checkout
    @GetMapping(value = "/checkout")
    public ModelAndView checkout(@ModelAttribute("userInfo") UserDTO userDTO){
        ModelAndView mav = new ModelAndView("web/user/checkout");

        userDTO = userService.findOneById(SecurityUtils.getPrincipal().getId());

        List<CartDTO> cartDTOs = cartService.findAll();
        Long total = 0L;

        for(CartDTO cartDTO : cartDTOs){
            total += cartDTO.getQuantity() * cartDTO.getProductDTO().getPrice();
        }

        mav.addObject("userInfo", userDTO);
        mav.addObject("totalOfOrder", total);
        mav.addObject("paymentMethod", PaymentMethodCode.getType());
        mav.addObject("discount", userDTO.getDiscount());

        return mav;
    }

    @GetMapping(value = "/order-success")
    public ModelAndView orderSuccess(){
        ModelAndView mav = new ModelAndView("/success/order-success");
        return mav;
    }
}
