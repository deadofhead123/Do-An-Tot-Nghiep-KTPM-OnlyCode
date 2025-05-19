package com.javaweb.controller.admin;

import com.javaweb.constant.SystemConstant;
import com.javaweb.model.dto.ProductInventoryDTO;
import com.javaweb.model.request.ProductInventorySearchRequest;
import com.javaweb.model.response.ProductInventorySearchResponse;
import com.javaweb.service.category.CategoryService;
import com.javaweb.service.productInventory.IProductInventoryService;
import com.javaweb.util.DisplayTagUtils;
import com.javaweb.util.MessageUtils;
import com.javaweb.util.ProductInventoryStatus;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang.StringUtils;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

@Controller(value = "productInventoryControllerOfAdmin")
@RequiredArgsConstructor
public class ProductInventoryController {
    private final IProductInventoryService productInventoryService;
    private final CategoryService categoryService;
    private final MessageUtils messageUtil;

    @GetMapping(value = "/admin/productInventory-list")
    public ModelAndView productInventoryList(@ModelAttribute("productInventorySearch") ProductInventorySearchRequest productInventorySearchRequest, HttpServletRequest request){
        ModelAndView mav = new ModelAndView("/admin/product-inventory/list");

        ProductInventorySearchResponse productInventorySearchResponse = new ProductInventorySearchResponse();

        DisplayTagUtils.of(request, productInventorySearchResponse);
        productInventorySearchResponse.setListResult
                (productInventoryService.findAll(productInventorySearchRequest, PageRequest.of(productInventorySearchResponse.getPage() - 1, productInventorySearchResponse.getMaxPageItems())));
        productInventorySearchResponse.setTotalItems(productInventoryService.countTotalItems(productInventorySearchRequest));

        mav.addObject("productInventorySearchResponse", productInventorySearchResponse);
        mav.addObject("productInventoryStatus", ProductInventoryStatus.getStatus());
        mav.addObject("categories", categoryService.findAllNotPaging());

        return mav;
    }

    @GetMapping(value = "/admin/productInventory-detail-{id}")
    public ModelAndView addProduct(@ModelAttribute("productInventoryEdit") ProductInventoryDTO productInventoryDTO, @PathVariable("id") Long id, HttpServletRequest request){
        ModelAndView mav = new ModelAndView("admin/product-inventory/detail");

        productInventoryDTO  = productInventoryService.findOneById(id);

        if(ObjectUtils.isEmpty(productInventoryDTO)){
            return new ModelAndView("redirect:/not-found");
        }

        mav.addObject("categoryList", categoryService.findAllNotPaging());
        mav.addObject("productInventoryStatus", ProductInventoryStatus.getStatus());
        mav.addObject("productInventoryEdit", productInventoryDTO);

        return mav;
    }

    @GetMapping(value = "/admin/productInventory-drop")
    public ModelAndView createImport(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/admin/product-inventory/drop-create");

        initMessageResponse(mav, request);
        mav.addObject("productInventoryAvailableList", productInventoryService.findAllUnusedNotPaging());

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
