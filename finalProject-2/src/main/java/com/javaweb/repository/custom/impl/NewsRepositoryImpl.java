package com.javaweb.repository.custom.impl;

import com.javaweb.constant.SystemConstant;
import com.javaweb.entity.NewsEntity;
import com.javaweb.model.request.NewsSearchRequest;
import com.javaweb.repository.custom.NewsRepositoryCustom;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import java.lang.reflect.Field;
import java.util.List;

@Repository
@RequiredArgsConstructor
public class NewsRepositoryImpl implements NewsRepositoryCustom {
    private final EntityManager entityManager;

    public void queryWhereNormal(NewsSearchRequest newsSearchRequest, StringBuilder where){
        try{
            Field[] fields = NewsSearchRequest.class.getDeclaredFields();

            for(Field field : fields){
                field.setAccessible(true);

                String key = field.getName();

                if(!key.startsWith("view") && !key.startsWith("type")){
                    Object value = field.get(newsSearchRequest);

                    if(value != null && value != ""){
                        where.append(" AND n." + key.toLowerCase() + " LIKE '%" + value + "%' ");
                    }
                }
            }
        }
        catch(Exception ex){
            ex.printStackTrace();
        }
    }

    public void queryWhereSpecial(NewsSearchRequest newsSearchRequest, StringBuilder where){
        Long viewFrom = newsSearchRequest.getViewFrom();
        if(viewFrom != null){
            where.append(" AND n.view >=" + viewFrom + " ");
        }

        Long viewTo = newsSearchRequest.getViewTo();
        if(viewTo != null){
            where.append(" AND n.view <=" + viewTo + " ");
        }

        String type = newsSearchRequest.getType();
        if(type != null && !type.equals("")){
            where.append(" AND n.types LIKE '%" + type + "%' ");
        }
    }

    @Override
    public List<NewsEntity> findAll(NewsSearchRequest newsSearchRequest, Pageable pageable) {
        StringBuilder sql = new StringBuilder(buildSelectQuery());
        StringBuilder where = new StringBuilder(SystemConstant.ONE_EQUAL_ONE);
        Integer realSize;
        StringBuilder sqlFix;

        queryWhereNormal(newsSearchRequest, where);
        queryWhereSpecial(newsSearchRequest, where);

        String sortName = "", sortOrder = "";
        for(Sort.Order item : pageable.getSort()){
            sortName = item.getProperty();
            sortOrder = item.getDirection().toString();
        }

        sql.append(where).append(" AND n.isactive=1 ").append(" ORDER BY n." + sortName.toLowerCase() + " " + sortOrder + " ");

        sqlFix = new StringBuilder(sql);

        sql.append(" LIMIT " + pageable.getPageSize()).append(" OFFSET " + pageable.getOffset());

        Query query = entityManager.createNativeQuery(sql.toString(), NewsEntity.class);

        realSize = query.getResultList().size();

        if(realSize == 0 && pageable.getOffset() > 0){
            Query queryFix = entityManager.createNativeQuery(sqlFix.append(" LIMIT " + pageable.getPageSize())
                                                                    .append(" OFFSET " + (pageable.getOffset() - pageable.getPageSize())).toString(), NewsEntity.class);
            return queryFix.getResultList();
        }

        return query.getResultList();
    }

    @Override
    public Page<NewsEntity> findAll_Web(NewsSearchRequest newsSearchRequest, Pageable pageable) {
        StringBuilder sql = new StringBuilder(buildSelectQuery());
        StringBuilder where = new StringBuilder(SystemConstant.ONE_EQUAL_ONE);

        queryWhereNormal(newsSearchRequest, where);
        queryWhereSpecial(newsSearchRequest, where);

        sql.append(where).append(" AND n.isactive=1 ").append(" ORDER BY n.createdat DESC ");

        Query query = entityManager.createNativeQuery(sql.toString(), NewsEntity.class);
        query.setFirstResult((int) pageable.getOffset());
        query.setMaxResults(pageable.getPageSize());

        return new PageImpl<>(query.getResultList(), pageable, countTotalItems(newsSearchRequest));
    }

    @Override
    public int countTotalItems(NewsSearchRequest newsSearchRequest) {
        StringBuilder sql = new StringBuilder(buildSelectQuery());
        StringBuilder where = new StringBuilder(SystemConstant.ONE_EQUAL_ONE);

        queryWhereNormal(newsSearchRequest, where);
        queryWhereSpecial(newsSearchRequest, where);

        sql.append(where).append(" AND n.isactive=1 ");

        Query query = entityManager.createNativeQuery(sql.toString(), NewsEntity.class);

        return query.getResultList().size();
    }

    public String buildSelectQuery(){
        return "SELECT n.* FROM news n ";
    }
}
