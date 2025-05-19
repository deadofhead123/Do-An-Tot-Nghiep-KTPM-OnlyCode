package com.javaweb.repository.custom;

import com.javaweb.entity.UserEntity;
import com.javaweb.model.request.UserSearchRequest;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface UserRepositoryCustom {
    public List<UserEntity> findAll(UserSearchRequest userSearchRequest, Pageable pageable);
    public int countTotalItems(UserSearchRequest userSearchRequest);
}
