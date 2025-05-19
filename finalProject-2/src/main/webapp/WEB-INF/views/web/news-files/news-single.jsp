<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp"%>
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
          	<p class="breadcrumbs" style="font-size: 14px"><span class="mr-2"><a href="home.jsp">Trang chủ</a></span></p>
            <h1 class="mb-0 bread">Chi tiết tin tức</h1>
          </div>
        </div>
      </div>
    </div>

    <section class="ftco-section ftco-degree-bg">
      <div class="container">
        <div class="row">
          <div class="col-lg-12 ftco-animate">
            <form:form method="get" modelAttribute="newsSingle">
              <fmt:formatDate value="${newsSingle.createdAt}" pattern="EEEE, dd/MM/yyyy, HH:mm, 'GMT('X')'"/>

              <h2 class="mb-3">${newsSingle.name}</h2>
              ${newsSingle.content}
            </form:form>
          </div> <!-- .col-md-8 -->

        </div>
      </div>
    </section> <!-- .section -->

  </body>
</html>