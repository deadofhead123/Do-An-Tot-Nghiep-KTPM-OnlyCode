<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.javaweb.security.utils.SecurityUtils" %>
<%@include file="/common/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Chi tiết sản phẩm</title>
</head>
<body class="goto-here">

<div class="hero-wrap hero-bread" style="background-image: url('/web-user/images/bg_1.jpg');">
    <div class="container">
        <div class="row no-gutters slider-text align-items-center justify-content-center">
            <div class="col-md-9 ftco-animate text-center">
                <p class="breadcrumbs" style="font-size: 14px"><span class="mr-2"><a href="/home">Trang chủ</a></span>
                <h1 class="mb-0 bread">Chi tiết sản phẩm</h1>
            </div>
        </div>
    </div>
</div>

<form:form method="get" modelAttribute="productSingle">
    <section class="ftco-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 mb-5 ftco-animate">
                    <a href="/repository${productSingle.image}" class="image-popup">
                        <img src="/repository${productSingle.image}" width="100%" height="100%" class="img-fluid"
                             alt="Colorlib Template"></a>
                </div>
                <div class="col-lg-6 product-details pl-md-5 ftco-animate">
                    <h3>${productSingle.name}</h3>

                    <!-- Feedback -->
                    <div class="rating d-flex align-items-lg-end">
                        <p class="text-left mr-4">
                            <a href="#" class="mr-2" style="font-size: 18px; color: black"><fmt:formatNumber
                                    value="${finalRating}" pattern="#0"/></a>

                            <c:forEach var="i" begin="1" end="5">
                                <c:choose>
                                    <c:when test="${i <= finalRating}">
                                        <a href="#">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="20"
                                                 height="20"
                                                 fill="currentColor"
                                                 class="bi bi-star star active" viewBox="0 0 16 16">
                                                <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
                                            </svg>
                                        </a>
                                    </c:when>

                                    <c:otherwise>
                                        <a href="#">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="20"
                                                 height="20"
                                                 fill="currentColor"
                                                 class="bi bi-star star" viewBox="0 0 16 16">
                                                <path d="M2.866 14.85c-.078.444.36.791.746.593l4.39-2.256 4.389 2.256c.386.198.824-.149.746-.592l-.83-4.73 3.522-3.356c.33-.314.16-.888-.282-.95l-4.898-.696L8.465.792a.513.513 0 0 0-.927 0L5.354 5.12l-4.898.696c-.441.062-.612.636-.283.95l3.523 3.356-.83 4.73zm4.905-2.767-3.686 1.894.694-3.957a.56.56 0 0 0-.163-.505L1.71 6.745l4.052-.576a.53.53 0 0 0 .393-.288L8 2.223l1.847 3.658a.53.53 0 0 0 .393.288l4.052.575-2.906 2.77a.56.56 0 0 0-.163.506l.694 3.957-3.686-1.894a.5.5 0 0 0-.461 0z"/>
                                            </svg>
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                            &nbsp;
                            <span style="color: black"> (<strong>${numberOfFeedback}</strong> lượt đánh giá)</span>
                        </p>

                        <p class="text-left">
                            <a href="#" class="mr-2" style="color: #000;">
                                <span style="color: red"><strong>${productSingle.sold}</strong>&nbsp;</span>đã bán
                            </a>
                        </p>
                    </div>

                    <!-- Discount -->
                    <c:if test="${productSingle.discount != 0}">
                        <p>
                            <span style="text-decoration: line-through; color: #b3b3b3; font-size: 18px;"><fmt:formatNumber
                                    value="${productSingle.price}" pattern="#,###"/>₫</span>
                        </p>
                    </c:if>

                    <!-- Price -->
                    <p class="price">
                        <span class="text-success"><strong><fmt:formatNumber value="${productSingle.price - productSingle.discount / 100 * productSingle.price}" pattern="#,###"/>₫</strong></span>
                    </p>

                    <p class="text-justify text-dark" style="font-size: 16px; color: black">${productSingle.description}</p>

                    <div class="row mt-4">
                        <div class="col-md-12">
                            <p style="color: #000;">
                                <input type="hidden" id="quantityAvailable" value="${productSingle.quantity}"/>
                                <strong>Tình trạng:</strong>
                                <c:if test="${productSingle.quantity == 0}">
                                     <span style="color: red">Hết hàng</span>
                                </c:if>

                                <c:if test="${productSingle.quantity != 0}">
                                     <span style="color: red">Còn hàng</span>
                                </c:if>
                            </p>
                        </div>
                        <div class="w-100"></div>
                        <div class="input-group col-md-6 d-flex mb-3">
                            <span class="input-group-btn mr-2">
                                <button type="button" class="quantity-left-minus btn" data-type="minus" data-field="">
                                    <i class="ion-ios-remove"></i>
                                </button>
                            </span>

                            <input type="text" id="quantity" name="quantity" class="form-control input-number" value="1"
                                   min="1" max="100">

                            <span class="input-group-btn ml-2">
                                <button type="button" class="quantity-right-plus btn" data-type="plus" data-field="">
                                    <i class="ion-ios-add"></i>
                                </button>
                            </span>
                        </div>
                    </div>
                    <p><a href="#" class="btn btn-black py-3 px-5"
                          onclick="addToCartBtn(${productSingle.id}, event)">Thêm vào giỏ</a></p>
                </div>
            </div>
        </div>
    </section>
