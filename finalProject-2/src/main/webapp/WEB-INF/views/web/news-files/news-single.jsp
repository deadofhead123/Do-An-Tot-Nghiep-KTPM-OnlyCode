<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Chi tiết tin tức</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
</head>
<body class="goto-here">

<div class="hero-wrap hero-bread" style="background-image: url('web-user/images/bg_1.jpg');">
    <div class="container">
        <div class="row no-gutters slider-text align-items-center justify-content-center">
            <div class="col-md-9 ftco-animate text-center">
                <p class="breadcrumbs" style="font-size: 14px"><span class="mr-2"><a
                        href="home.jsp">Trang chủ</a></span></p>
                <h1 class="mb-0 bread">Chi tiết tin tức</h1>
            </div>
        </div>
    </div>
</div>

<section class="ftco-section ftco-degree-bg">
    <div class="container">
        <div class="row">
            <form:form method="get" modelAttribute="newsSingle">
                <div class="col-lg-12 ftco-animate">
                    <span class="text-dark"><fmt:formatDate value="${newsSingle.createdAt}" pattern="EEEE, dd/MM/yyyy, HH:mm, 'GMT('X')'"/></span>
                    <h2 class="mt-3 mb-1">${newsSingle.name}</h2>

                    <div align="center">
                        <c:if test="${not empty newsSingle.image}">
                            <img src="/repository${newsSingle.image}" id="viewImage"
                                 style="margin-top: 50px;" alt="Không tìm thấy ảnh">
                        </c:if>

                        <!--Hiện ảnh đại diện mặc định-->
                        <c:if test="${empty newsSingle.image}">
                            <img src="/admin/image/default.png" id="viewImage" width="600px" height="300px"
                                 alt="Chưa có ảnh">
                        </c:if>
                    </div>
                </div>
                <!-- .col-md-8 -->
                <br>
                <div class="col-lg-12 ftco-animate">
                    <div class="text-dark">
                            ${newsSingle.content}
                    </div>
                </div>
            </form:form>

        </div>
    </div>
</section> <!-- .section -->

</body>
</html>