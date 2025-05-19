<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>

<c:set var="cartAPI" value="/api/carts"/>
<c:set var="productSingleURL" value="/product-single"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Vegefoods - Yên tâm về chất lượng</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
</head>
<body class="goto-here">

<!-- Slidebar -->
<section id="home-section" class="hero">
    <div class="home-slider owl-carousel">
        <div class="slider-item" style="background-image: url(/web-user/images/bg_1.jpg);">
            <div class="overlay"></div>
            <div class="container">
                <div class="row slider-text justify-content-center align-items-center" data-scrollax-parent="true">

                    <div class="col-md-12 ftco-animate text-center">
                        <h1 class="mb-2">Rau củ quả hữu cơ</h1>
                        <h2 class="subheading mb-4">Được phân phối tới mọi nhà</h2>
                        <p><a href="/shop" class="btn btn-primary">Xem chi tiết</a></p>
                    </div>

                </div>
            </div>
        </div>

        <div class="slider-item" style="background-image: url(/web-user/images/bg_2.jpg);">
            <div class="overlay"></div>
            <div class="container">
                <div class="row slider-text justify-content-center align-items-center" data-scrollax-parent="true">
                    <div class="col-sm-12 ftco-animate text-center">
                        <h1 class="mb-2">100% sạch</h1>
                        <h2 class="subheading mb-4">Đã được kiểm chứng bởi hàng trăm khách hàng</h2>
                        <p><a href="#" class="btn btn-primary">Xem chi tiết</a></p>
                    </div>

                </div>
            </div>
        </div>
    </div>
</section>

