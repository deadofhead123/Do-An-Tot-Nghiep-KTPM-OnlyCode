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
<%@page import="com.javaweb.security.utils.SecurityUtils" %>
<%@include file="/common/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Chi tiết tài khoản</title>
</head>

<body class="g-sidenav-show bg-gray-100">
    <div class="container-fluid px-2 px-md-4">
        <div class="page-header min-height-300 border-radius-xl mt-4"
             style="background-image: url('/web-user/images/bg_1.jpg');">
            <span class="mask bg-gradient-dark  opacity-1"></span>
        </div>

        <form:form method="get" id="form-edit" modelAttribute="userDetail">
            <div class="card card-body mx-2 mx-md-2 mt-n6">
                <div class="row gx-4 mb-2">
                    <div class="col-auto my-auto">
                        <div class="h-100">
                            <h5 class="mb-1">${userDetail.fullName}</h5>
                            <p class="mb-0 font-weight-normal text-sm">${userDetail.roles.get(0).name}</p>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="row">
                        <div class="col-12 col-xl-4">
                            <div class="card card-plain h-100">
                                <div class="card-body p-3">

                                    <!-- Update information tab -->
                                    <div class="tab-content" id="myTabContent">
                                        <div class="tab-pane fade show active" id="myaccount" role="tabpanel" aria-labelledby="myaccount-tab">
                                            <h6>Thông tin tài khoản</h6>


                                            <div class="form-group py-1">
                                                <label for="email"><strong class="text-dark">Email</strong></label>
                                                <form:input path="email" id="email" name="email"
                                                            class="form-control px-2" style="border: 1px solid black"
                                                            disabled="true"/>
                                            </div>

                                            <div class="form-group py-1">
                                                <label for="fullName"><strong class="text-dark">Họ tên</strong></label>
                                                <form:input path="fullName" id="fullName" name="fullName"
                                                            class="form-control px-2" style="border: 1px solid black"
                                                            disabled="true"/>
                                            </div>

                                            <div class="form-group py-1">
                                                <label for="phoneNumber"><strong class="text-dark">Số điện thoại</strong></label>
                                                <form:input path="phoneNumber" id="phoneNumber" name="phoneNumber"
                                                            class="form-control px-2" style="border: 1px solid black"
                                                            disabled="true"/>
                                            </div>

                                            <div class="form-group py-1">
                                                <label for="address"><strong class="text-dark">Địa chỉ</strong></label>
                                                <form:input path="address" id="address" name="address"
                                                            class="form-control px-2" style="border: 1px solid black"
                                                            disabled="true"/>
                                            </div>

                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form:form>
    </div>

</body>

</html>