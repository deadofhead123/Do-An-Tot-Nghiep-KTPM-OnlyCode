package com.javaweb.repository;

import com.javaweb.entity.NewsEntity;
import com.javaweb.repository.custom.NewsRepositoryCustom;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface NewsRepository extends JpaRepository<NewsEntity, Long>, NewsRepositoryCustom {
    NewsEntity findOneByIdAndIsActive(Long id, Integer isActive);

    @Query(value = "SELECT n.* FROM news n WHERE n.isactive = 1 AND n.hot = 'YES' ORDER BY n.createdat DESC LIMIT 3 ", nativeQuery = true)
    List<NewsEntity> findHotWithLimit();

    @Query(value = "SELECT SUM(views) FROM news", nativeQuery = true)
    Long countAllViews();
}
