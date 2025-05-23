package com.javaweb.controller.admin;

import com.javaweb.constant.SystemConstant;
import com.javaweb.model.dto.CategoryDTO;
import com.javaweb.model.request.CategorySearchRequest;
import com.javaweb.model.response.CategorySearchResponse;
import com.javaweb.service.category.ICategoryService;
import com.javaweb.util.DisplayTagUtils;
import com.javaweb.util.MessageUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
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

@Controller(value = "categoryControllerOfAdmin")
public class CategoryController {
    @Autowired
    private ICategoryService categoryService;

    @Autowired
    private MessageUtils messageUtil;

    @GetMapping(value = "/admin/category-child-list")
    public ModelAndView parentCategoryList(@ModelAttribute("categorySearch") CategorySearchRequest categorySearchRequest, HttpServletRequest request){
        ModelAndView mav = new ModelAndView("/admin/category/child-list");

        CategorySearchResponse categorySearchResponse = new CategorySearchResponse();

        DisplayTagUtils.of(request, categorySearchResponse);
        categorySearchResponse.setListResult
                (categoryService.findAll(categorySearchRequest,
                        PageRequest.of(categorySearchResponse.getPage() - 1, categorySearchResponse.getMaxPageItems(), Sort.by(Sort.Direction.valueOf(categorySearchResponse.getSortOrder()), categorySearchResponse.getSortName()))));
        categorySearchResponse.setTotalItems(categoryService.countTotalItems(categorySearchRequest));

        mav.addObject("categorySearchResponseList", categorySearchResponse);
        mav.addObject("parentCategories", categoryService.findCategories(null));
        initMessageResponse(mav, request);

        return mav;
    }

    @GetMapping(value = "/admin/category-parent-list")
    public ModelAndView childCategoryList(@ModelAttribute("categorySearch") CategorySearchRequest categorySearchRequest, HttpServletRequest request){
        ModelAndView mav = new ModelAndView("/admin/category/parent-list");

        CategorySearchResponse categorySearchResponse = new CategorySearchResponse();

        categorySearchRequest.setIsSearchingParent(1);

        DisplayTagUtils.of(request, categorySearchResponse);
        categorySearchResponse.setListResult
                (categoryService.findAll(categorySearchRequest,
                                        PageRequest.of(categorySearchResponse.getPage() - 1, categorySearchResponse.getMaxPageItems(), Sort.by(Sort.Direction.valueOf(categorySearchResponse.getSortOrder()), categorySearchResponse.getSortName()))));
        categorySearchResponse.setTotalItems(categoryService.countTotalItems(categorySearchRequest));

        mav.addObject("categorySearchResponseList", categorySearchResponse);
        initMessageResponse(mav, request);

        return mav;
    }

    @GetMapping(value = "/admin/category-edit")
    public ModelAndView addCategory(@ModelAttribute("categoryEdit") CategoryDTO categoryDTO, HttpServletRequest request){
        ModelAndView mav = new ModelAndView("/admin/category/edit");
        mav.addObject("parentCategories", categoryService.findCategories(null));
        initMessageResponse(mav, request);
        return mav;
    }

    @GetMapping(value = "/admin/category-edit-{id}")
    public ModelAndView updateCategory(@ModelAttribute("categoryEdit") CategoryDTO categoryDTO, @PathVariable("id") Long id, HttpServletRequest request){
        ModelAndView mav = new ModelAndView("/admin/category/edit");

        CategoryDTO categoryReturn = categoryService.findOneById(id);

        if(ObjectUtils.isEmpty(categoryReturn)){
            return new ModelAndView("redirect:/not-found");
        }

        if(categoryReturn.getParentId() !=  null){
            mav.addObject(SystemConstant.URL_BACK, "/admin/category-child-list");
        }
        else{
            mav.addObject(SystemConstant.URL_BACK, "/admin/category-parent-list");
        }

        mav.addObject("categoryEdit", categoryReturn);
        mav.addObject("parentCategories", categoryService.findCategories(null));
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