</form:form>

<section class="ftco-section">
    <!-- Related product (maybe relate about category) -->
    <div class="container">
        <div class="row justify-content-center mb-3 pb-3">
            <div class="col-md-12 heading-section text-center ftco-animate">
                <h2 class="mb-4">Sản phẩm liên quan</h2>
            </div>
        </div>
    </div>

    <div class="container">
        <div id="" class="row">
            <c:forEach var="relatedProductSingle" items="${relatedProducts}">
                <div class="col-md-6 col-lg-3 ftco-animate">
                    <div class="product">
                        <a href="/product-single-${relatedProductSingle.id}" class="img-prod"><img class="img-fluid"
                                                                                                   src="/repository${relatedProductSingle.image}"
                                                                                                   alt="Colorlib Template">
                            <c:if test="${relatedProductSingle.discount != 0}">
                                <span class="status"><fmt:formatNumber value="${relatedProductSingle.discount}"
                                                                       pattern="#0"/> %</span>
                            </c:if>
                            <div class="overlay"></div>
                        </a>

                        <div class="text py-3 pb-4 px-3 text-center">
                            <h3><a href="#">${relatedProductSingle.name}</a></h3>

                            <!-- Price and price with discount -->
                            <div class="d-flex">
                                <div class="pricing">
                                    <p class="price">
                                        <c:if test="${relatedProductSingle.discount != 0}">
                                            <span class="mr-2 price-dc"><fmt:formatNumber
                                                    value="${relatedProductSingle.price}"
                                                    pattern="#,###"/>₫</span>
                                            <span class="price-sale">
                                                <fmt:formatNumber
                                                        value="${relatedProductSingle.price - relatedProductSingle.discount / 100 * relatedProductSingle.price}"
                                                        pattern="#,###"/>₫
                                                </span>
                                        </c:if>
                                        <c:if test="${relatedProductSingle.discount == 0}">
                                            <span class="price-sale"><fmt:formatNumber
                                                    value="${relatedProductSingle.price}"
                                                    pattern="#,###"/>₫</span>
                                        </c:if>
                                    </p>
                                </div>
                            </div>

                            <!-- Buttons -->
                            <div class="bottom-area d-flex px-3">
                                <div class="m-auto d-flex">
                                    <a href="/product-single-${relatedProductSingle.id}"
                                       class="add-to-cart d-flex justify-content-center align-items-center text-center">
                                        <span><i class="ion-ios-menu"></i></span>
                                    </a>

                                    <input id="productId" type="hidden" value="${relatedProductSingle.id}"/>
                                    <a href="#" class="buy-now d-flex justify-content-center align-items-center mx-1"
                                       onclick="checkQuantity(${relatedProductSingle.id}, ${relatedProductSingle.quantity}, event)">
                                        <span><i class="ion-ios-cart"></i></span>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- Feedback -->
        <div class="pt-5 mt-5">
            <div class="container">
                <div class="row justify-content-center mb-3 pb-3">
                    <div class="col-md-12 heading-section text-center ftco-animate">
                        <h2 class="mb-4">Đánh giá</h2>
                    </div>
                </div>
            </div>

            <!-- Feedback list -->
            <div id="feedbackList">

            </div>

            <div class="justify-content-center">
                <a id="showMoreFeedback" href="#">Hiển thị thêm</a>
                <a id="hideFeedback" href="#">Ẩn bớt</a>
            </div>
            <!-- END feedback list -->

            <!-- Leave feedback -->
            <div class="comment-form-wrap pt-5">
                <security:authorize access="isAuthenticated()">
                    <c:set var="roleName" value="<%=SecurityUtils.getAuthorities().get(0)%>"/>
                    <c:choose>
                        <c:when test="${roleName == 'ROLE_USER'}">
                            <form id="form-feedback" name="form-feedback" class="p-5 bg-light">
                                <!-- Choose number of star -->
                                <div class="form-group">
                                    <div class="rating-container">
                                        <label><span class="text-dark"
                                                     style="font-size: 18px;">Điểm đánh giá: &nbsp;</span></label>

                                        <c:forEach var="i" begin="1" end="5">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20"
                                                 fill="currentColor"
                                                 class="bi bi-star star" viewBox="0 0 16 16" data-value="${i}"
                                                 id="starFeedback">
                                                <path d="M2.866 14.85c-.078.444.36.791.746.593l4.39-2.256 4.389 2.256c.386.198.824-.149.746-.592l-.83-4.73 3.522-3.356c.33-.314.16-.888-.282-.95l-4.898-.696L8.465.792a.513.513 0 0 0-.927 0L5.354 5.12l-4.898.696c-.441.062-.612.636-.283.95l3.523 3.356-.83 4.73zm4.905-2.767-3.686 1.894.694-3.957a.56.56 0 0 0-.163-.505L1.71 6.745l4.052-.576a.53.53 0 0 0 .393-.288L8 2.223l1.847 3.658a.53.53 0 0 0 .393.288l4.052.575-2.906 2.77a.56.56 0 0 0-.163.506l.694 3.957-3.686-1.894a.5.5 0 0 0-.461 0z"/>
                                            </svg>
                                        </c:forEach>
                                        <input id="rating" name="rating" type="number"
                                               style="width: 35px;">&nbsp;&nbsp;<span class="text-dark">sao</span>
                                    </div>
                                </div>

                                <!-- Content -->
                                <div class="form-group">
                                    <label for="content"><span class="text-dark"
                                                               style="font-size: 18px;">Nội dung: </span></label>
                                    <textarea id="content" name="content" cols="30" rows="10"
                                              class="form-control text-dark"
                                              placeholder="Vui lòng nhập tiếng Việt có dấu"></textarea>
                                </div>

                                <div class="form-group">
                                    <input id="btnSendFeedback" type="button" value="Gửi đánh giá"
                                           class="btn btn-primary py-3 px-4">
                                </div>
                            </form>
                        </c:when>

                        <c:otherwise>
                            <h4 class="text-dark">Bạn cần đăng nhập với tài khoản của người dùng thường để bình
                                luận</h4>
                        </c:otherwise>
                    </c:choose>
                </security:authorize>
                <security:authorize access="isAnonymous()">
                    <h4 class="text-dark">Bạn cần đăng nhập với tài khoản của người dùng thường để bình luận</h4>
                </security:authorize>
            </div>
        </div>
    </div>
