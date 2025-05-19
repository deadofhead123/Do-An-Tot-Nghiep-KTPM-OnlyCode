<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2/25/2025
  Time: 1:48 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.javaweb.security.utils.SecurityUtils" %>
<%@include file="/common/taglib.jsp" %>

<!-- Thanh viền màu xanh phía trên cùng -->
<div class="py-1 bg-primary">
    <div class="container">
        <div class="row no-gutters d-flex align-items-start align-items-center px-md-0">
            <div class="col-lg-12 d-block">
                <div class="row d-flex">
                    <div class="col-md pr-4 d-flex topper align-items-center">
                        <div class="icon mr-2 d-flex justify-content-center align-items-center"><span
                                class="icon-phone2"></span></div>
                        <span class="text">0984 243 005</span>
                    </div>
                    <div class="col-md pr-4 d-flex topper align-items-center">
                        <div class="icon mr-2 d-flex justify-content-center align-items-center"><span
                                class="icon-paper-plane"></span></div>
                        <span class="text">phamminhhoa3005.shopapp@gmail.com</span>
                    </div>
                    <div class="col-md-5 pr-4 d-flex topper align-items-center text-lg-right">
                        <span class="text">1-2 ngày giao hàng &amp; Miễn phí đổi trả</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark ftco-navbar-light ftco_navbar " id="ftco-navbar">
    <div class="container">
        <a class="navbar-brand" href="/home">Vegefood</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav"
                aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="oi oi-menu"></span> Menu
        </button>

        <div class="collapse navbar-collapse" id="ftco-nav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item dropdown" id="categories">
                    <a class="nav-link" href="/shop">
                        Sản phẩm
                        <i class="dropdown-toggle" id="dropdown03" data-toggle="dropdown" aria-haspopup="true"
                           aria-expanded="true"></i>
                    </a>

                    <!-- Feature of user -->
                    <div id="allCategory" class="dropdown-menu" style="border: 1px solid black;" aria-labelledby="dropdown03">

                    </div>
                </li>
                <li class="nav-item"><a href="/about" class="nav-link">Giới thiệu</a></li>
                <li class="nav-item"><a href="/news" class="nav-link">Tin tức</a></li>
                <li class="nav-item"><a href="/contact" class="nav-link">Liên hệ</a></li>

                <!-- For user WITHOUT account  -->
                <security:authorize access="isAnonymous()">
                    <li class="nav-item"><a href="<c:url value='/login'/>" class="nav-link"><b>Đăng nhập</b></a>
                    </li>
                    <li class="nav-item"><a href="<c:url value='#'/>" class="nav-link">hoặc</a></li>
                    <li class="nav-item"><a href="<c:url value='/signup'/>" class="nav-link"><b>Đăng ký</b></a></li>
                </security:authorize>

                <!-- For user WITH account -->
                <security:authorize access="isAuthenticated()">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="dropdown04" data-toggle="dropdown"
                           aria-haspopup="true" aria-expanded="false">
                            Xin chào, <%=SecurityUtils.getPrincipal().getFullName()%>
                        </a>

                        <!-- Feature of user -->
                        <div class="dropdown-menu" style="border: 1px solid black;" aria-labelledby="dropdown04">
                            <c:set var="roleName" value="<%=SecurityUtils.getAuthorities().get(0)%>"/>

                            <c:if test="${roleName == 'ROLE_USER'}">
                                <a class="dropdown-item" href="/my-account">Tài khoản</a>
                                <a class="dropdown-item" href="/my-orders">Đơn hàng</a>
                                <a class="dropdown-item" href="/logout">Đăng xuất</a>
                            </c:if>

                            <c:if test="${roleName != 'ROLE_USER'}">
                                <a class="dropdown-item" href="/admin/home">Trang quản trị</a>
                                <a class="dropdown-item" href="/logout">Đăng xuất</a>
                            </c:if>
                        </div>
                    </li>

                    <c:if test="${roleName == 'ROLE_USER'}">
                        <li class="nav-item cta cta-colored">
                            <a id="cartElement" href="/cart" class="nav-link" title="Giỏ hàng của bạn">
                                <span class="icon-shopping-cart"></span>
                                <span id="quantitySumOfCart"></span>
                                <script>
                                    function accessCartAPI() {
                                        let quantitySum = 0;

                                        $.ajax({
                                            url: "/api/carts",
                                            method: "GET",
                                            contentType: "application/json; charset=UTF-8",
                                            dataType: "JSON",
                                            success: function (result) {
                                                quantitySum = result.data;
                                                document.getElementById('quantitySumOfCart').textContent = "[" + quantitySum + "]";
                                                document.getElementById('cartElement').title = "Giỏ hàng của bạn đang có " + quantitySum + " sản phẩm";
                                            },
                                            error: function (result) {
                                                document.getElementById('quantitySumOfCart').textContent = "[" + quantitySum + "]";
                                                document.getElementById('cartElement').title = "Giỏ hàng của bạn đang có " + quantitySum + " sản phẩm";
                                            }
                                        });
                                    }

                                    accessCartAPI();
                                </script>
                            </a>
                        </li>
                    </c:if>
                </security:authorize>
            </ul>
        </div>
    </div>

    <div class="container justify-content-lg-end">
        <form action="#" class="search-form">
            <div class="form-group">
                <input id="productName" type="text" class="rounded"
                       placeholder="Tìm sản phẩm..."
                       style="border: 1px solid black; width: 280px; height: 30px;">
                <span class="icon ion-ios-search"></span>
                <%--                            <button id="btnSearchProduct" type="button" class="rounded"--%>
                <%--                                    style="width: 30px; height: 30px;" value="Tìm kiếm">--%>
                <%--                                <i class="icon-search rounded" style=""></i>--%>
                <%--                            </button>--%>
                <div id="autocompleteProduct" class="autocompleteProduct"></div>
            </div>
        </form>
    </div>
</nav>




