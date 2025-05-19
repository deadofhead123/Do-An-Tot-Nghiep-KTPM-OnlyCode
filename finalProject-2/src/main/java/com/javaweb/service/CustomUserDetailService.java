package com.javaweb.service;

import com.javaweb.model.dto.MyUserDetail;
import com.javaweb.model.dto.RoleDTO;
import com.javaweb.model.dto.UserDTO;
import com.javaweb.service.user.IUserService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class CustomUserDetailService implements UserDetailsService {
    @Autowired
    private IUserService IUserService;

    @Override
    public UserDetails loadUserByUsername(String name) throws UsernameNotFoundException {
        UserDTO userDTO = IUserService.findOneByEmailAndIsActive(name, 1);

        if(userDTO == null){
            throw new UsernameNotFoundException("Username not found");
        }

        // Get the role of user found
        List<GrantedAuthority> authorities = new ArrayList<>();
        for(RoleDTO role: userDTO.getRoles()){
            authorities.add(new SimpleGrantedAuthority("ROLE_"+role.getCode()));
        }

        // Save user for further using
        MyUserDetail myUserDetail = new MyUserDetail(name,userDTO.getPassword(),true,true,true,true,authorities);
        BeanUtils.copyProperties(userDTO, myUserDetail);
        return myUserDetail;
    }
}
