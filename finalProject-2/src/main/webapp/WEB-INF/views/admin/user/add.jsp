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
<c:url var="userListURL" value="/admin/user-list"/>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Chi tiết tài khoản</title>
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

<div class="container-fluid px-2 px-md-4 py-4">
    <div class="row">
        <div class="col-12">
            <div class="card my-4">
                <div class="card-header p-0 position-relative mt-n4 mx-4 z-index-2">
                    <div class="bg-gradient-dark shadow-dark border-radius-lg pt-4 pb-3">
                        <h6 class="text-white text-capitalize ps-3">Thêm tài khoản</h6>
                    </div>
                </div>

                <div class="card-body px-3 pb-2">
                    <form:form method="get" id="form-add" name="form-add" modelAttribute="userAdd">
                        <div class="col-12 col-xl-4">
                            <div class="card card-plain h-100"> <!-- -->
                                <div class="form-group py-1">
                                    <label for="email"><strong class="text-dark">Email</strong></label>
                                    <input id="email" name="email" type="email" class="form-control px-2" style="border: 1px solid black" />
                                </div>

<%--                                <div class="form-group py-1">--%>
<%--                                    <label for="roleCode"><strong class="text-dark">Quyền</strong></label>--%>
<%--                                    <form:select path="roleCode" id="roleCode" name="roleCode"--%>
<%--                                                 class="form-select px-2" style="border: 1px solid black">--%>
<%--                                        <form:options items="${role}"/>--%>
<%--                                    </form:select>--%>
<%--                                </div>--%>

                                <div class="form-group py-2">
                                    <button type="button" class="btn bg-gradient-success py-2 px-3"
                                            id="btnAddUser">Tạo
                                    </button>&nbsp;
                                    <button type="reset"
                                            class="btn bg-gradient-faded-dark py-2 px-3"><a
                                            class="text-white" href="${userListURL}">Quay lại</a>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </form:form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        $('#btnAddUser').click(function () {
            $('#form-add').submit();
        });
        setTimeout(function () {
            $('#alertResult').hide();
        }, 2000);
    });
    $(function () {
        $("form[name='form-add']").validate({
            rules: {
                email: "required"
            },
            messages: {
                email: "<span style='color: red'>Phải điền email!</span>"
            },
            submitHandler: function (form) {
                let formData = $('#form-add').serializeArray();
                let dataArray = {};

                $.each(formData, function (i, v) {
                    dataArray["" + v.name + ""] = v.value.trim();
                });
                dataArray["roleCode"] = "USER";

                console.log(dataArray)

                if (confirm("Bạn chắc chắn muốn thêm tài khoản?")) {
                    insert(dataArray);
                }
            }
        });
    });

    function insert(json) {
        $.ajax({
            url: "/api/admin/users",
            method: "POST",
            data: JSON.stringify(json),
            contentType: "application/json; charset=UTF-8",
            dataType: "JSON",
            success: function (result) {
                console.log(result);
                alert(result.message);
                location.replace("http://localhost:8090${userListURL}");
            },
            error: function (result) {
                console.log(result);

                let message = result.responseJSON.message + "\n";

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