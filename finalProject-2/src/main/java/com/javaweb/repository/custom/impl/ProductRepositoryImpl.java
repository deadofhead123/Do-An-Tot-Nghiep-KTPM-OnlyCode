package com.javaweb.repository.custom.impl;

import com.javaweb.constant.SystemConstant;
import com.javaweb.entity.ProductEntity;
import com.javaweb.model.request.ProductSearchRequest;
import com.javaweb.repository.custom.ProductRepositoryCustom;
import com.javaweb.util.IsOutOfQuantity;
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
public class ProductRepositoryImpl implements ProductRepositoryCustom {
    private final EntityManager entityManager;

    public void queryJoin(ProductSearchRequest productSearchRequest, StringBuilder join){
        Long categoryId = productSearchRequest.getCategoryId();

        if(categoryId != null){
            join.append(" INNER JOIN product_category pc ON pc.productid = p.id ");
        }
    }

    public void queryWhereNormal(ProductSearchRequest productSearchRequest, StringBuilder where){
        try{
            Field[] fields = ProductSearchRequest.class.getDeclaredFields();

            for(Field field : fields){
                field.setAccessible(true);

                String key = field.getName();

                if(!key.startsWith("category") && !key.startsWith("price") && !key.startsWith("sort") && !key.startsWith("isOut")){
                    Object value = field.get(productSearchRequest);

                    if(value != null && value != ""){
                        where.append(" AND p." + key.toLowerCase() + " LIKE '%" + value + "%' ");
                    }
                }
            }
        }
        catch(Exception ex){
            ex.printStackTrace();
        }
    }

    public void queryWhereSpecial(ProductSearchRequest productSearchRequest, StringBuilder where){
        Long categoryId = productSearchRequest.getCategoryId();

        if(categoryId != null){
            where.append(" AND pc.categoryid= " + categoryId);
        }

        Long priceFrom = productSearchRequest.getPriceFrom();
        Long priceTo = productSearchRequest.getPriceTo();

        if(priceFrom != null){
            where.append(" AND p.price >= " + priceFrom);
        }

        if(priceTo != null){
            where.append(" AND p.price <= " + priceTo);
        }

        String isOutOfQuantity = productSearchRequest.getIsOutOfQuantity();
        if(isOutOfQuantity != null){
            if(isOutOfQuantity.equals(IsOutOfQuantity.YES.toString())) where.append(" AND p.quantity <= " + SystemConstant.NEAR_OUT_OF_QUANTITY + " ");
        }
    }

    @Override
    public List<ProductEntity> findAll(ProductSearchRequest productSearchRequest, Pageable pageable) {
        StringBuilder sql = new StringBuilder(buildSelectQuery());
        StringBuilder join = new StringBuilder(" ");
        StringBuilder where = new StringBuilder(SystemConstant.ONE_EQUAL_ONE);
        Integer realSize;
        StringBuilder sqlFix;

        queryJoin(productSearchRequest, join);
        queryWhereNormal(productSearchRequest, where);
        queryWhereSpecial(productSearchRequest, where);

        String sortName = "", sortOrder = "";
        for(Sort.Order item : pageable.getSort()){
            sortName = item.getProperty();
            sortOrder = item.getDirection().toString();
        }

        sql.append(join).append(where).append(" AND p.isactive=1 ")
                .append(" GROUP BY p.id ")
                .append(" ORDER BY p." + sortName.toLowerCase() + " " + sortOrder + " ");

        sqlFix = new StringBuilder(sql);

        sql.append(" LIMIT " + pageable.getPageSize()).append(" OFFSET " + pageable.getOffset());

        Query query = entityManager.createNativeQuery(sql.toString(), ProductEntity.class);

        realSize = query.getResultList().size();

        if(realSize == 0 && pageable.getOffset() > 0){
            Query queryFix = entityManager.createNativeQuery(sqlFix.append(" LIMIT " + pageable.getPageSize())
                                                                    .append(" OFFSET " + (pageable.getOffset() - pageable.getPageSize())).toString(), ProductEntity.class);
            return queryFix.getResultList();
        }

        return query.getResultList();
    }

    @Override
    public Page<ProductEntity> findAll_Web(ProductSearchRequest productSearchRequest, Pageable pageable) {
        StringBuilder sql = new StringBuilder(buildSelectQuery());
        StringBuilder join = new StringBuilder(" ");
        StringBuilder where = new StringBuilder(SystemConstant.ONE_EQUAL_ONE);

        queryJoin(productSearchRequest, join);
        queryWhereNormal(productSearchRequest, where);
        queryWhereSpecial(productSearchRequest, where);

        sql.append(join).append(where)
                .append(" AND p.isactive=1 ");

        if(productSearchRequest.getSortBy() == null){
            sql.append(" ORDER BY p.createdat DESC ");
        }
        else{
            String sortField = productSearchRequest.getSortBy();

            if(!sortField.startsWith("price")){
                if(!sortField.contains("-")){
                    sql.append(" ORDER BY p." + sortField + " ");
                }
                else{
                    sql.append(" ORDER BY p." + sortField.split("-")[0] + " DESC ");
                }
            }
            else{
                if(!sortField.contains("-")){
                    sql.append(" ORDER BY (p.price - p.price * p.discount) ");
                }
                else{
                    sql.append(" ORDER BY (p.price - p.price * p.discount) DESC ");
                }
            }
        }

        Query query = entityManager.createNativeQuery(sql.toString(), ProductEntity.class);
        query.setFirstResult((int) pageable.getOffset());
        query.setMaxResults(pageable.getPageSize());

        Integer totalItems = countTotalItems(productSearchRequest);
        if(totalItems == 0) totalItems = 1;

        return new PageImpl<>(query.getResultList(), pageable, totalItems);
    }

    @Override
    public int countTotalItems(ProductSearchRequest productSearchRequest) {
        StringBuilder sql = new StringBuilder(buildSelectQuery());
        StringBuilder join = new StringBuilder(" ");
        StringBuilder where = new StringBuilder(SystemConstant.ONE_EQUAL_ONE);

        queryJoin(productSearchRequest, join);
        queryWhereNormal(productSearchRequest, where);
        queryWhereSpecial(productSearchRequest, where);

        sql.append(join).append(where).append(" AND p.isactive=1 ");

        Query query = entityManager.createNativeQuery(sql.toString(), ProductEntity.class);

        return query.getResultList().size();
    }

    public String buildSelectQuery(){
        return "SELECT p.* FROM products p ";
    }
}
