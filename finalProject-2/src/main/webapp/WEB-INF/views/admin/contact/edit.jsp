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
    <title>Liên hệ</title>
</head>

<body class="g-sidenav-show bg-gray-100">
<c:if test="${not empty messageResponse}">
    <div class="row">
        <div class="col-12 col-xl-5"></div>
        <div class="col-12 col-xl-4">
            <div id="alertResult" class="alert alert-block alert-${alert} text-white w-lg-50 text-xxl-center">
                    ${messageResponse}
            </div>
        </div>
    </div>
</c:if>

<div class="container-fluid px-2 px-md-6">
    <div class="page-header min-height-300 border-radius-xl mt-4"
         style="background-image: url('/web-user/images/bg_1.jpg');">
        <span class="mask bg-gradient-dark  opacity-1"></span>
    </div>

    <div class="card card-body mx-2 mx-md-2 mt-n6">
        <div class="row gx-4 mb-2">
            <div class="col-auto my-auto">
                <div class="h-100 align-items-center">
                    <h4 class="mb-1">Chi tiết liên hệ</h4>
                </div>
            </div>
        </div>
        <form:form method="get" id="form-edit" name="form-edit" modelAttribute="contactDetail">
            <form:input path="id" type="hidden"/>
            <div class="row">
                <!-- Contact Information -->
                <div class="col-12 col-xl-2"></div>
                <div class="col-12 col-xl-4">
                    <div class="card card-plain h-100">
                        <div class="card-header pb-0 p-3">
                            <div class="row">
                                <div class="col-md-8 d-flex align-items-center">
                                    <h6 class="mb-0">Thông tin người liên hệ</h6>
                                </div>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="form-group py-2">
                                <label for="email"><strong class="text-dark" style="font-size: 15px;">Email</strong></label>
                                <form:input path="email" id="email" name="email"
                                            class="form-control px-2" style="border: 1px solid black; font-size: 17px;"
                                            readonly="true"/>
                            </div>

                            <div class="form-group py-2">
                                <label for="fullName"><strong class="text-dark" style="font-size: 15px;">Họ tên</strong></label>
                                <form:input path="fullName" id="fullName" name="fullName"
                                            class="form-control px-2" style="border: 1px solid black; font-size: 17px;"
                                            readonly="true"/>
                            </div>

                            <div class="form-group py-2">
                                <label for="phoneNumber"><strong class="text-dark" style="font-size: 15px;">Số điện
                                    thoại</strong></label>
                                <form:input path="phoneNumber" id="phoneNumber" name="phoneNumber"
                                            class="form-control px-2" style="border: 1px solid black; font-size: 17px;"
                                            readonly="true"/>
                            </div>

                            <div class="form-group py-2">
                                <label for="description"><strong class="text-dark" style="font-size: 15px;">Nội dung</strong></label>
                                <form:textarea path="description" id="description" name="description"
                                               class="form-control px-2" style="border: 1px solid black; font-size: 15px;"
                                               rows="5"
                                               readonly="true"/>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Reply information -->
                <div class="col-12 col-xl-4">
                    <div class="card card-plain h-100">
                        <div class="card-header pb-0 p-3">
                            <div class="row">
                                <div class="col-md-8 d-flex align-items-center">
                                    <h6 class="mb-0">Thông tin phản hồi</h6>
                                </div>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="form-group py-1">
                                <label for="description">
                                    <strong class="text-dark" style="font-size: 15px;">Nội dung phản hồi</strong>
                                </label>
                                <c:if test="${contactDetail.reply != null}">
                                    <form:textarea path="reply" id="reply" name="reply"
                                                   class="form-control px-2" style="border: 1px solid black; font-size: 17px;"
                                                   rows="5" readonly="true"/>
                                </c:if>

                                <c:if test="${contactDetail.reply == null}">
                                    <form:textarea path="reply" id="reply" name="reply"
                                                   class="form-control px-2" style="border: 1px solid black; font-size: 17px;"
                                                   rows="5"/>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-12 col-xl-5"></div>
                    <div class="col-12 col-xl-4 align-items-xxl-end">
                        <c:if test="${contactDetail.reply == null}">
                            <button type="button" class="btn btn-facebook px-4 py-2 align-items-xxl-end"
                                    id="btnEdit">
                                Lưu
                            </button>
                        </c:if>
                        &nbsp;
                        <button type="reset" class="btn bg-gradient-faded-dark px-4 py-2 ms-3 align-items-xxl-end">
                            <a class="text-white" href="/admin/contact-list">Quay lại</a>
                        </button>
                    </div>
                </div>
            </div>
        </form:form>
    </div>
</div>

<script>
    $(document).ready(function () {
        $('#btnEdit').click(function () {
            $('#form-edit').submit();
        });
        setTimeout(function () {
            $('#alertResult').hide();
        }, 2000);
    });
    $(function () {
        $("form[name='form-edit']").validate({
            rules: {
                reply: "required"
            },
            messages: {
                reply: "<span style='color: red'>Không bỏ trống phần trả lời!</span>"
            },
            submitHandler: function (form) {
                var formData = $('#form-edit').serializeArray();
                var dataArray = {};

                $.each(formData, function (i, v) {
                    dataArray["" + v.name + ""] = v.value.trim();
                });

                console.log(dataArray)

                if (confirm("Bạn chắc chắn muốn trả lời liên hệ?")) {
                    editContact(dataArray);
                }
            }
        });
    });

    function editContact(json) {
        $.ajax({
            url: "/api/admin/contacts",
            method: "PUT",
            data: JSON.stringify(json),
            contentType: "application/json; charset=UTF-8",
            dataType: "JSON",
            success: function (result) {
                console.log(result);
                alert(result.message);

                if(result.data == 'update_success'){
                    window.location.href = "/admin/contact-edit-${contactDetail.id}?message=update_success";
                }
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