package com.javaweb.controller.admin;

import com.javaweb.constant.SystemConstant;
import com.javaweb.model.dto.NewsDTO;
import com.javaweb.model.request.NewsSearchRequest;
import com.javaweb.model.response.NewsSearchResponse;
import com.javaweb.service.news.INewsService;
import com.javaweb.util.DisplayTagUtils;
import com.javaweb.util.HotType;
import com.javaweb.util.MessageUtils;
import com.javaweb.util.NewsType;
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

@Controller(value = "newControllerOfAdmin")
@RequiredArgsConstructor
public class NewsController {
    private final INewsService newsService;
    private final MessageUtils messageUtil;

    @GetMapping(value = "/admin/news-list")
    public ModelAndView listNews(@ModelAttribute("newsSearch") NewsSearchRequest newsSearchRequest, HttpServletRequest request){
        ModelAndView mav = new ModelAndView("/admin/news/list");

        NewsSearchResponse newsSearchResponse = new NewsSearchResponse();

        DisplayTagUtils.of(request, newsSearchResponse);
        newsSearchResponse.setListResult(newsService.findAll(newsSearchRequest, PageRequest.of(newsSearchResponse.getPage() - 1, newsSearchResponse.getMaxPageItems())));
        newsSearchResponse.setTotalItems(newsService.countTotalItems(newsSearchRequest));

        initMessageResponse(mav, request);
        mav.addObject("newsSearchResponse", newsSearchResponse);
        mav.addObject("typeList", NewsType.listType());
        mav.addObject("hotType", HotType.getType());

        return mav;
    }

    @GetMapping(value = "/admin/news-edit")
    public ModelAndView addNews(@ModelAttribute("newEdit") NewsDTO newsEdit, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/admin/news/edit");

        mav.addObject("newsEdit", newsEdit);
        mav.addObject("typeList", NewsType.listType());
        mav.addObject("hotType", HotType.getType());
        initMessageResponse(mav, request);

        return mav;
    }

    @GetMapping(value = "/admin/news-edit-{id}")
    public ModelAndView updateNews(@ModelAttribute("singleNewEdit") NewsDTO newsEdit, @PathVariable("id") Long id, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/admin/news/edit");

        NewsDTO newsReturn = newsService.findOneById(id);

        if(ObjectUtils.isEmpty(newsReturn)){
            return new ModelAndView("redirect:/not-found");
        }

        mav.addObject("newsEdit", newsReturn);
        mav.addObject("typeList", NewsType.listType());
        mav.addObject("hotType", HotType.getType());
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
