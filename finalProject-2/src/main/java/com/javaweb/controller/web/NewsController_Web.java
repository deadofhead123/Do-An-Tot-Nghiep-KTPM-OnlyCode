package com.javaweb.controller.web;

import com.javaweb.model.dto.NewsDTO;
import com.javaweb.model.dto.NewsTypeDTO;
import com.javaweb.model.request.NewsSearchRequest;
import com.javaweb.model.response.NewsSearchResponse;
import com.javaweb.service.news.NewsService;
import com.javaweb.util.NewsType;
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
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller(value = "newsControllerOfUser")
@RequiredArgsConstructor
public class NewsController_Web {
    private final NewsService newsService;

    @GetMapping(value = "/news")
    public ModelAndView newsPage(@ModelAttribute("newsSearch")NewsSearchRequest newsSearchRequest, HttpServletRequest request,
                                 @RequestParam(defaultValue = "0") int page,
                                 @RequestParam(defaultValue = "5") int size){
        ModelAndView mav = new ModelAndView("/web/news-files/news");

        Page<NewsSearchResponse> newsList = newsService.findAll_Web(newsSearchRequest, PageRequest.of(page, size));
        mav.addObject("newsList", newsList);

        List<NewsTypeDTO> newsTypeDTOList = new ArrayList<>();

        for(Map.Entry<String, String> item : NewsType.listType().entrySet()){
            NewsTypeDTO newsTypeDTO = new NewsTypeDTO();

            newsTypeDTO.setCode(item.getKey());
            newsTypeDTO.setName(item.getValue());

            NewsSearchRequest newsSearchRequest_1 = new NewsSearchRequest();
            newsSearchRequest_1.setType(item.getKey());

            newsTypeDTO.setTotal(newsService.countTotalItems(newsSearchRequest_1));

            newsTypeDTOList.add(newsTypeDTO);
        }

        List<NewsSearchResponse> mostPopularNews = newsService.findMostPopularNews_Web();
        mav.addObject("mostPopularNews", mostPopularNews);
        mav.addObject("newsTypeList", newsTypeDTOList);

        return mav;
    }

    @GetMapping(value = "/news-single-{id}")
    public ModelAndView newsSingle(@PathVariable("id") Long id){
        ModelAndView mav = new ModelAndView("/web/news-files/news-single");

        NewsDTO newsSingle = newsService.findOneByIdToView(id);

        if(ObjectUtils.isEmpty(newsSingle)){
            return new ModelAndView("redirect:/not-found");
        }

        mav.addObject("newsSingle", newsSingle);

        return mav;
    }
}
