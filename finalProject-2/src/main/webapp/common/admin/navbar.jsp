<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 3/1/2025
  Time: 7:39 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.javaweb.security.utils.SecurityUtils" %>
<%@include file="/common/taglib.jsp" %>

<nav class="navbar navbar-main navbar-expand-lg px-0 mx-3 shadow-none border-radius-xl" id="navbarBlur"
     data-scroll="true">
    <div class="container-fluid py-1 px-3">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb bg-transparent mb-0 pb-0 pt-1 px-0 me-sm-6 me-5">
                <c:set var="currentURL" value="${pageContext.request.requestURL}"/>

                <!-- Sửa đổi cỡ chữ bằng text-lg (large), text-sm (small) ... -->
                <c:if test="${fn:contains(currentURL, '/admin/home')}">
                    <li class="breadcrumb-item text-sm text-dark active">Trang chủ</li>
                </c:if>

                <c:if test="${!fn:contains(currentURL, '/admin/home')}">
                    <li class="breadcrumb-item text-sm"><a class="opacity-5 text-dark" href="/admin/home">Trang chủ</a></li>
                </c:if>

                <c:if test="${fn:contains(currentURL, '/admin/dashboard')}">
                    <li class="breadcrumb-item text-sm text-dark active" aria-current="page">Thống kê</li>
                </c:if>

                <c:if test="${fn:contains(currentURL, '/admin/user')}">
                    <li class="breadcrumb-item text-sm text-dark active" aria-current="page">Người dùng</li>
                </c:if>

                <c:if test="${fn:contains(currentURL, '/admin/my-account')}">
                    <li class="breadcrumb-item text-sm text-dark active" aria-current="page">Tài khoản</li>
                </c:if>

                <c:if test="${fn:contains(currentURL, '/admin/contact')}">
                    <li class="breadcrumb-item text-sm text-dark active" aria-current="page">Liên hệ</li>
                </c:if>

                <c:if test="${fn:contains(currentURL, '/admin/category')}">
                    <li class="breadcrumb-item text-sm text-dark active" aria-current="page">Danh mục sản phẩm</li>
                </c:if>

                <c:if test="${fn:contains(currentURL, '/admin/product-')}">
                    <li class="breadcrumb-item text-sm text-dark active" aria-current="page">Sản phẩm</li>
                </c:if>

                <c:if test="${fn:contains(currentURL, '/admin/order')}">
                    <li class="breadcrumb-item text-sm text-dark active" aria-current="page">Đơn hàng</li>
                </c:if>

                <c:if test="${fn:contains(currentURL, '/admin/import')}">
                    <li class="breadcrumb-item text-sm text-dark active" aria-current="page">Nhập hàng</li>
                </c:if>

                <c:if test="${fn:contains(currentURL, '/admin/productInventory')}">
                    <li class="breadcrumb-item text-sm text-dark active" aria-current="page">Kho hàng</li>
                </c:if>

                <c:if test="${fn:contains(currentURL, '/admin/new')}">
                    <li class="breadcrumb-item text-sm text-dark active" aria-current="page">Tin tức</li>
                </c:if>
            </ol>
        </nav>
        <div class="collapse navbar-collapse mt-sm-0 mt-2 me-md-0 me-sm-4" id="navbar">
            <div class="ms-md-auto pe-md-3 d-flex align-items-center">

            </div>
            <ul class="navbar-nav d-flex align-items-center  justify-content-end">
                <li class="nav-item d-xl-none ps-3 d-flex align-items-center">
                    <a href="javascript:;" class="nav-link text-body p-0" id="iconNavbarSidenav">
                        <div class="sidenav-toggler-inner">
                            <i class="sidenav-toggler-line"></i>
                            <i class="sidenav-toggler-line"></i>
                            <i class="sidenav-toggler-line"></i>
                        </div>
                    </a>
                </li>

                <li class="nav-item px-3 d-flex align-items-center">
                    <a href="javascript:;" class="nav-link text-body p-0">
                        <i class="material-symbols-rounded fixed-plugin-button-nav">settings</i>
                    </a>
                </li>

                <li class="nav-item dropdown pe-3 d-flex align-items-center">
                    <a href="javascript:;" class="nav-link text-body p-0" id="dropdownMenuButton"
                       data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="material-symbols-rounded">notifications</i>
                    </a>
                    <ul class="dropdown-menu  dropdown-menu-end  px-2 py-3 me-sm-n4"
                        aria-labelledby="dropdownMenuButton">
                        <li class="mb-2">
                            <a class="dropdown-item border-radius-md" href="javascript:;">
                                <div class="d-flex py-1">
                                    <div class="my-auto">
                                        <img src="../admin/img/team-2.jpg" class="avatar avatar-sm  me-3 ">
                                    </div>
                                    <div class="d-flex flex-column justify-content-center">
                                        <h6 class="text-sm font-weight-normal mb-1">
                                            <span class="font-weight-bold">New message</span> from Laur
                                        </h6>
                                        <p class="text-xs text-secondary mb-0">
                                            <i class="fa fa-clock me-1"></i>
                                            13 minutes ago
                                        </p>
                                    </div>
                                </div>
                            </a>
                        </li>

                        <li class="mb-2">
                            <a class="dropdown-item border-radius-md" href="javascript:;">
                                <div class="d-flex py-1">
                                    <div class="my-auto">
                                        <img src="../admin/img/small-logos/logo-spotify.svg"
                                             class="avatar avatar-sm bg-gradient-dark  me-3 ">
                                    </div>
                                    <div class="d-flex flex-column justify-content-center">
                                        <h6 class="text-sm font-weight-normal mb-1">
                                            <span class="font-weight-bold">New album</span> by Travis Scott
                                        </h6>
                                        <p class="text-xs text-secondary mb-0">
                                            <i class="fa fa-clock me-1"></i>
                                            1 day
                                        </p>
                                    </div>
                                </div>
                            </a>
                        </li>

                        <li>
                            <a class="dropdown-item border-radius-md" href="javascript:;">
                                <div class="d-flex py-1">
                                    <div class="avatar avatar-sm bg-gradient-secondary  me-3  my-auto">
                                        <svg width="12px" height="12px" viewBox="0 0 43 36" version="1.1"
                                             xmlns="http://www.w3.org/2000/svg"
                                             xmlns:xlink="http://www.w3.org/1999/xlink">
                                            <title>credit-card</title>
                                            <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                                <g transform="translate(-2169.000000, -745.000000)" fill="#FFFFFF"
                                                   fill-rule="nonzero">
                                                    <g transform="translate(1716.000000, 291.000000)">
                                                        <g transform="translate(453.000000, 454.000000)">
                                                            <path class="color-background"
                                                                  d="M43,10.7482083 L43,3.58333333 C43,1.60354167 41.3964583,0 39.4166667,0 L3.58333333,0 C1.60354167,0 0,1.60354167 0,3.58333333 L0,10.7482083 L43,10.7482083 Z"
                                                                  opacity="0.593633743"></path>
                                                            <path class="color-background"
                                                                  d="M0,16.125 L0,32.25 C0,34.2297917 1.60354167,35.8333333 3.58333333,35.8333333 L39.4166667,35.8333333 C41.3964583,35.8333333 43,34.2297917 43,32.25 L43,16.125 L0,16.125 Z M19.7083333,26.875 L7.16666667,26.875 L7.16666667,23.2916667 L19.7083333,23.2916667 L19.7083333,26.875 Z M35.8333333,26.875 L28.6666667,26.875 L28.6666667,23.2916667 L35.8333333,23.2916667 L35.8333333,26.875 Z"></path>
                                                        </g>
                                                    </g>
                                                </g>
                                            </g>
                                        </svg>
                                    </div>
                                    <div class="d-flex flex-column justify-content-center">
                                        <h6 class="text-sm font-weight-normal mb-1">
                                            Payment successfully completed
                                        </h6>
                                        <p class="text-xs text-secondary mb-0">
                                            <i class="fa fa-clock me-1"></i>
                                            2 days
                                        </p>
                                    </div>
                                </div>
                            </a>
                        </li>
                    </ul>
                </li>

                <li class="nav-item dropdown pe-3 d-flex align-items-center">
                    <a href="javascript:;" class="nav-link p-0" style="color: black;" id="dropdownMenu2" data-bs-toggle="dropdown" aria-expanded="false">
                        Xin chào, <%=SecurityUtils.getPrincipal().getFullName()%>
                    </a>
                    <ul class="dropdown-menu  dropdown-menu-end  px-2 py-3 me-sm-n4"
                        aria-labelledby="dropdownMenu2">
                        <li class="mb-2">
                            <a class="dropdown-item" style="color: black;" href="/admin/my-account">Tài khoản</a>
                            <a class="dropdown-item" style="color: black;" href="/logout">Đăng xuất</a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>
