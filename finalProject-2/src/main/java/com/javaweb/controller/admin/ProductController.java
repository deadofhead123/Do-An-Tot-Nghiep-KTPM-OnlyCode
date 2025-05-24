package com.javaweb.controller.admin;

import com.javaweb.constant.SystemConstant;
import com.javaweb.model.dto.FeedbackDTO;
import com.javaweb.model.dto.ProductDTO;
import com.javaweb.model.request.ProductSearchRequest;
import com.javaweb.model.response.ProductSearchResponse;
import com.javaweb.service.category.ICategoryService;
import com.javaweb.service.feedback.IFeedbackService;
import com.javaweb.service.product.IProductService;
import com.javaweb.util.*;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang.StringUtils;
import org.displaytag.tags.TableTagParameters;
import org.displaytag.util.ParamEncoder;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

@Controller(value = "productControllerOfAdmin")
@RequiredArgsConstructor
public class ProductController {
    private final MessageUtils messageUtil;
    private final ICategoryService categoryService;
    private final IProductService productService;
    private final IFeedbackService feedbackService;

    @GetMapping(value = "/admin/product-list")
    public ModelAndView productList(@ModelAttribute("productSearch") ProductSearchRequest productSearchRequest, HttpServletRequest request){
        ModelAndView mav = new ModelAndView("admin/product/list");

        ProductSearchResponse productSearchResponse = new ProductSearchResponse();

        DisplayTagUtils.of(request, productSearchResponse);
        productSearchResponse.setListResult(productService.findAll(productSearchRequest,
                                                            PageRequest.of(productSearchResponse.getPage() - 1, productSearchResponse.getMaxPageItems(), Sort.by(Sort.Direction.valueOf(productSearchResponse.getSortOrder()), productSearchResponse.getSortName()))));
        productSearchResponse.setTotalItems(productService.countTotalItems(productSearchRequest));

        mav.addObject("productSearchResponse", productSearchResponse);
        mav.addObject("categories", categoryService.findAllNotPaging());
        mav.addObject("hotType", HotType.getType());
        mav.addObject("isOutOfQuantity", IsOutOfQuantity.getType());
        mav.addObject("tableId", new ParamEncoder(productSearchResponse.getTableId()).encodeParameterName(TableTagParameters.PARAMETER_PAGE)); // Ex: d-(id encoded)-p-(number of page if exists)

        return mav;
    }

    @GetMapping(value = "/admin/product-edit")
    public ModelAndView addProduct(@ModelAttribute("productEdit") ProductDTO productDTO, HttpServletRequest request){
        ModelAndView mav = new ModelAndView("admin/product/edit");

        mav.addObject("productEdit", productDTO);
        mav.addObject("categoryList", categoryService.findAllNotPaging());
        mav.addObject("hotType", HotType.getType());
        initMessageResponse(mav, request);

        return mav;
    }

    @GetMapping(value = "/admin/product-edit-{id}")
    public ModelAndView addProduct(@ModelAttribute("productEdit") ProductDTO productDTO, @PathVariable("id") Long id, HttpServletRequest request){
        ModelAndView mav = new ModelAndView("admin/product/edit");

        ProductDTO productEdit = productService.findOneById(id);

        if(ObjectUtils.isEmpty(productEdit)){
            return new ModelAndView("redirect:/not-found");
        }

        mav.addObject("categoryList", categoryService.findAllNotPaging());
        mav.addObject("productType", ProductType.getType());
        mav.addObject("productEdit", productEdit);
        mav.addObject("hotType", HotType.getType());
        initMessageResponse(mav, request);

        FeedbackDTO feedbackResult = new FeedbackDTO();
        DisplayTagUtils.of(request, feedbackResult);
        feedbackResult.setListResult(feedbackService.findAllFeedback(id, PageRequest.of(feedbackResult.getPage() - 1, feedbackResult.getMaxPageItems())));
        feedbackResult.setTotalItems(feedbackService.countTotalItems(id));
        mav.addObject("allFeedback", feedbackResult);
        mav.addObject("numberOfFeedback", feedbackService.findAllFeedback_Web(id, 0).size());

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
