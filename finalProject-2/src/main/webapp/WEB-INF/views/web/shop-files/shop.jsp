<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.javaweb.util.SortType" %>
<%@include file="/common/taglib.jsp" %>
<c:set var="pageURL" value="/shop"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Tất cả sản phẩm</title>
</head>
<body class="goto-here">

<c:set var="categoryId" value="${param.categoryId}"/>
<c:choose>
    <c:when test="${not empty categoryId}">
        <c:set var="category" value="${'&categoryId='}${categoryId}"/>
    </c:when>

    <c:otherwise>
        <c:set var="category" value="${''}"/>
    </c:otherwise>
</c:choose>

<c:set var="productNameSearch" value="${param.productName}"/>
<c:choose>
    <c:when test="${not empty productNameSearch}">
        <c:set var="productNameSearchString" value="${'&productName='}${productNameSearch}"/>
    </c:when>
    <c:otherwise>
        <c:set var="productNameSearchString" value=""/>
    </c:otherwise>
</c:choose>

<c:set var="sortParam" value="&sortBy"/>
<c:set var="sortParamValue" value="${param.sortBy}"/>
<c:choose>
    <c:when test="${not empty sortParamValue}">
        <c:set var="sort" value="&${sortParam}=${sortParamValue}"/>
    </c:when>
    <c:otherwise>
        <c:set var="sort" value=""/>
    </c:otherwise>
</c:choose>

<div class="hero-wrap hero-bread" style="background-image: url('web-user/images/bg_1.jpg');">
    <div class="container">
        <div class="row no-gutters slider-text align-items-center justify-content-center">
            <div class="col-md-9 ftco-animate text-center">
                <p class="breadcrumbs" style="font-size: 14px"><span class="mr-2"><a href="/home">Trang chủ</a></span>
                </p>
                <h1 class="mb-0 bread">Sản phẩm</h1>
            </div>
        </div>
    </div>
</div>