<section class="ftco-section">
    <div class="container">
        <div class="row no-gutters ftco-services">
            <div class="col-md-3 text-center d-flex align-self-stretch ftco-animate">
                <div class="media block-6 services mb-md-0 mb-4">
                    <div class="icon bg-color-1 active d-flex justify-content-center align-items-center mb-2">
                        <span class="flaticon-shipped"></span>
                    </div>
                    <div class="media-body">
                        <h3 class="heading">Giao hàng nhanh chóng</h3>
                        <span>Trong vòng 1-2 ngày</span>
                    </div>
                </div>
            </div>
            <div class="col-md-3 text-center d-flex align-self-stretch ftco-animate">
                <div class="media block-6 services mb-md-0 mb-4">
                    <div class="icon bg-color-2 d-flex justify-content-center align-items-center mb-2">
                        <span class="flaticon-diet"></span>
                    </div>
                    <div class="media-body">
                        <h3 class="heading">Luôn luôn tươi</h3>
                        <span>Hàng được đóng gói cẩn thận</span>
                    </div>
                </div>
            </div>
            <div class="col-md-3 text-center d-flex align-self-stretch ftco-animate">
                <div class="media block-6 services mb-md-0 mb-4">
                    <div class="icon bg-color-3 d-flex justify-content-center align-items-center mb-2">
                        <span class="flaticon-award"></span>
                    </div>
                    <div class="media-body">
                        <h3 class="heading">Chất lượng tuyệt vời</h3>
                        <span>10 điểm cho chất lượng</span>
                    </div>
                </div>
            </div>
            <div class="col-md-3 text-center d-flex align-self-stretch ftco-animate">
                <div class="media block-6 services mb-md-0 mb-4">
                    <div class="icon bg-color-4 d-flex justify-content-center align-items-center mb-2">
                        <span class="flaticon-customer-service"></span>
                    </div>
                    <div class="media-body">
                        <h3 class="heading">Hỗ trợ</h3>
                        <span>24/7 các ngày trong tuần</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="ftco-section ftco-category ftco-no-pt">
    <div class="container">
        <div class="row">
            <div class="col-md-8">
                <div class="row">
                    <div class="col-md-6 order-md-last align-items-stretch d-flex">
                        <div class="category-wrap-2 ftco-animate img align-self-stretch d-flex"
                             style="background-image: url(web-user/images/category.jpg);">
                            <div class="text text-center">
                                <h2>Rau củ</h2>
                                <p>Bảo vệ sức khỏe mọi nhà</p>
                                <p><a href="/shop" class="btn btn-primary">Mua ngay</a></p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="category-wrap ftco-animate img mb-4 d-flex align-items-end"
                             style="background-image: url(web-user/images/category-1.jpg);">
                            <div class="text px-3 py-1">
                                <h2 class="mb-0 text-white">Rau củ</h2>
                            </div>
                        </div>
                        <div class="category-wrap ftco-animate img d-flex align-items-end"
                             style="background-image: url(web-user/images/category-2.jpg);">
                            <div class="text px-3 py-1">
                                <h2 class="mb-0 text-white">Trái cây</h2>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="category-wrap ftco-animate img mb-4 d-flex align-items-end"
                     style="background-image: url(web-user/images/category-3.jpg);">
                    <div class="text px-3 py-1">
                        <h2 class="mb-0 text-white">Nước ép</h2>
                    </div>
                </div>
                <div class="category-wrap ftco-animate img d-flex align-items-end"
                     style="background-image: url(web-user/images/category-4.jpg);">
                    <div class="text px-3 py-1">
                        <h2 class="mb-0 text-white">Đồ khô</h2>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="ftco-section">
    <div class="container">
        <div class="row justify-content-center mb-3 pb-3">
            <div class="col-md-12 heading-section text-center ftco-animate">
                <h2 class="mb-4">Sản phẩm bán chạy</h2>
                <%--                <p>Các sản phẩm được mua nhiều nhất</p>--%>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="row">
            <c:forEach var="hotProductSingle" items="${hotProducts}">
                <div class="col-md-6 col-lg-3 ftco-animate">
                    <div class="product">
                        <a href="${productSingleURL}-${hotProductSingle.id}" class="img-prod"><img
                                class="img-fluid"
                                src="/repository${hotProductSingle.image}"
                                alt="Colorlib Template">
                            <c:if test="${hotProductSingle.discount != 0}">
                                        <span class="status"><fmt:formatNumber value="${hotProductSingle.discount}"
                                                                               pattern="#0"/> %</span>
                            </c:if>
                            <div class="overlay"></div>
                        </a>
                        <div class="text py-3 pb-4 px-3 text-center">
                            <h3><a href="#">${hotProductSingle.name}</a></h3>
                            <div class="d-flex">
                                <div class="pricing">
                                    <p class="price">
                                        <c:if test="${hotProductSingle.discount != 0}">
                                            <span class="mr-2 price-dc"><fmt:formatNumber value="${hotProductSingle.price}"
                                                                                          pattern="#,###"/>₫</span>
                                            <span class="price-sale">
                                                            <fmt:formatNumber
                                                                    value="${hotProductSingle.price - hotProductSingle.discount / 100 * hotProductSingle.price}"
                                                                    pattern="#,###"/>₫
                                                        </span>
                                        </c:if>

                                        <c:if test="${hotProductSingle.discount == 0}">
                                            <span class="price-sale"><fmt:formatNumber value="${hotProductSingle.price}"
                                                                                       pattern="#,###"/>₫</span>
                                        </c:if>
                                    </p>
                                </div>
                            </div>
                            <div class="bottom-area d-flex px-3">
                                <div class="m-auto d-flex">
                                    <a href="${productSingleURL}-${hotProductSingle.id}"
                                       class="add-to-cart d-flex justify-content-center align-items-center text-center">
                                        <span><i class="ion-ios-menu"></i></span>
                                    </a>

                                    <input id="productId" type="hidden" value="${hotProductSingle.id}"/>
                                    <a href="#"
                                       class="buy-now d-flex justify-content-center align-items-center mx-1"
                                       onclick="checkQuantity(${hotProductSingle.id}, ${hotProductSingle.quantity}, event)">
                                        <span><i class="ion-ios-cart"></i></span>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>

        </div>
    </div>
</section>

<script>
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
</script>
</body>
</html>