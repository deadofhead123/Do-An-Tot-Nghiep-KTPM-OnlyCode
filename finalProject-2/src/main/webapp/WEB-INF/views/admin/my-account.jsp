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
    <title>Tài khoản</title>
</head>

<body class="g-sidenav-show bg-gray-100">
<div class="main-content position-relative max-height-vh-100 h-100">
    <div class="container-fluid px-2 px-md-4">
        <div class="page-header min-height-300 border-radius-xl mt-4" style="background-image: url('/web-user/images/bg_1.jpg');">
            <span class="mask bg-gradient-dark  opacity-1"></span>
        </div>
        <div class="card card-body mx-2 mx-md-2 mt-n6">
            <div class="row gx-4 mb-2">
                <div class="col-auto my-auto">
                    <div class="h-100">
                        <h5 class="mb-1">
                            <%=SecurityUtils.getPrincipal().getFullName()%>
                        </h5>
                        <p class="mb-0 font-weight-normal text-sm">
                            <c:set var="role" value="<%=SecurityUtils.getAuthorities().get(0)%>"/>

                            <c:if test="${role == 'ROLE_ADMIN'}">
                                Quản lý
                            </c:if>
                            <c:if test="${role == 'ROLE_STAFF'}">
                                Nhân viên
                            </c:if>
                        </p>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6 my-sm-auto ms-sm-auto me-sm-0 mx-auto mt-3">
                    <div class="nav-wrapper position-relative end-0">

                        <!-- Tab -->
                        <ul class="nav nav-pills nav-fill p-1" role="tablist">
                            <li class="nav-item" role="presentation">
                                <a class="nav-link mb-0 px-0 py-1 active " data-bs-toggle="tab" href="#myaccount" role="tab" aria-controls="home" aria-selected="true">
                                    <i class="material-symbols-rounded text-lg position-relative">account_circle</i>
                                    <span class="ms-1">Trang tài khoản</span>
                                </a>
                            </li>
                            <li class="nav-item" role="presentation">
                                <a class="nav-link mb-0 px-0 py-1 " data-bs-toggle="tab" href="#password" role="tab" aria-controls="password" aria-selected="false">
                                    <i class="material-symbols-rounded text-lg position-relative">password</i>
                                    <span class="ms-1">Đổi mật khẩu</span>
                                </a>
                            </li>
                        </ul>
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
                                        <h5>Thông tin tài khoản</h5>

                                        <form:form method="get" id="form-edit" modelAttribute="userEdit">
                                            <div class="form-group py-1">
                                                <label for="email"><strong class="text-dark" style="font-size: 15px;">Email</strong></label>
                                                <form:input path="email" id="email" name="email" class="form-control px-2" style="border: 1px solid black; font-size: 17px;" disabled="disabled"/>
                                            </div>

                                            <div class="form-group py-2">
                                                <label for="fullName"><strong class="text-dark" style="font-size: 15px;">Họ tên</strong></label>
                                                <form:input path="fullName" id="fullName" name="fullName" class="form-control px-2" style="border: 1px solid black; font-size: 17px;"/>
                                            </div>

                                            <div class="form-group py-2">
                                                <label for="phoneNumber"><strong class="text-dark" style="font-size: 15px;">Số điện thoại</strong></label>
                                                <form:input path="phoneNumber" id="phoneNumber" name="phoneNumber" class="form-control px-2" style="border: 1px solid black; font-size: 17px;"/>
                                            </div>

                                            <div class="form-group py-2">
                                                <label for="address"><strong class="text-dark" style="font-size: 15px;">Địa chỉ</strong></label>
                                                <form:input path="address" id="address" name="address" class="form-control px-2" style="border: 1px solid black; font-size: 17px;"/>
                                            </div>

                                            <div class="form-group py-2">
                                                <button type="button" class="btn bg-gradient-success py-2 px-3" id="btnUpdate">Lưu</button>&nbsp;
                                                <button type="reset" class="btn bg-gradient-faded-dark py-2 px-3"><a class="text-white" href="/admin/home">Hủy</a></button>
                                            </div>
                                        </form:form>
                                    </div>

                                    <!-- Change password tab-->
                                    <div class="tab-pane fade" id="password" role="tabpanel" aria-labelledby="password-tab">
                                        <h5>Đổi mật khẩu</h5>
                                        <form method="get" id="form-change-password">
                                            <div class="form-group py-2">
                                                <label for="email"><strong class="text-dark" style="font-size: 15px;">Mật khẩu cũ</strong></label>
                                                <input type="password" id="oldPassword" name="oldPassword" class="form-control px-2" style="border: 1px solid black; font-size: 17px;"/>
                                            </div>

                                            <div class="form-group py-2">
                                                <label for="email"><strong class="text-dark" style="font-size: 15px;">Mật khẩu mới</strong></label>
                                                <input type="password" id="newPassword" name="newPassword" class="form-control px-2" style="border: 1px solid black; font-size: 17px;"/>
                                            </div>

                                            <div class="form-group py-2">
                                                <label for="email"><strong class="text-dark" style="font-size: 15px;">Xác nhận mật khẩu mới</strong></label>
                                                <input type="password" id="confirmNewPassword" name="confirmNewPassword" class="form-control px-2" style="border: 1px solid black; font-size: 17px;"/>
                                            </div>

                                            <div class="form-group py-2">
                                                <button type="button" class="btn bg-gradient-success py-2 px-3" id="btnChangePassword">Lưu</button>&nbsp;
                                                <button type="reset" class="btn bg-gradient-faded-dark py-2 px-3"><a class="text-white" href="/admin/home">Hủy</a></button>
                                            </div>
                                        </form>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Update User's information
    $('#btnUpdate').click(function(){
        let formData = $('#form-edit').serializeArray();
        let json = {};
        let ok = 1;

        $.each(formData, function(idx, it){
            let value = it.value.trim();

            if(value == ""){
                ok = 0;
                return false;
            }

            json["" + it.name + ""] = value;
        });

        console.log(json);

        if(!ok){
            alert('Bạn chưa nhập đủ thông tin!');
        }
        else{
            if(confirm('Bạn chắc chắn muốn cập nhật thông tin?')){
                update(json);
            }
        }
    });

    function update(json){
        $.ajax({
            url: "/api/users",
            method: "PUT",
            data: JSON.stringify(json),
            contentType: "application/json; charset=UTF-8",
            dataType: "JSON",
            success: function(result){
                console.log(result);
                alert(result.message);
                location.reload();
            },
            error: function(result){
                console.log(result);

                let message = result.responseJSON.message;

                $.each(result.responseJSON.details, function(idx, it){
                    message += it + '\n';
                });

                alert(message);
            }
        });
    }

    // Change User's password
    $('#btnChangePassword').click(function () {
        let formData = $('#form-change-password').serializeArray();
        let json = {};
        let ok = 1;

        $.each(formData, function (idx, it) {
            let value = it.value.trim();

            if (value == "") {
                ok = 0;
                return false;
            }

            json["" + it.name + ""] = value;
        });

        console.log(json);

        if (!ok) {
            alert('Bạn chưa nhập đủ thông tin!');
        }
        else if(json['newPassword'] != json['confirmNewPassword']){
            alert('Mật khẩu mới và xác nhận mật khẩu mới chưa khớp!');
        }
        else {
            if (confirm('Bạn chắc chắn muốn đổi mật khẩu?')) {
                changePassword(json);
            }
        }
        console.log(json);
    });

    function changePassword(json) {
        $.ajax({
            url: "/api/users/change-password",
            method: "PUT",
            data: JSON.stringify(json),
            contentType: "application/json; charset=UTF-8",
            dataType: "JSON",
            success: function (result) {
                console.log(result);
                alert(result.message);
                location.reload();
            },
            error: function (result) {
                console.log(result);

                let message = result.responseJSON.message;

                $.each(result.responseJSON.details, function (idx, it) {
                    message += it + '\n';
                });

                alert(message);
            }
        });
    }
</script>
</body>

</html>