package com.javaweb.repository;

import com.javaweb.entity.FeedbackEntity;
import com.javaweb.repository.custom.FeedbackRepositoryCustom;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FeedbackRepository extends JpaRepository<FeedbackEntity, Long>, FeedbackRepositoryCustom {
}
