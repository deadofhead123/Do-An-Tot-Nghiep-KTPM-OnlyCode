package com.javaweb.repository.custom.impl;

import com.javaweb.constant.SystemConstant;
import com.javaweb.entity.FeedbackEntity;
import com.javaweb.repository.custom.FeedbackRepositoryCustom;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import java.util.List;

@Repository
@RequiredArgsConstructor
public class FeedbackRepositoryImpl implements FeedbackRepositoryCustom {
    private final EntityManager entityManager;

    @Override
    public List<FeedbackEntity> findAll(Long productId, Pageable pageable) {
        StringBuilder sql = new StringBuilder(buildSelectQuery());
        StringBuilder where = new StringBuilder(SystemConstant.ONE_EQUAL_ONE);

        sql.append(where)
                .append(" AND fb.productid = " + productId)
                .append(" ORDER BY fb.createdat DESC ")
                .append(" LIMIT " + pageable.getPageSize())
                .append(" OFFSET " + pageable.getOffset());

        Query query = entityManager.createNativeQuery(sql.toString(), FeedbackEntity.class);

        return query.getResultList();
    }

    @Override
    public List<FeedbackEntity> findAll_Web(Long productId, Integer size) {
        StringBuilder sql = new StringBuilder(buildSelectQuery());
        StringBuilder where = new StringBuilder(SystemConstant.ONE_EQUAL_ONE);

        sql.append(where)
                .append(" AND fb.productid = " + productId);

        if(size != 0) sql.append(" ORDER BY fb.createdat DESC ").append(" LIMIT " + size);

        Query query = entityManager.createNativeQuery(sql.toString(), FeedbackEntity.class);

        return query.getResultList();
    }

    @Override
    public int countTotalItems(Long productId) {
        StringBuilder sql = new StringBuilder(buildSelectQuery());
        StringBuilder where = new StringBuilder(SystemConstant.ONE_EQUAL_ONE);

        sql.append(where).append(" AND fb.productid = " + productId);

        Query query = entityManager.createNativeQuery(sql.toString(), FeedbackEntity.class);

        return query.getResultList().size();
    }

    public String buildSelectQuery(){
        return "SELECT fb.* FROM feedback fb ";
    }
}