</section>

<script>
    <c:set var="cartAPI" value="/api/carts"/>
    <c:set var="feedbackAPI" value="/api/feedback"/>

    $(document).ready(function () {
        var quantitiy = 0;
        $('.quantity-right-plus').click(function (e) {
            // Stop acting like a button
            e.preventDefault();

            // Get the field name
            var quantity = parseInt($('#quantity').val());

            // If is not undefined

            // Increment
            $('#quantity').val(quantity + 1);
        });

        $('.quantity-left-minus').click(function (e) {
            // Stop acting like a button
            e.preventDefault();

            // Get the field name
            var quantity = parseInt($('#quantity').val());

            // If is not undefined

            // Increment
            if (quantity > 0) {
                $('#quantity').val(quantity - 1);
            }
        });

        $('#btnSendFeedback').click(function () {
            $('#form-feedback').submit();
        });

        document.getElementById('showMoreFeedback').style.display = 'none';
        document.getElementById('hideFeedback').style.display = 'none';

        getFeedback();
    });


    //------------------- Add to cart
    function addToCartBtn(productId, event) {
        event.preventDefault();

        let quantityAvailable = $('#quantityAvailable').val();
        let quantityAdd = $('#quantity').val();

        if (quantityAvailable < 1) {
            alert('Sản phẩm này đã hết hàng !');
        } else if (quantityAdd < 1) {
            alert('Số lượng thêm vào giỏ phải lớn hơn 0 !');
        } else {
            addToCart(productId, quantityAdd);
        }
    }

    function checkQuantity(productId, quantity, event) {
        event.preventDefault();

        if (quantity < 1) {
            alert('Sản phẩm này đã hết hàng !');
        } else {
            addToCart(productId, 1)
        }
    }

    function addToCart(productId, quantity) {
        $.ajax({
            url: "${cartAPI}",
            method: "POST",
            data: JSON.stringify({id: productId, quantity: quantity}),
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


    //------------------- Star in comment post
    let numberOfStarFeedback = document.getElementById('numberOfStarFeedback');
    let starsOfFeedback = document.querySelectorAll('#starFeedback');
    let currentNumberOfStar = 0;

    starsOfFeedback.forEach(item => {
        item.addEventListener('mouseover', function () {
            // Calculate star highlighted, show number of star
            let valueOfStar = parseInt(this.dataset.value);
            calculateStar(valueOfStar, 'hover');
            $('#rating').val(valueOfStar);
        });

        item.addEventListener('mouseout', function () {
            // Calculate star highlighted, show number of star
            calculateStar(currentNumberOfStar, 'active');

            let rating = currentNumberOfStar > 0 ? currentNumberOfStar : 0;
            $('#rating').val(rating);
        });

        item.addEventListener('click', function () {
            // Calculate star highlighted, show number of star
            let valueOfStar = parseInt(this.dataset.value);
            currentNumberOfStar = valueOfStar;
            $('#rating').val(parseInt(currentNumberOfStar));

            calculateStar(valueOfStar, 'active');
        });
    });

    function calculateStar(valueOfStar, className) {
        starsOfFeedback.forEach(item => {
            let valueOfItem = parseInt(item.dataset.value);
            if (valueOfItem <= valueOfStar) {
                item.classList.add(className);
            } else {
                item.classList.remove(className);
            }
            if (className === 'hover') {
                item.classList.remove('active'); // Đảm bảo không còn class active khi hover
            } else if (className === 'active') {
                item.classList.remove('hover'); // Đảm bảo không còn class hover khi đã click
            }
        });
    }

    // Khởi tạo trạng thái ban đầu (nếu đã có đánh giá trước đó)
    if (currentNumberOfStar > 0) {
        $('#rating').val(parseInt(currentNumberOfStar));
        calculateStar(currentNumberOfStar, 'active');
    }

    $(function () {
        $("form[name='form-feedback']").validate({
            rules: {
                rating: {
                    required: true,
                    min: 1
                },
                content: {
                    required: true
                }
            },
            messages: {
                rating: {
                    required: "<br><span style='color: red'>Phải chọn điểm đánh giá!</span>",
                    min: "<br><span style='color: red'>Số sao phải lớn hơn 1!</span>"
                },
                content: {
                    required: "<span style='color: red'>Phải nhập nội dung đánh giá!</span>"
                }
            },
            submitHandler: function () {
                var json = {};
                var formData = $('#form-feedback').serializeArray();

                $.each(formData, function (idx, it) {
                    json["" + it.name + ""] = it.value.trim();
                });
                json["productId"] = ${productSingle.id};

                console.log(json);

                if (confirm('Bạn chắc chắn muốn gửi đánh giá về sản phẩm này?')) {
                    createFeedback(json);
                }
            }
        });
    });

    function createFeedback(json) {
        $.ajax({
            url: "${feedbackAPI}",
            method: "POST",
            data: JSON.stringify(json),
            contentType: "application/json; charset=UTF-8",
            dataType: "JSON",
            success: function (result) {
                console.log(result.data);
                alert(result.message);
                location.reload();
            },
            error: function (result) {
                console.log(result);

                let message = result.responseJSON.message;

                $.each(result.responseJSON.details, function (idx, it) {
                    message += it + '\n';
                });

                alert(message);
            }
        });
    }


    //---------- Show more feedback
    <c:set var="productIdParam" value="productId"/>
    <c:set var="sizeParam" value="size"/>
    const defaultNumberOfFeedbackShown = 3;
    const numberOfFeedbackAdd = 3;
    const numberOfFeedbackHide = 3;
    let numberOfFeedbackShown = defaultNumberOfFeedbackShown;
    const maxNumberOfFeedback = ${numberOfFeedback};

    $('#showMoreFeedback').click(function (event) {
        event.preventDefault();

        numberOfFeedbackShown = (numberOfFeedbackShown + numberOfFeedbackAdd <= maxNumberOfFeedback) ? numberOfFeedbackShown + numberOfFeedbackAdd : numberOfFeedbackShown + (maxNumberOfFeedback - numberOfFeedbackShown);

        getFeedback();
    });

    $('#hideFeedback').click(function (event) {
        event.preventDefault();

        numberOfFeedbackShown = (numberOfFeedbackShown - numberOfFeedbackHide >= defaultNumberOfFeedbackShown) ? numberOfFeedbackShown - numberOfFeedbackHide : defaultNumberOfFeedbackShown;

        getFeedback();
    });

    function getFeedback() {
        $.ajax({
            url: "${feedbackAPI}?${productIdParam}=" + ${productSingle.id} +"&${sizeParam}=" + numberOfFeedbackShown,
            method: "GET",
            contentType: "application/json; charset=UTF-8",
            dataType: "JSON",
            success: function (result) {
                console.log(result.data);

                let allFeedback = result.data;

                let row = "";

                if (allFeedback.length === 0) row = "<h3 class='mb-5'>Chưa có đánh giá nào.</h3>";
                else {
                    row = "<h3 class='mb-4'>" + maxNumberOfFeedback + " đánh giá</h3>" + "<ul class='comment-list d-lg-block'>";

                    $.each(allFeedback, function (idx, it) {
                        let formatter = new Intl.DateTimeFormat('vi-VN', {
                            hour: "2-digit",
                            minute: "2-digit",
                            day: "2-digit",
                            month: "2-digit",
                            year: "numeric",
                            hour12: false
                        });
                        let createdAt = formatter.format(new Date(it.createdAt));
                        let rating = it.rating;

                        row += "<li class='comment' style='border-bottom: 1px solid black'>" +
                            "<div class='comment-body'>" +
                            "<h4>" + it.userDTO.fullName + "</h4>" +
                            "<div class='meta'>" +
                            "<span class='text-dark'>" +
                            "<span class='icon-calendar'></span>&nbsp;" + createdAt +
                            "</span>" +
                            "<div class='rating d-flex'>" +
                            "<p class='text-left mr-4'>" +
                            "<a href='#' class='mr-2 text-dark' style='font-size: 18px'>" + rating + "</a>";

                        for (let i = 1; i <= 5; i++) {
                            if (i <= rating) {
                                row += "<a href='#'>" +
                                    "<svg xmlns='http://www.w3.org/2000/svg' width='20' height='20' fill='currentColor' " +
                                    "class='bi bi-star star active' viewBox='0 0 16 16'>" +
                                    "<path d='M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z'/>" +
                                    "</svg>" +
                                    "</a>";
                            } else {
                                row += "<a href='#'>" +
                                    "<svg xmlns='http://www.w3.org/2000/svg' width='20' height='20' fill='currentColor' " +
                                    "class='bi bi-star star' viewBox='0 0 16 16'>" +
                                    "<path d='M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z'/>" +
                                    "</svg>" +
                                    "</a>";
                            }
                        }

                        row += "</p>" +
                            "</div>" +
                            "</div>" +
                            "<p class='text-dark'>" + it.content + "</p>" +
                            "</div>" +
                            "</li>";
                    });

                    row += "</ul>";

                    // Show or hide "show more feedback" and "hide feedback"
                    if (numberOfFeedbackShown < maxNumberOfFeedback) {
                        document.getElementById('showMoreFeedback').style.display = 'block';
                    } else {
                        document.getElementById('showMoreFeedback').style.display = 'none';
                    }

                    if (numberOfFeedbackShown > defaultNumberOfFeedbackShown) {
                        document.getElementById('hideFeedback').style.display = 'block';
                    } else {
                        document.getElementById('hideFeedback').style.display = 'none';
                    }
                }

                document.getElementById('feedbackList').innerHTML = row;
            },
            error: function (result) {
                console.log(result);

                let message = result.responseJSON.message;

                $.each(result.responseJSON.details, function (idx, it) {
                    message += it + '\n';
                });

                alert(message);
            }
        });
    }
</script>

</body>
</html>