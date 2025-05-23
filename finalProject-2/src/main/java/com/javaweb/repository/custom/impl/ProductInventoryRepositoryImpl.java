package com.javaweb.repository.custom.impl;

import com.javaweb.constant.SystemConstant;
import com.javaweb.entity.ProductInventoryEntity;
import com.javaweb.model.request.ProductInventorySearchRequest;
import com.javaweb.repository.custom.ProductInventoryRepositoryCustom;
import com.javaweb.util.ProductInventoryStatus;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import java.lang.reflect.Field;
import java.util.List;

@Repository
@RequiredArgsConstructor
public class ProductInventoryRepositoryImpl implements ProductInventoryRepositoryCustom {
    private final EntityManager entityManager;

    public void queryJoin(ProductInventorySearchRequest productInventorySearchRequest, StringBuilder join){
        String name = productInventorySearchRequest.getName();
        if(name != null && !name.equals("")){
            join.append(" INNER JOIN products p ON pi.productid = p.id ");
        }

        Long categoryId = productInventorySearchRequest.getCategoryId();
        if(categoryId != null){
            join.append(" INNER JOIN product_category pc ON pi.productid = pc.productid ");
        }
    }

    public void queryWhereNormal(ProductInventorySearchRequest productInventorySearchRequest, StringBuilder where){
        try{
            Field[] fields = ProductInventorySearchRequest.class.getDeclaredFields();

            for(Field field : fields){
                field.setAccessible(true);

                String key = field.getName();

                if(!key.startsWith("createdAt") && !key.startsWith("category") && !key.startsWith("name") && !key.startsWith("statusTime")){
                    Object value = field.get(productInventorySearchRequest);

                    if( value != "" && value != null ){
                        if(value.getClass().getName().equals("java.lang.String")){
                            where.append(" AND pi." + key.toLowerCase() + " LIKE '%" + value + "%' ");
                        }
                        else{
                            where.append(" AND pi." + key.toLowerCase() + "=" + value + " ");
                        }
                    }
                }
            }
        }
        catch(Exception ex){
            ex.printStackTrace();
        }
    }

    public void queryWhereSpecial(ProductInventorySearchRequest productInventorySearchRequest, StringBuilder where){
        String name = productInventorySearchRequest.getName();
        if(name != null && !name.equals("")){
            where.append(" AND p.name LIKE '%" + name + "%' ");
        }

        Long categoryId = productInventorySearchRequest.getCategoryId();
        if(categoryId != null){
            where.append(" AND pc.categoryid = " + categoryId + " ");
        }

        String status = productInventorySearchRequest.getStatus();
        if(status != null && !status.isEmpty()){
            String statusTimeFrom = productInventorySearchRequest.getStatusTimeFrom();
            if(statusTimeFrom != null && !statusTimeFrom.equals("")){
                if(status.equals(ProductInventoryStatus.UNUSED.toString())){
                    where.append(" AND DATE(pi.createdat) >= DATE('" + statusTimeFrom + "') ");
                }
                else{
                    where.append(" AND DATE(pi.modifiedat) >= DATE('" + statusTimeFrom + "') ");
                }
            }

            String statusTimeTo = productInventorySearchRequest.getStatusTimeTo();
            if(statusTimeTo != null && !statusTimeTo.equals("")){
                if(status.equals(ProductInventoryStatus.UNUSED.toString())){
                    where.append(" AND DATE(pi.createdat) <= DATE('" + statusTimeTo + "') ");
                }
                else{
                    where.append(" AND DATE(pi.modifiedat) <= DATE('" + statusTimeTo + "') ");
                }
            }
        }
    }

    @Override
    public List<ProductInventoryEntity> findAll(ProductInventorySearchRequest productInventorySearchRequest, Pageable pageable) {
        StringBuilder sql = new StringBuilder(buildSelectQuery());
        StringBuilder join = new StringBuilder(" ");
        StringBuilder where = new StringBuilder(SystemConstant.ONE_EQUAL_ONE);

        queryJoin(productInventorySearchRequest, join);
        queryWhereNormal(productInventorySearchRequest, where);
        queryWhereSpecial(productInventorySearchRequest, where);

        String sortName = "", sortOrder = "";
        for(Sort.Order item : pageable.getSort()){
            sortName = item.getProperty();
            sortOrder = item.getDirection().toString();
        }

        sql.append(join).append(where)
                .append(" GROUP BY pi.id ")
                .append(" ORDER BY pi." + sortName.toLowerCase() + " " + sortOrder + " ");
//                .append(" LIMIT ").append(pageable.getPageSize())
//                .append(" OFFSET ").append(pageable.getOffset());
        System.out.println(sql);

        Query query = entityManager.createNativeQuery(sql.toString(), ProductInventoryEntity.class);

        return query.getResultList();
    }

    @Override
    public int countTotalItems(ProductInventorySearchRequest productInventorySearchRequest) {
        StringBuilder sql = new StringBuilder(buildSelectQuery());
        StringBuilder join = new StringBuilder(" ");
        StringBuilder where = new StringBuilder(SystemConstant.ONE_EQUAL_ONE);

        queryJoin(productInventorySearchRequest, join);
        queryWhereNormal(productInventorySearchRequest, where);
        queryWhereSpecial(productInventorySearchRequest, where);

        sql.append(join).append(where).append(" GROUP BY pi.id ");

        System.out.println(sql);

        Query query = entityManager.createNativeQuery(sql.toString(), ProductInventoryEntity.class);

        return query.getResultList().size();
    }

    public String buildSelectQuery(){
        return "SELECT pi.* FROM product_inventory pi ";
    }
}