<!-- Hiển thị danh sách sản phẩm -->
<form:form method="get" name="form-search" id="form-search" modelAttribute="productSearch" class="search-form">
    <section class="ftco-section">
        <!-- Search bar  -->
            <%--        <div class="row">--%>
            <%--            <div class="col-lg-9 sidebar"></div>--%>
            <%--            <div class="col-lg-2 ftco-animate">--%>

            <%--                <div class="sidebar-box">--%>
            <%--                    <div class="form-group">--%>
            <%--                        <span class="icon ion-ios-search"></span>--%>
            <%--                        <form:input path="name" type="text" class="form-control rounded"--%>
            <%--                                    placeholder="Tìm sản phẩm" style="border: 1px solid black; font-size: 16px"/>--%>
            <%--                    </div>--%>
            <%--                </div>--%>

            <%--            </div>--%>
            <%--            <div class="col-lg-1 sidebar"></div>--%>
            <%--        </div>--%>

        <!-- All products -->
        <div class="container">
            <h3>${categoryName}</h3>
            <hr>
            <!-- Sort -->
            <div class="justify-content-lg-end mb-3">
                <label for="sortBy" class="text-dark">Sắp xếp: </label>
                <select id="sortBy" style="border-radius: 4px;">
                    <option value="${pageURL}?${category}${productNameSearchString}${sortParam}=<%=SortType.DEFAULT.getName()%>">
                        Mặc định
                    </option>
                    <option value="${pageURL}?${category}${productNameSearchString}${sortParam}=<%=SortType.NAME.getName()%>">
                        A -> Z
                    </option>
                    <option value="${pageURL}?${category}${productNameSearchString}${sortParam}=<%=SortType.NAME_DESC.getName()%>">
                        Z -> A
                    </option>
                    <option value="${pageURL}?${category}${productNameSearchString}${sortParam}=<%=SortType.PRICE.getName()%>">
                        Giá tăng dần
                    </option>
                    <option value="${pageURL}?${category}${productNameSearchString}${sortParam}=<%=SortType.PRICE_DESC.getName()%>">
                        Giá giảm dần
                    </option>
                    <option value="${pageURL}?${category}${productNameSearchString}${sortParam}=<%=SortType.LATEST.getName()%>">
                        Hàng mới nhất
                    </option>
                    <option value="${pageURL}?${category}${productNameSearchString}${sortParam}=<%=SortType.OLDEST.getName()%>">
                        Hàng cũ nhất
                    </option>
                </select>
            </div>

            <c:choose>
                <c:when test="${productList.content.size() > 0}">
                    <div class="row">

                        <c:forEach var="productSingle" items="${productList.content}">
                            <div class="col-md-6 col-lg-3 ftco-animate">
                                <div class="product">
                                    <a href="/product-single-${productSingle.id}" class="img-prod"><img
                                            class="img-fluid"
                                            src="/repository${productSingle.image}"
                                            alt="${productSingle.name}">
                                        <c:if test="${productSingle.discount != 0}">
                                        <span class="status"><fmt:formatNumber value="${productSingle.discount}"
                                                                               pattern="#0"/> %</span>
                                        </c:if>
                                        <div class="overlay"></div>
                                    </a>
                                    <div class="text py-3 pb-4 px-3 text-center">
                                        <h3><a href="#">${productSingle.name}</a></h3>
                                        <div class="d-flex">
                                            <div class="pricing">
                                                <p class="price">
                                                    <c:if test="${productSingle.discount != 0}">
                                                        <span class="mr-2 price-dc"><fmt:formatNumber
                                                                value="${productSingle.price}" pattern="#,###"/>₫</span>
                                                        <span class="price-sale">
                                                            <fmt:formatNumber
                                                                    value="${productSingle.price - productSingle.discount / 100 * productSingle.price}"
                                                                    pattern="#,###"/>₫
                                                        </span>
                                                    </c:if>

                                                    <c:if test="${productSingle.discount == 0}">
                                                        <span class="price-sale"><fmt:formatNumber
                                                                value="${productSingle.price}" pattern="#,###"/>₫</span>
                                                    </c:if>
                                                </p>
                                            </div>
                                        </div>
                                        <div class="bottom-area d-flex px-3">
                                            <div class="m-auto d-flex">
                                                <a href="/product-single-${productSingle.id}"
                                                   class="add-to-cart d-flex justify-content-center align-items-center text-center">
                                                    <span><i class="ion-ios-menu"></i></span>
                                                </a>

                                                <input id="productId" type="hidden" value="${productSingle.id}"/>
                                                <a href="#"
                                                   class="buy-now d-flex justify-content-center align-items-center mx-1"
                                                   onclick="checkQuantity(${productSingle.id}, ${productSingle.quantity}, event)">
                                                    <span><i class="ion-ios-cart"></i></span>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>

                <c:otherwise>
                    <div class="row justify-content-center">
                        <h3>Không tìm thấy sản phẩm nào.</h3>
                    </div>
                </c:otherwise>
            </c:choose>

            <c:if test="${productList.content.size() > 0}">
                <div class="row mt-5">
                    <div class="col text-center">
                        <div class="block-27">
                            <ul>
                                <c:if test="${productList.hasPrevious()}">
                                    <li>
                                        <a href="${pageURL}?${category}${productNameSearchString}${sort}&page=0">&lt;&lt;</a>
                                    </li>
                                </c:if>
                                <c:if test="${productList.hasPrevious()}">
                                    <li>
                                        <a href="${pageURL}?${category}${productNameSearchString}${sort}&page=${productList.number - 1}">&lt;</a>
                                    </li>
                                </c:if>

                                <c:forEach var="i" begin="0" end="${productList.totalPages - 1}">
                                    <c:choose>
                                        <c:when test="${i == productList.number}">
                                            <li class="active"><span>${i + 1}</span></li>
                                        </c:when>

                                        <%-- Hiển thị các trang lân cận và trang đầu/cuối --%>
                                        <c:when test="${i == 0 || i == productList.totalPages - 1 || (i >= productList.number - 1 && i <= productList.number + 1)}">
                                            <li>
                                                <a href="${pageURL}?${category}${productNameSearchString}${sort}&page=${i}">${i + 1}</a>
                                            </li>
                                        </c:when>

                                        <%-- Hiển thị dấu "..." --%>
                                        <c:when test="${(productList.number > 2 && i == productList.number - 2) || (i == productList.number + 2 && productList.number < productList.totalPages - 3)}">
                                            <li><span>...</span></li>
                                        </c:when>
                                    </c:choose>
                                </c:forEach>

                                <c:if test="${productList.hasNext()}">
                                    <li>
                                        <a href="${pageURL}?${category}${productNameSearchString}${sort}&page=${productList.number + 1}">&gt;</a>
                                    </li>
                                </c:if>
                                <c:if test="${productList.hasNext()}">
                                    <li>
                                        <a href="${pageURL}?${category}${productNameSearchString}${sort}&page=${productList.totalPages - 1}">&gt;&gt;</a>
                                    </li>
                                </c:if>
                            </ul>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
    </section>
</form:form>

<script>
    <c:set var="cartAPI" value="/api/carts"/>

    $(document).ready(function () {
        fillSortBy();
    });

    function fillSortBy() {
        let sortTypes = $('#sortBy option');
        let sortName = "${sortName}";
        console.log(sortName);
        $.each(sortTypes, function (idx, it) {
            if (it.textContent === sortName) {
                it.setAttribute('selected', 'selected');
                return true;
            }
        });
    }

    function checkQuantity(productId, quantity, event) {
        event.preventDefault();

        if (quantity < 1) {
            alert('Sản phẩm này đã hết hàng !');
        } else {
            addToCart(productId);
        }
    }

    function addToCart(productId) {
        $.ajax({
            url: "${cartAPI}",
            method: "POST",
            data: JSON.stringify({id: productId, quantity: 1}),
            contentType: "application/json; charset=UTF-8",
            dataType: "JSON",
            success: function (result) {
                alert(result.message);
                accessCartAPI();
            },
            error: function (result) {
                alert(result.responseJSON.message);
            }
        });
    }

    let sort = document.getElementById('sortBy');
    sort.addEventListener('change', function () {
        window.location.href = this.value;
    });
</script>

</body>
</html>