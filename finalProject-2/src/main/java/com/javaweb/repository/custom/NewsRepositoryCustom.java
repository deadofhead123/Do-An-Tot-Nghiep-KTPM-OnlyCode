package com.javaweb.repository.custom;

import com.javaweb.entity.NewsEntity;
import com.javaweb.model.request.NewsSearchRequest;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface NewsRepositoryCustom {
    List<NewsEntity> findAll(NewsSearchRequest newsSearchRequest, Pageable pageable);
    Page<NewsEntity> findAll_Web(NewsSearchRequest newsSearchRequest, Pageable pageable);
    int countTotalItems(NewsSearchRequest newsSearchRequest);
}
