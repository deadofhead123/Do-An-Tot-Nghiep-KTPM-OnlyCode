package com.javaweb.repository.custom.impl;

import com.javaweb.constant.SystemConstant;
import com.javaweb.entity.CategoryEntity;
import com.javaweb.model.request.CategorySearchRequest;
import com.javaweb.repository.custom.CategoryRepositoryCustom;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import java.lang.reflect.Field;
import java.util.List;

@Repository
public class CategoryRepositoryImpl implements CategoryRepositoryCustom {
    @Autowired
    private EntityManager entityManager;

    public void queryWhereNormal(CategorySearchRequest categorySearchRequest, StringBuilder where){
        try{
            Field[] fields = CategorySearchRequest.class.getDeclaredFields();

            for(Field field : fields){
                field.setAccessible(true);

                String key = field.getName();
                if(!key.startsWith("isSearchingParent")){
                    Object value = field.get(categorySearchRequest);

                    if(value != null && value != ""){
                        if(value.getClass().getName().equals("java.lang.String")){
                            where.append(" AND c." + key.toLowerCase() + " LIKE '%" + value + "%' ");
                        }
                        else{
                            where.append(" AND c." + key.toLowerCase() + "=" + value + " ");
                        }
                    }
                }
            }
        }
        catch (Exception ex){
            ex.printStackTrace();
        }
    }

    public void queryWhereSpecial(CategorySearchRequest categorySearchRequest, StringBuilder where){
        if(categorySearchRequest.getIsSearchingParent() != null){
            where.append(" AND c.parentid IS NULL ");
        }
        else{
            where.append(" AND c.parentid IS NOT NULL ");
        }
    }

    @Override
    public List<CategoryEntity> findAll(CategorySearchRequest categorySearchRequest, Pageable pageable) {
        StringBuilder sql = new StringBuilder(buildSelectQuery());
        StringBuilder where = new StringBuilder(SystemConstant.ONE_EQUAL_ONE);
        Integer realSize;
        StringBuilder sqlFix;

        queryWhereNormal(categorySearchRequest, where);
        queryWhereSpecial(categorySearchRequest, where);

        String sortName = "", sortOrder = "";
        for(Sort.Order item : pageable.getSort()){
            sortName = item.getProperty();
            sortOrder = item.getDirection().toString();
        }

        sql.append(where).append(" AND c.isactive=1 ").append(" ORDER BY c." + sortName.toLowerCase() + " " + sortOrder + " ");

        sqlFix = new StringBuilder(sql);

        sql.append(" LIMIT " + pageable.getPageSize()).append(" OFFSET " + pageable.getOffset());

        Query query = entityManager.createNativeQuery(sql.toString(), CategoryEntity.class);

        realSize = query.getResultList().size();

        if(realSize == 0 && pageable.getOffset() > 0){
            Query queryFix = entityManager.createNativeQuery(sqlFix.append(" LIMIT " + pageable.getPageSize())
                                                                   .append(" OFFSET " + (pageable.getOffset() - pageable.getPageSize())).toString(), CategoryEntity.class);
            return queryFix.getResultList();
        }

        return query.getResultList();
    }

    @Override
    public int countTotalItems(CategorySearchRequest categorySearchRequest) {
        StringBuilder sql = new StringBuilder(buildSelectQuery());
        StringBuilder where = new StringBuilder(SystemConstant.ONE_EQUAL_ONE);

        queryWhereNormal(categorySearchRequest, where);
        queryWhereSpecial(categorySearchRequest, where);

        sql.append(where).append(" AND c.isactive=1 ");

        Query query = entityManager.createNativeQuery(sql.toString(), CategoryEntity.class);

        return query.getResultList().size();
    }

    public String buildSelectQuery(){
        return "SELECT  c.* FROM categories c ";
    }
}
