package com.javaweb.repository.custom.impl;

import com.javaweb.constant.SystemConstant;
import com.javaweb.entity.OrderEntity;
import com.javaweb.model.request.OrderSearchRequest;
import com.javaweb.repository.custom.OrderRepositoryCustom;
import com.javaweb.security.utils.SecurityUtils;
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
public class OrderRepositoryImpl implements OrderRepositoryCustom {
    private final EntityManager entityManager;

    public void queryJoin(OrderSearchRequest orderSearchRequest, StringBuilder join){

    }

    public void queryWhereNormal(OrderSearchRequest orderSearchRequest, StringBuilder where){
        try{
            Field[] fields = OrderSearchRequest.class.getDeclaredFields();

            for(Field field : fields){
                field.setAccessible(true);

                String key = field.getName();

                if(!key.startsWith("createdAt")){
                    Object value = field.get(orderSearchRequest);

                    if(value != null && value != ""){
                        if(value.getClass().getName().equals("java.lang.String")){
                            where.append(" AND od." + key.toLowerCase() + " LIKE '%" + value + "%' ");
                        }
                        else{
                            where.append(" AND od." + key.toLowerCase() + " =" + value + " ");
                        }
                    }
                }
            }
        }
        catch(Exception ex){
            ex.printStackTrace();
        }
    }

    public void queryWhereSpecial(OrderSearchRequest orderSearchRequest, StringBuilder where){
        String createdAtFrom = orderSearchRequest.getCreatedAtFrom();

        if(createdAtFrom != null && !createdAtFrom.equals("")){
            where.append(" AND DATE(od.createdat) >= '" + createdAtFrom + "' ");
        }

        String createdAtTo = orderSearchRequest.getCreatedAtTo();

        if(createdAtTo != null && !createdAtTo.equals("")){
            where.append(" AND DATE(od.createdat) <= '" + createdAtTo + "' ");
        }
    }

    @Override
    public List<OrderEntity> findAll(OrderSearchRequest orderSearchRequest, Pageable pageable) {
        StringBuilder sql = new StringBuilder(buildSelectQuery());
        StringBuilder join = new StringBuilder(" ");
        StringBuilder where = new StringBuilder(SystemConstant.ONE_EQUAL_ONE);

        queryJoin(orderSearchRequest, join);
        queryWhereNormal(orderSearchRequest, where);
        queryWhereSpecial(orderSearchRequest, where);

        String sortName = "", sortOrder = "";
        for(Sort.Order item : pageable.getSort()){
            sortName = item.getProperty();
            sortOrder = item.getDirection().toString();
        }

        sql.append(where)
                .append(" GROUP BY od.id ")
                .append(" ORDER BY od." + sortName.toLowerCase() + " " + sortOrder + " ");

//        sql.append(" LIMIT " + pageable.getPageSize()).append(" OFFSET " + pageable.getOffset());

        Query query = entityManager.createNativeQuery(sql.toString(), OrderEntity.class);

        return query.getResultList();
    }

    @Override
    public int countTotalItems(OrderSearchRequest orderSearchRequest) {
        StringBuilder sql = new StringBuilder(buildSelectQuery());
        StringBuilder join = new StringBuilder(" ");
        StringBuilder where = new StringBuilder(SystemConstant.ONE_EQUAL_ONE);

        queryJoin(orderSearchRequest, join);
        queryWhereNormal(orderSearchRequest, where);
        queryWhereSpecial(orderSearchRequest, where);

        sql.append(where)
                .append(" GROUP BY od.id ");

        Query query = entityManager.createNativeQuery(sql.toString(), OrderEntity.class);

        return query.getResultList().size();
    }

    @Override
    public Page<OrderEntity> findAllByUserEntity(Pageable pageable) {
        StringBuilder sql = new StringBuilder(buildSelectQuery());
        StringBuilder where = new StringBuilder(" WHERE 1=1 ");

        sql.append(where).append(" AND userid=" + SecurityUtils.getPrincipal().getId())
                         .append(" ORDER BY od.createdat DESC ");

        Query query = entityManager.createNativeQuery(sql.toString(), OrderEntity.class);
        query.setFirstResult((int) pageable.getOffset());
        query.setMaxResults(pageable.getPageSize());

        return new PageImpl<>(query.getResultList(), pageable, countTotalItems_Web());
    }

    @Override
    public int countTotalItems_Web(){
        StringBuilder sql = new StringBuilder(buildSelectQuery());
        StringBuilder where = new StringBuilder(" WHERE 1=1 ");

        sql.append(where).append(" AND userid=" + SecurityUtils.getPrincipal().getId())
                         .append(" ORDER BY od.createdat DESC ");

        Query query = entityManager.createNativeQuery(sql.toString(), OrderEntity.class);

        return query.getResultList().size();
    }

    public String buildSelectQuery(){
        return "SELECT od.* FROM orders od ";
    }
}
