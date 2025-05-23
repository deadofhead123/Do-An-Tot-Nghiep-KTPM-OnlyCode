package com.javaweb.repository.custom.impl;

import com.javaweb.entity.SupplierEntity;
import com.javaweb.model.request.SupplierSearchRequest;
import com.javaweb.repository.custom.SupplierRepositoryCustom;
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
public class SupplierRepositoryImpl implements SupplierRepositoryCustom {
    private final EntityManager entityManager;

    public void queryWhereNormal(SupplierSearchRequest supplierSearchRequest, StringBuilder where){
        try{
            Field[] fields = SupplierSearchRequest.class.getDeclaredFields();

            for(Field field : fields){
                field.setAccessible(true);

                String key = field.getName();

                if(!key.startsWith("createdAt")){
                    Object value = field.get(supplierSearchRequest);

                    if( value != "" && value != null ){
                        if(value.getClass().getName().equals("java.lang.String") || value.getClass().getName().equals("java.lang.Date")){
                            where.append(" AND sp." + key.toLowerCase() + " LIKE '%" + value + "%' ");
                        }
                        else{
                            where.append(" AND sp." + key.toLowerCase() + "=" + value + " ");
                        }
                    }
                }
            }
        }
        catch(Exception ex){
            ex.printStackTrace();
        }
    }

    public void queryWhereSpecial(SupplierSearchRequest supplierSearchRequest, StringBuilder where){
        String createdAtFrom = supplierSearchRequest.getCreatedAtFrom();

        if(createdAtFrom != null && !createdAtFrom.equals("")){
            where.append(" AND DATE(sp.createdat) >= DATE('" + createdAtFrom + "') ");
        }

        String createdAtTo = supplierSearchRequest.getCreatedAtTo();

        if(createdAtTo != null && !createdAtTo.equals("")){
            where.append(" AND DATE(sp.createdat) <= DATE('" + createdAtTo + "') ");
        }
    }

    @Override
    public List<SupplierEntity> findAll(SupplierSearchRequest supplierSearchRequest, Pageable pageable) {
        StringBuilder sql = new StringBuilder(buildSelectQuery());
        StringBuilder join = new StringBuilder(" ");
        StringBuilder where = new StringBuilder(" WHERE 1=1 ");

        queryWhereNormal(supplierSearchRequest, where);
        queryWhereSpecial(supplierSearchRequest, where);

        String sortName = "", sortOrder = "";
        for(Sort.Order item : pageable.getSort()){
            sortName = item.getProperty();
            sortOrder = item.getDirection().toString();
        }

        sql.append(join).append(where)
                .append(" GROUP BY sp.id ")
                .append(" ORDER BY sp." + sortName.toLowerCase() + " " + sortOrder + " ")
                .append(" LIMIT ").append(pageable.getPageSize())
                .append(" OFFSET ").append(pageable.getOffset());
        System.out.println(sql);

        Query query = entityManager.createNativeQuery(sql.toString(), SupplierEntity.class);

        return query.getResultList();
    }

    @Override
    public int countTotalItems(SupplierSearchRequest supplierSearchRequest) {
        StringBuilder sql = new StringBuilder(buildSelectQuery());
        StringBuilder join = new StringBuilder(" ");
        StringBuilder where = new StringBuilder(" WHERE 1=1 ");

        queryWhereNormal(supplierSearchRequest, where);
        queryWhereSpecial(supplierSearchRequest, where);

        sql.append(join).append(where).append(" GROUP BY sp.id ");

        System.out.println(sql);

        Query query = entityManager.createNativeQuery(sql.toString(), SupplierEntity.class);

        return query.getResultList().size();
    }

    public String buildSelectQuery(){
        return "SELECT sp.* FROM suppliers sp";
    }
}
