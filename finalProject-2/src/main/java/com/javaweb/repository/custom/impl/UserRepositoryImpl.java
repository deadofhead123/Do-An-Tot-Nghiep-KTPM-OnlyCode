package com.javaweb.repository.custom.impl;

import com.javaweb.entity.UserEntity;
import com.javaweb.model.request.UserSearchRequest;
import com.javaweb.repository.custom.UserRepositoryCustom;
import com.javaweb.security.utils.SecurityUtils;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import java.lang.reflect.Field;
import java.util.List;

@Repository
@RequiredArgsConstructor
public class UserRepositoryImpl implements UserRepositoryCustom {
    private final EntityManager entityManager;

    public void queryJoin(UserSearchRequest userSearchRequest, StringBuilder join){
        String roleCode = userSearchRequest.getRoleCode();

        if(!StringUtils.isEmpty(roleCode)){
            join.append(" INNER JOIN user_role ur ON u.id = ur.userid" +
                    " INNER JOIN roles r ON ur.roleid = r.id ");
        }
    }

    public void queryWhereNormal(UserSearchRequest userSearchRequest, StringBuilder where){
        try{
            Field[] fields = UserSearchRequest.class.getDeclaredFields();

            for(Field field : fields){
                field.setAccessible(true);

                String key = field.getName();

                if(!key.startsWith("role")){
                    Object value = field.get(userSearchRequest);

                    if( value != "" && value != null ){
                        if(value.getClass().getName().equals("java.lang.String")){
                            where.append(" AND u." + key.toLowerCase() + " LIKE '%" + value + "%' ");
                        }
                        else{
                            where.append(" AND u." + key.toLowerCase() + "=" + value + " ");
                        }
                    }
                }
            }
        }
        catch(Exception ex){
            ex.printStackTrace();
        }
    }

    public void queryWhereSpecial(UserSearchRequest userSearchRequest, StringBuilder where){
        String roleCode = userSearchRequest.getRoleCode();

        if(!StringUtils.isEmpty(roleCode)){
            where.append(" AND r.code LIKE '%" + roleCode + "%' ");
        }
    }

    @Override
    public List<UserEntity> findAll(UserSearchRequest userSearchRequest, Pageable pageable) {
        StringBuilder sql = new StringBuilder(buildSelectQuery());
        StringBuilder join = new StringBuilder(" ");
        StringBuilder where = new StringBuilder(" WHERE 1=1 ");

        queryJoin(userSearchRequest, join);
        queryWhereNormal(userSearchRequest, where);
        queryWhereSpecial(userSearchRequest, where);

        sql.append(join).append(where).append(" AND u.email NOT LIKE '%" + SecurityUtils.getPrincipal().getUsername() + "%' ")
                                      .append(" GROUP BY u.id ")
                                        .append(" ORDER BY u.createdat DESC ")
                                        .append(" LIMIT ").append(pageable.getPageSize())
                                      .append(" OFFSET ").append(pageable.getOffset());
        System.out.println(sql);

        Query query = entityManager.createNativeQuery(sql.toString(), UserEntity.class);

        return query.getResultList();
    }

    @Override
    public int countTotalItems(UserSearchRequest userSearchRequest) {
        StringBuilder sql = new StringBuilder(buildSelectQuery());
        StringBuilder join = new StringBuilder(" ");
        StringBuilder where = new StringBuilder(" WHERE 1=1 ");

        queryJoin(userSearchRequest, join);
        queryWhereNormal(userSearchRequest, where);
        queryWhereSpecial(userSearchRequest, where);

        sql.append(join).append(where).append(" AND u.email NOT LIKE '%" + SecurityUtils.getPrincipal().getUsername() + "%' ").append(" GROUP BY u.id ");

        System.out.println(sql);

        Query query = entityManager.createNativeQuery(sql.toString(), UserEntity.class);

        return query.getResultList().size();
    }

    public String buildSelectQuery(){
        return "SELECT u.* FROM users u";
    }
}
