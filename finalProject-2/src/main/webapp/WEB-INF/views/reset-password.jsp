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
<c:url var="formURL" value="/reset-password"/>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Đặt lại mật khẩu</title>
</head>

<body class="bg-gray-200">

<main class="main-content  mt-0">
    <div class="page-header align-items-start min-vh-100"
         style="background-image: url('/web-user/images/login-signup-background.jpg');">

        <div class="container my-auto">
            <div class="row">
                <div class="col-lg-4"></div>
            </div>

            <div class="row">
                <div class="col-lg-4 col-md-8 col-12 mx-auto">
                    <div class="card z-index-0 fadeIn3 fadeInBottom">
                        <!-- Header của form đăng nhập -->
                        <form:form modelAttribute="modelReset" id="form-resetPassword" class="text-start">
                            <form:input type="hidden" class="form-control" id="token" path="token"/>

                            <div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
                                <div class="bg-gradient-info shadow-dark border-radius-lg py-3 pe-1">
                                    <h4 class="text-white font-weight-bolder text-center mt-2 mb-0">Đặt lại mật khẩu</h4>
                                    <c:if test="${token != null}">
                                        <p class="text-white text-center mt-2 mb-0">Nhập các trường dữ liệu cần thiết</p>
                                    </c:if>
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

                            <!-- Form forgot password -->
                            <div class="card-body">
                                <c:if test="${token != null}">
                                    <div class="input-group input-group-outline my-3">
                                        <label class="form-label" for="password">Mật khẩu</label>
                                        <input type="password" class="form-control" id="password">
                                    </div>
                                    <div class="input-group input-group-outline my-3">
                                        <label class="form-label" for="confirmPassword">Xác nhận mật khẩu</label>
                                        <input type="password" class="form-control" id="confirmPassword">
                                    </div>
                                    <div class="text-center">
                                        <button type="button" class="btn btn-facebook w-100 my-4 mb-2"
                                                id="btnResetPassword">Đặt lại
                                        </button>
                                    </div>
                                </c:if>

                                <c:if test="${token == null}">
                                    <h1 align="center">Link hiện không khả dụng!</h1>
                                </c:if>
                            </div>
                        </form:form>
                    </div>
                </div>
            </div>
        </div>

    </div>
</main>

<script>
    $(document).ready(function () {
        console.log("Token's value: " + $('#token').val());
        setTimeout(function () {
            $('#errorUNorPWAlert').hide();
            $('#logoutAlert').hide();
        }, 2000);
    });

    $('#btnResetPassword').click(function () {
        let json = {};
        json['token'] = $('#token').val();
        json['password'] = $('#password').val().trim();
        let confirmPassword = $('#confirmPassword').val().trim();

        if (json['password'] === "" || confirmPassword === "") {
            alert('Hãy nhập đủ thông tin!');
        } else if (json['password'] !== confirmPassword) {
            alert('Mật khẩu và xác nhận mật khẩu không khớp!');
        } else {
            if (confirm('Xác nhận thông tin chính xác?')) {
                resetPassword(json);
            }
        }

        function resetPassword(json) {
            $.ajax({
                url: "/api/users/reset-password",
                method: "PUT",
                contentType: "application/json; charset: UTF-8",
                data: JSON.stringify(json),
                dataType: "JSON",
                success: function (result) {
                    console.log(result);
                    alert(result.message);
                    location.replace("/login");
                },
                error: function (result) {
                    console.log(result);
                    alert(result.message);
                }
            });
        }
    });
</script>
</body>

</html>