package com.javaweb.service.news;

import com.javaweb.model.dto.NewsDTO;
import com.javaweb.model.request.NewsSearchRequest;
import com.javaweb.model.response.NewsSearchResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface INewsService {
    List<NewsSearchResponse> findAll(NewsSearchRequest newsSearchRequest, Pageable pageable);
    NewsDTO findOneById(Long id);
    NewsDTO findOneByIdToView(Long id);
    List<NewsSearchResponse> findMostPopularNews_Web();

    void editNews(NewsDTO newsDTO);
    void deleteAllNewsSelected(List<Long> ids);

    int countTotalItems(NewsSearchRequest newsSearchRequest);

    Page<NewsSearchResponse> findAll_Web(NewsSearchRequest newsSearchRequest, Pageable pageable);
}
