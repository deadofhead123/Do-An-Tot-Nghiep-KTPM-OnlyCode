package com.javaweb.repository.custom.impl;

import com.javaweb.constant.SystemConstant;
import com.javaweb.entity.ContactEntity;
import com.javaweb.model.request.ContactSearchRequest;
import com.javaweb.repository.custom.ContactRepositoryCustom;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Repository;
import org.springframework.util.ObjectUtils;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import java.lang.reflect.Field;
import java.util.List;

@Repository
public class ContactRepositoryImpl implements ContactRepositoryCustom {
    @Autowired
    private EntityManager entityManager;

    public void queryWhereNormal(ContactSearchRequest contactSearchRequest, StringBuilder where){
        try{
            Field[] fields = ContactSearchRequest.class.getDeclaredFields();

            for(Field field : fields){
                field.setAccessible(true);

                String key = field.getName();

                if(!key.startsWith("status")){
                    Object value = field.get(contactSearchRequest);

                    if( !ObjectUtils.isEmpty(value) ){
                        where.append(" AND ct." + key.toLowerCase() + " LIKE '%" + value + "%' ");
                    }
                }
            }
        }
        catch (Exception ex){
            ex.printStackTrace();
        }
    }

    public void queryWhereSpecial(ContactSearchRequest contactSearchRequest, StringBuilder where){
        String status = contactSearchRequest.getStatus();

        if(status != null && !status.equals("")){
            where.append(" AND ct.modifiedat ");

            if(status.equals("SOLVED")) where.append(" IS NOT NULL ");
            else where.append(" IS NULL ");
        }
    }

    @Override
    public List<ContactEntity> findAll(ContactSearchRequest contactSearchRequest, Pageable pageable) {
        StringBuilder sql = new StringBuilder(buildSelectQuery());
        StringBuilder where = new StringBuilder(SystemConstant.ONE_EQUAL_ONE);

        queryWhereNormal(contactSearchRequest, where);
        queryWhereSpecial(contactSearchRequest, where);

        String sortName = "", sortOrder = "";
        for(Sort.Order item : pageable.getSort()){
            sortName = item.getProperty();
            sortOrder = item.getDirection().toString();
        }

        sql.append(where).append(" ORDER BY ct." + sortName.toLowerCase() + " " + sortOrder + " ");
//                         .append(" LIMIT " + pageable.getPageSize())
//                         .append(" OFFSET " + pageable.getOffset());

        Query query = entityManager.createNativeQuery(sql.toString(), ContactEntity.class);

        return query.getResultList();
    }

    @Override
    public int countTotalItems(ContactSearchRequest contactSearchRequest) {
        StringBuilder sql = new StringBuilder(buildSelectQuery());
        StringBuilder where = new StringBuilder(SystemConstant.ONE_EQUAL_ONE);

        queryWhereNormal(contactSearchRequest, where);
        queryWhereSpecial(contactSearchRequest, where);
        sql.append(where);

        Query query = entityManager.createNativeQuery(sql.toString(), ContactEntity.class);

        return query.getResultList().size();
    }

    public String buildSelectQuery(){
        return "SELECT ct.* FROM contact ct ";
    }
}
