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
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Đăng ký</title>
    <!-- jQuery -->
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

    <!--     Fonts and icons     -->
    <link rel="stylesheet" type="text/css"
          href="https://fonts.googleapis.com/css?family=Inter:300,400,500,600,700,900"/>

    <!-- Nucleo Icons -->
    <link href="../admin/css/nucleo-icons.css" rel="stylesheet"/>
    <link href="../admin/css/nucleo-svg.css" rel="stylesheet"/>

    <!-- Font Awesome Icons -->
    <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>

    <!-- Material Icons -->
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0"/>

    <!-- CSS Files -->
    <link id="pagestyle" href="../admin/css/material-dashboard.css?v=3.2.0" rel="stylesheet"/>
</head>

<body class="">
<main class="main-content  mt-0">
    <div class="page-header align-items-start min-vh-100"
         style="background-image: url('/web-user/images/login-signup-background.jpg');">
        <div class="container my-auto">
            <div class="row">
                <div class="col-lg-4 col-md-8 col-12 mx-auto">
                    <div class="card z-index-0 fadeIn3 fadeInBottom">
                        <div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
                            <div class="bg-gradient-info shadow-dark border-radius-lg py-3 pe-1">
                                <!-- Header of form-->
                                <h4 class="text-white font-weight-bolder text-center mt-2 mb-0">Đăng ký</h4>
                                <p class="text-white text-center mt-2 mb-0">Nhập các trường dữ liệu cần thiết</p>

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
                        <div class="card-body">
                            <form:form id="form-signup" name="form-signup" method="get" class="text-start">
                                <div class="input-group input-group-outline mb-3">
                                    <label class="form-label" for="email">Email</label>
                                    <input type="email" class="form-control" id="email" name="email">
                                </div>
                                <div class="input-group input-group-outline mb-3">
                                    <label class="form-label" for="password">Mật khẩu</label>
                                    <input type="password" class="form-control" id="password" name="password">
                                </div>
                                <div class="input-group input-group-outline mb-3">
                                    <label class="form-label" for="confirmPassword">Xác nhận mật khẩu</label>
                                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword">
                                </div>

                                <div class="form-check form-check-info text-start ps-0">
                                    <input class="form-check-input" type="checkbox" id="flexCheckDefault">
                                    <label class="form-check-label" for="flexCheckDefault">
                                        Tôi đồng ý với <a href="/condition-service-policy" class="text-dark font-weight-bolder">Điều khoản sử dụng</a>
                                    </label>
                                </div>

                                <div class="text-center">
                                    <button type="button" class="btn btn-lg btn-facebook btn-lg w-100 mt-4 mb-0"
                                            id="btnSignup">Đăng ký
                                    </button>
                                </div>
                            </form:form>

                            <div class="card-footer text-center pt-0 px-lg-2 px-1">
                                <p class="mb-2 text-sm mx-auto">
                                    Đã có tài khoản?
                                    <a href="/login" class="text-primary text-gradient font-weight-bold">Đăng nhập</a>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>

</main>

<script>
    $(document).ready(function(){
        $('#btnSignup').click(function () {
            $('#form-signup').submit();
        });
    });
    $(function(){
       $("form[name='form-signup']").validate({
           rules: {
               email: {
                   required: true
               },
               password: {
                   required: true
               },
               confirmPassword: {
                   required: true
               }
           },
           messages:{
               email: {
                   required: "<span style='color: red'>Không được bỏ trống</span>"
               },
               password: {
                   required: "<span style='color: red'>Không được bỏ trống</span>"
               },
               confirmPassword: {
                   required: "<span style='color: red'>Không được bỏ trống</span>"
               },
           },
           submitHandler: function(){
               let json = {};

               json['email'] = $('#email').val();
               json['password'] = $('#password').val();
               json['confirmPassword'] = $('#confirmPassword').val();
               json['roleCode'] = "USER";

               if (json["password"] !== json["confirmPassword"]) {
                   alert('Mật khẩu và xác nhận mật khẩu không khớp!');
               }
               else if($('#flexCheckDefault:checked').length <= 0){
                   alert('Bạn hãy đọc kỹ Điều khoản sử dụng!');
               }
               else {
                   if (confirm("Xác nhận các thông tin là chính xác?")) {
                       console.log(json);
                       signup(json);
                   }
               }
           }
       });
    });

    function signup(json) {
        $.ajax({
            url: "/api/users",
            method: "POST",
            contentType: "application/json; charset: UTF-8",
            data: JSON.stringify(json),
            dataType: "JSON",
            success: function(result){
                alert("Đăng ký tài khoản thành công!");
                location.reload();
            },
            error: function(result){
                alert(result.responseJSON.message);
            }
        });
    }
</script>
</body>

</html>