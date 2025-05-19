<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
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
                <p class="breadcrumbs" style="font-size: 14px"><span class="mr-2"><a href="/home">Trang chủ</a></span></p>
                <h1 class="mb-0 bread">Tin tức</h1>
            </div>
        </div>
    </div>
</div>

<section class="ftco-section ftco-degree-bg">
    <div class="container">
        <div class="row">
            <!-- Hiển thị các bài viết-->
            <div class="col-lg-8 ftco-animate">
                <div class="row">
                    <!-- Testing area -->
                    <c:forEach var="newsSingle" items="${newsList.content}">
                        <div class="col-md-12 d-flex ftco-animate">
                            <div class="blog-entry align-self-stretch d-md-flex">
                                <a href="/news-single-${newsSingle.id}" class="block-20"
                                   style="background-image: url('/repository${newsSingle.image}');">
                                </a>
                                <div class="text d-block pl-md-4">
                                    <div class="meta mb-3">
                                        <div><a href="#"><span class="icon-calendar"></span>
                                            <fmt:formatDate value="${newsSingle.createdAt}"
                                                            pattern="dd/MM/yyyy, HH:mm"/>
                                        </a></div>
                                        <div><span class="icon-eye"></span>${newsSingle.view}</div>
                                    </div>
                                    <h3 class="heading"><a href="#">${newsSingle.name}</a></h3>
                                    <p>${newsSingle.description}</p>
                                    <p><a href="/news-single-${newsSingle.id}" class="btn btn-primary py-2 px-3">Chi
                                        tiết</a></p>
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
                                            <a href="/news?page=0&size=${newsList.size}&name=${newsSearch.name}&type=${newsSearch.type}">&lt;&lt;</a>
                                        </li>
                                    </c:if>
                                    <c:if test="${newsList.hasPrevious()}">
                                        <li>
                                            <a href="/news?page=${newsList.number - 1}&size=${newsList.size}&name=${newsSearch.name}&type=${newsSearch.type}">&lt;</a>
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
                                                    <a href="/news?page=${i}&size=${newsList.size}&name=${newsSearch.name}&type=${newsSearch.type}">${i + 1}</a>
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
                                            <a href="/news?page=${newsList.number + 1}&size=${newsList.size}&name=${newsSearch.name}&type=${newsSearch.type}">&gt;</a>
                                        </li>
                                    </c:if>
                                    <c:if test="${newsList.hasNext()}">
                                        <li>
                                            <a href="/news?page=${newsList.totalPages - 1}&size=${newsList.size}&name=${newsSearch.name}&type=${newsSearch.type}">&gt;&gt;</a>
                                        </li>
                                    </c:if>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div> <!-- .col-md-8 -->

            <!-- Right menu -->
            <div class="col-lg-4 sidebar ftco-animate">
                <!-- Search bar -->
                <form:form method="get" name="form-search" id="form-search" modelAttribute="newsSearch"
                           class="search-form">
                    <div class="sidebar-box">
                        <div class="form-group">
                            <span class="icon ion-ios-search"></span>
                            <form:input path="name" type="text" class="form-control rounded"
                                        placeholder="Tìm bài viết" style="border: 1px solid black"/>
                        </div>
                    </div>
                </form:form>

                <!-- News type -->
                <div class="sidebar-box ftco-animate">
                    <h3 class="heading">Danh mục</h3>
                    <ul class="categories">
                        <c:forEach var="newsType" items="${newsTypeList}">
                            <li>
                                <a href="/news?name=${newsSearch.name}&type=${newsType.code}">${newsType.name}<span>(${newsType.total})</span></a>
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
                                    <div><span class="icon-calendar"></span><fmt:formatDate
                                            value="${singlePopularNews.createdAt}" pattern="dd/MM/yyyy"/></div>
                                    <div><span class="icon-eye"></span>${singlePopularNews.view}</div>
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
</script>
</body>
</html>