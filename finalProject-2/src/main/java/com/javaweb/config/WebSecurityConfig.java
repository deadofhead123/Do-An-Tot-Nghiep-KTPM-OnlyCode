package com.javaweb.config;

import com.javaweb.security.CustomSuccessHandler;
import com.javaweb.service.CustomUserDetailService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {
    @Bean
    public UserDetailsService userDetailsService() {
        return new CustomUserDetailService();
    }

    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public DaoAuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setUserDetailsService(userDetailsService());
        authProvider.setPasswordEncoder(passwordEncoder());
        return authProvider;
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) {
        auth.authenticationProvider(authenticationProvider());
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception{
        http.csrf().disable()
                .authorizeRequests()
                .antMatchers("/admin/css/**", "/admin/js/**", "/other/**").permitAll() // decorators of admin (using in frontend)
                .antMatchers("/api/admin/statistic**").hasRole("ADMIN")
                .antMatchers("/admin/user**", "/api/admin/users**").hasRole("ADMIN")
                .antMatchers("/admin/category**", "/api/admin/categories**").hasRole("ADMIN")
                .antMatchers("/admin/news**", "/api/admin/news**").hasRole("ADMIN")
                .antMatchers("/admin/product**", "/api/admin/products**").hasRole("ADMIN")
                .antMatchers("/admin/order**", "/api/admin/orders**").hasRole("ADMIN")
                .antMatchers("/admin/import**", "/api/admin/imports**").hasRole("ADMIN")
                .antMatchers("/admin/productInventory**", "/api/admin/productInventory**").hasRole("ADMIN")
                .antMatchers("/admin/**").hasAnyRole("ADMIN")

                .antMatchers(HttpMethod.PUT, "/api/users").hasAnyRole("ADMIN", "USER")
                .antMatchers("/api/users/change-password").hasAnyRole("ADMIN", "USER")

                .antMatchers("/cart", "/api/carts**").hasRole("USER")
                .antMatchers("/checkout", "/order-success", "/api/orders**").hasRole("USER")
                .antMatchers("/api/users/feedback").hasRole("USER")
                .antMatchers("/my-account", "/change-password", "/my-order**", "/my-product-bought").hasRole("USER")

                .antMatchers("/home","/login","/signup", "/forgot-password", "/reset-password","/shop**"
                                ,"/resources/**", "/api/**").permitAll()
                .and()
                .formLogin().loginPage("/login").usernameParameter("j_username").passwordParameter("j_password").permitAll() // direct to Login Page, execute login action
                .loginProcessingUrl("/j_spring_security_check")
                .successHandler(myAuthenticationSuccessHandler())
                .failureUrl("/login?incorrectAccount")
                .and()
                .logout().logoutUrl("/logout").deleteCookies("JSESSIONID")// This is logout function() of Spring Security
                .and()
                .exceptionHandling().accessDeniedPage("/access-denied")
                .and()
                .sessionManagement().maximumSessions(1).expiredUrl("/login?sessionTimeout");
    }

    @Bean
    public AuthenticationSuccessHandler myAuthenticationSuccessHandler(){
        return new CustomSuccessHandler();
    }
}
