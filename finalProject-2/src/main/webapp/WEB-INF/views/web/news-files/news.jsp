<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<c:set var="pageURL" value="/news"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Tin tức</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
</head>
<body class="goto-here">
<div class="hero-wrap hero-bread" style="background-image: url('web-user/images/bg_1.jpg');">
    <div class="container">
        <div class="row no-gutters slider-text align-items-center justify-content-center">
            <div class="col-md-9 ftco-animate text-center">
                <p class="breadcrumbs" style="font-size: 14px"><span class="mr-2"><a href="/home">Trang chủ</a></span>
                </p>
                <h1 class="mb-0 bread">Tin tức</h1>
            </div>
        </div>
    </div>
</div>

<c:set var="newsName" value="${param.name}"/>
<c:choose>
    <c:when test="${not empty newsName}">
        <c:set var="name" value="${'&name='}${newsName}"/>
    </c:when>

    <c:otherwise>
        <c:set var="name" value="${''}"/>
    </c:otherwise>
</c:choose>

<c:set var="newsCode" value="${param.type}"/>
<c:choose>
    <c:when test="${not empty newsCode}">
        <c:set var="type" value="${'&type='}${newsCode}"/>
    </c:when>
    <c:otherwise>
        <c:set var="type" value=""/>
    </c:otherwise>
</c:choose>

<section class="ftco-section ftco-degree-bg">
    <div class="container">
        <div class="row">
            <!-- Hiển thị các bài viết-->
            <div class="col-lg-8 ftco-animate">
                <div class="row">
                    <c:choose>
                        <c:when test="${newsList.content.size() == 0}">
                            <h3>Không có tin tức nào.</h3>
                        </c:when>
                        <c:otherwise>
                            <!-- Testing area -->
                            <c:forEach var="newsSingle" items="${newsList.content}">
                                <div class="col-md-12 d-flex ftco-animate">
                                    <div class="blog-entry align-self-stretch d-md-flex">
                                        <a href="/news-single-${newsSingle.id}" class="block-20"
                                           style="background-image: url('/repository${newsSingle.image}');">
                                        </a>
                                        <div class="text d-block pl-md-4">
                                            <div class="meta mb-3" style="font-size: 14px;">
                                                <div><a href="#"><span class="icon-calendar"></span>
                                                    <fmt:formatDate value="${newsSingle.createdAt}" pattern="dd/MM/yyyy, HH:mm"/>
                                                </a></div>
                                                <div class="text-dark"><span class="icon-eye"></span><fmt:formatNumber value="${newsSingle.view}" pattern="#,###"/> </div>
                                            </div>
                                            <h3 class="heading"><a href="/news-single-${newsSingle.id}">${newsSingle.name}</a></h3>
                                            <p class="text-justify text-dark">${newsSingle.description}</p>
                                            <p><a href="/news-single-${newsSingle.id}" class="btn btn-primary py-2 px-3">Chi tiết</a></p>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>

                            <!-- Index of pagination -->
                            <div class="col text-center">
                                <div class="block-27">
                                    <div class="pagination">
                                        <ul>
                                            <c:if test="${newsList.hasPrevious()}">
                                                <li>
                                                    <a href="${pageURL}?page=0${name}${type}">&lt;&lt;</a>
                                                </li>
                                            </c:if>
                                            <c:if test="${newsList.hasPrevious()}">
                                                <li>
                                                    <a href="${pageURL}?page=${newsList.number - 1}${name}${type}">&lt;</a>
                                                </li>
                                            </c:if>

                                            <c:forEach var="i" begin="0" end="${newsList.totalPages - 1}">
                                                <c:choose>
                                                    <c:when test="${i == newsList.number}">
                                                        <li class="active"><span>${i + 1}</span></li>
                                                    </c:when>
                                                    <%-- Hiển thị các trang lân cận và trang đầu/cuối --%>
                                                    <c:when test="${i == 0 || i == newsList.totalPages - 1 || (i >= newsList.number - 1 && i <= newsList.number + 1)}">
                                                        <li>
                                                            <a href="${pageURL}?page=${i}${name}${type}">${i + 1}</a>
                                                        </li>
                                                    </c:when>
                                                    <%-- Hiển thị dấu "..." --%>
                                                    <c:when test="${(newsList.number > 2 && i == newsList.number - 2) || (i == newsList.number + 2 && newsList.number < newsList.totalPages - 3)}">
                                                        <li><span>...</span></li>
                                                    </c:when>
                                                </c:choose>
                                            </c:forEach>

                                            <c:if test="${newsList.hasNext()}">
                                                <li>
                                                    <a href="${pageURL}?page=${newsList.number + 1}${name}${type}">&gt;</a>
                                                </li>
                                            </c:if>
                                            <c:if test="${newsList.hasNext()}">
                                                <li>
                                                    <a href="${pageURL}?page=${newsList.totalPages - 1}${name}${type}">&gt;&gt;</a>
                                                </li>
                                            </c:if>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div> <!-- .col-md-8 -->

            <!-- Right menu -->
            <div class="col-lg-4 sidebar ftco-animate">
                <!-- Search bar -->
                <div class="sidebar-box">
                    <div class="search-form">
                        <div class="form-group">
                            <span class="icon ion-ios-search"></span>
                            <input id="newsNameSearch" type="text" class="form-control border border-dark rounded" style="font-size: 14px;" placeholder="Tìm bài viết...">
                        </div>
                    </div>
                </div>

                <!-- News type -->
                <div class="sidebar-box ftco-animate">
                    <h3 class="heading">Danh mục</h3>
                    <ul class="categories">
                        <c:forEach var="newsType" items="${newsTypeList}">
                            <li>
                                <input id="newsCodeSingle" type="hidden" value="${newsType.code}"/>
                                <a id="newsTypeSingle" href="#">${newsType.name}<span class="text-dark">(${newsType.total})</span></a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>

                <!-- 3 news with the highest view-->
                <div class="sidebar-box ftco-animate">
                    <h3 class="heading">Tin tức nổi bật</h3>

                    <c:forEach var="singlePopularNews" items="${mostPopularNews}">
                        <div class="block-21 mb-4 d-flex">
                            <a class="blog-img mr-4"
                               style="background-image: url('/repository${singlePopularNews.image}');"></a>
                            <div class="text">
                                <h3 class="heading-1"><a
                                        href="/news-single-${singlePopularNews.id}">${singlePopularNews.name}</a>
                                </h3>
                                <div class="meta">
                                    <div class="text-dark"><span class="icon-calendar"></span><fmt:formatDate
                                            value="${singlePopularNews.createdAt}" pattern="dd/MM/yyyy"/></div>
                                    <div class="text-dark"><span class="icon-eye"></span><fmt:formatNumber value="${singlePopularNews.view}" pattern="#,###"/></div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

        </div>
    </div>
</section> <!-- .section -->

<script>
    $(document).ready(function(){
        $('#newsNameSearch').val("${param.name}");
    });

    const newsTypes = document.querySelectorAll('#newsTypeSingle');
    newsTypes.forEach(item => {
        item.addEventListener('click', function (event) {
            event.preventDefault();

            const parentItem = this.parentElement;
            window.location.href = "${pageURL}?${name}&type=" + parentItem.querySelector('#newsCodeSingle').value;
        });
    });

    $('#newsNameSearch').keyup(function (event) {
        event.preventDefault();
        if (event.key === 'Enter') {
            window.location.href = "${pageURL}?name=" + ($('#newsNameSearch').val().trim()) + "${type}";
        }
    });
</script>
</body>
</html>