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
<c:set var="dashboardURL" value="/admin/dashboard"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Trang quản trị</title>
</head>

<body class="g-sidenav-show">

<div class="container-fluid">
<header class="bg-gradient-dark">
    <div class="page-header min-vh-75" style="background-image: url(/web-user/images/bg_1.jpg);">
      <span class="mask bg-gradient-dark opacity-3"></span>
      <div class="container">
        <div class="row justify-content-center align-items-xxl-center">
          <div class="col-lg-8 text-center mx-auto my-auto">
            <h1 class="text-white">Quản lý shop hiệu quả hơn</h1>
            <button type="button" class="btn bg-gradient-success"><a href="${dashboardURL}" style="color: white">Bắt đầu ngay</a></button>
          </div>
        </div>
      </div>
    </div>
  </header>
</div>

</body>

</html>