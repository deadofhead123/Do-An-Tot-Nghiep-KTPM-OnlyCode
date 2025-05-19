<!--
=========================================================
* Material Dashboard 3 - v3.2.0
=========================================================

* Product Page: https://www.creative-tim.com/product/material-dashboard
* Copyright 2024 Creative Tim (https://www.creative-tim.com)
* Licensed under MIT (https://www.creative-tim.com/license)
* Coded by Creative Tim

=========================================================

* The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Đăng nhập</title>
</head>

<body class="bg-gray-200">

<main class="main-content  mt-0">
    <div class="page-header align-items-start min-vh-100"
         style="background-image: url('/web-user/images/login-signup-background.jpg');">

        <div class="container my-auto">
            <div class="row">
                <div class="col-lg-4"></div>
                <c:if test="${param.incorrectAccount != null}">
                    <div id="errorUNorPWAlert" class="alert alert-danger text-white text-center col-lg-4 mb-6">
                        Sai tên tài khoản hoặc mật khẩu!
                    </div>
                </c:if>

                <c:if test="${param.accessDenied != null}">
                    <div id="logoutAlert" class="alert alert-danger text-white text-center col-lg-4 mb-6">
                        Bạn không được phép truy cập!
                    </div>
                </c:if>

                <c:if test="${param.logout != null}">
                    <div id="logoutAlert" class="alert alert-success text-white text-center col-lg-4 mb-6">
                        Đăng xuất thành công!
                    </div>
                </c:if>
            </div>

            <div class="row">
                <div class="col-lg-4"></div>
            </div>

            <div class="row">
                <div class="col-lg-4 col-md-8 col-12 mx-auto">
                    <div class="card z-index-0 fadeIn3 fadeInBottom">
                        <!-- Header of Login form -->
                        <div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
                            <div class="bg-gradient-info shadow-dark border-radius-lg py-3 pe-1">
                                <h4 class="text-white font-weight-bolder text-center mt-2 mb-0">Đăng nhập</h4>
                                <p class="text-white text-center mt-2 mb-0">Sử dụng tài khoản bạn đã đăng ký</p>
                                <div class="row mt-3">
                                    <div class="col-2 text-center ms-auto">
                                        <a class="btn btn-link px-3" href="javascript:;">
                                            <i class="fa fa-facebook text-white text-lg"></i>
                                        </a>
                                    </div>
                                    <div class="col-2 text-center px-1">
                                        <a class="btn btn-link px-3" href="javascript:;">
                                            <i class="fa fa-github text-white text-lg"></i>
                                        </a>
                                    </div>
                                    <div class="col-2 text-center me-auto">
                                        <a class="btn btn-link px-3" href="javascript:;">
                                            <i class="fa fa-google text-white text-lg"></i>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Login form (interact with Spring Security) -->
                        <div class="card-body">
                            <form action="j_spring_security_check" method="post" class="text-start">
                                <div class="input-group input-group-outline my-3">
                                    <label class="form-label" for="username">Email</label>
                                    <input type="text" class="form-control" id="username" name="j_username">
                                </div>
                                <div class="input-group input-group-outline mb-3">
                                    <label class="form-label" for="password">Mật khẩu</label>
                                    <input type="password" class="form-control" id="password" name="j_password">
                                </div>

                                <div class="text-center">
                                    <button type="submit" class="btn btn-facebook w-100 my-4 mb-2">Đăng nhập</button>
                                </div>

                                <p class="mt-4 text-sm text-center">
                                    <a class="text-primary text-dark-blue font-weight-bold" href="/forgot-password">Quên mật khẩu?</a>
                                </p>

                                <p class="mt-4 text-sm text-center">
                                    Chưa có tài khoản?
                                    <a href="/signup" class="text-primary text-gradient font-weight-bold">Đăng ký</a>
                                </p>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<script>
    // Set time out for alert
  $(document).ready(function(){
      setTimeout(function (){
         $('#errorUNorPWAlert').hide();
         $('#logoutAlert').hide();
      }, 2000);
  });
</script>
</body>

</html>