<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@include file="/common/taglib.jsp" %>
<c:url var="productSingleURL" value="/product-single"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Tài khoản</title>
</head>

<div class="hero-wrap hero-bread" style="background-image: url('web-user/images/bg_1.jpg');">
    <div class="container">
        <div class="row no-gutters slider-text align-items-center justify-content-center">
            <div class="col-md-9 ftco-animate text-center">
                <p class="breadcrumbs"><span class="mr-2"><a href="/home">Trang chủ</a></span></p>
                <h1 class="mb-0 bread">Sản phẩm đã mua</h1>
            </div>
        </div>
    </div>
</div>

<body>
<div class="myaccount__body">
    <c:choose>
        <c:when test="${productsBought.size() == 0}">
            <h3>Bạn chưa mua sản phẩm nào.</h3>
        </c:when>

        <c:otherwise>
            <section class="ftco-section ftco-cart">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12 ftco-animate">
                            <h3 class="mb-4">Các sản phẩm đã mua:</h3>

                            <div class="justify-content-lg-end mb-3">
                                <input id="productBoughtSearch" style="font-size: 16px; width: 250px; height: 40px;"
                                       type="text" placeholder="Tìm kiếm...">
                            </div>

                            <div class="table-container">
                                <div class="cart-list">
                                    <table id="productTable" class="table">
                                        <thead class="thead-primary">
                                        <tr class="text-center">
                                            <th>Ảnh đại diện</th>
                                            <th>Tên sản phẩm</th>
                                        </tr>
                                        </thead>

                                        <tbody id="productTable-body">
                                        <c:forEach var="productSingle" items="${productsBought}">
                                            <tr id="product-info" class="text-center">
                                                <td class="image-prod">
                                                    <div class="img">
                                                        <c:if test="${not empty productSingle.image}">
                                                            <c:set var="imagePath"
                                                                   value="/repository${productSingle.image}"/>
                                                            <a href="${productSingleURL}-${productSingle.id}">
                                                                <img src="${imagePath}" id="viewImage" width="100"
                                                                     height="100"
                                                                     style="margin-top: 5px; margin-bottom: 5px"
                                                                     alt="Không tìm thấy ảnh"></a>
                                                        </c:if>

                                                        <c:if test="${empty productSingle.image}">
                                                            <img src="/admin/image/default.png" id="viewImage"
                                                                 width="100" height="100"
                                                                 alt="Chưa có ảnh">
                                                        </c:if>
                                                    </div>
                                                </td>

                                                <td class="product-name">
                                                    <h3>${productSingle.name}</h3>
                                                </td>
                                            </tr>
                                            <!-- END TR-->
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </c:otherwise>
    </c:choose>
</div>

<script>
    function openImage(input, imageView) {
        if (input.files && input.files[0]) {
            let reader = new FileReader();
            reader.onload = function (e) {
                $('#' + imageView).attr('src', reader.result);
            }
            reader.readAsDataURL(input.files[0]);
        }
    }

    document.getElementById('productBoughtSearch').addEventListener('keyup', function () {
        let row = "";
        let productBoughtSearch = $('#productBoughtSearch').val().trim().toLowerCase();

        $.each(${productsBoughtJson}, function (idx, it) {
            if (it.name.toLowerCase().includes(productBoughtSearch)) {
                row += "<tr id='product-info' class='text-center'>\n";

                row += "<td class='image-prod'>\n" +
                    "<div class='img'>\n";
                if (it.image != null) {
                    row += "<a href='${productSingleURL}" + it.id + "'>\n" +
                        "<img src='/repository" + it.image + "' id='viewImage' width='100'\n" +
                        "height='100' \n" +
                        "style='margin-top: 5px; margin-bottom: 5px'\n" +
                        "alt='Không tìm thấy ảnh'></a>\n";
                } else {
                    row += "<img src='/admin/image/default.png' id='viewImage' \n" +
                        "width='100' height='100'\n" +
                        "alt='Chưa có ảnh'/>\n";
                }
                row += "</div>\n</td>\n";

                row += "<td class='product-name'>\n" +
                    "<h3>" + it.name + "</h3>\n" +
                    "</td>\n";

                row += "</tr>\n";
            }
        });

        document.getElementById('productTable-body').innerHTML = row;
    });
</script>
</body>
</html>