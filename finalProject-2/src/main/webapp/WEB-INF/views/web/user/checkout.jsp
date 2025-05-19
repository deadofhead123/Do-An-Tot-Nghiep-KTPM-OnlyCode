<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Thanh toán</title>

    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body class="goto-here">

<div class="hero-wrap hero-bread" style="background-image: url('web-user/images/bg_1.jpg');">
    <div class="container">
        <div class="row no-gutters slider-text align-items-center justify-content-center">
            <div class="col-md-9 ftco-animate text-center">
                <p class="breadcrumbs"><span class="mr-2"><a href="/home">Trang chủ</a></span></p>
                <h1 class="mb-0 bread">Thanh toán</h1>
            </div>
        </div>
    </div>
</div>

<section class="ftco-section">
    <div class="container">
        <form:form modelAttribute="userInfo" id="form-order" name="form-order" class="billing-form">
            <div class="row justify-content-center">
                <div class="col-xl-7 ftco-animate text-dark">
                    <h3 class="mb-4 billing-heading">Thông tin hóa đơn</h3>
                    <div class="row align-items-end">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="email">Email</label>
                                <form:input path="email" type="text" class="form-control" placeholder="" id="email"
                                            name="email" style="color: black" readonly="true"/>
                            </div>
                        </div>

                        <div class="w-100"></div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="fullName">Họ tên</label>
                                <form:input path="fullName" id="fullName" name="fullName" type="text"
                                            class="form-control" placeholder="" style="color: black" readonly="true"/>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="phone">Số điện thoại</label>
                                <form:input path="phoneNumber" type="text" class="form-control" placeholder=""
                                            id="phone" name="phone" readonly="true"/>
                            </div>
                        </div>

                        <div class="col-md-12">
                            <div class="form-group">
                                <label for="address">Địa chỉ giao hàng</label>
                                <form:input path="address" type="text" class="form-control" placeholder="" id="address"
                                            name="address" style="color: black"/>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-xl-5">
                    <div class="row mt-5 pt-3">
                        <div class="col-md-12 d-flex mb-5">
                            <div class="cart-detail cart-total p-3 p-md-4 text-dark">
                                <h3>Thông tin giỏ hàng</h3>
                                <p class="d-flex">
                                    <span>Tiền hàng</span>
                                    <span><fmt:formatNumber value="${totalOfOrder}" pattern="#,###"/> ₫</span>
                                    <input type="hidden" value="${totalOfOrder}" id="totalOfOrder" name="totalOfOrder">
                                </p>

                                <p class="d-flex">
                                    <span>Giảm giá</span>
                                    <span><input id="discount" type="hidden" value="${discount}"/>
                                    <fmt:formatNumber value="${discount}" pattern="#,###"/>₫
                                    </span>
                                </p>

                                <hr>
                                <p class="d-flex total-price">
                                    <span>Tổng tiền</span>
                                    <span>
                                        <script>
                                            document.write(($('#totalOfOrder').val() - $('#discount').val()).toLocaleString())
                                        </script>
                                        ₫
                                    </span>
                                    <input type="hidden" value="${totalOfOrder}" id="finalTotalOfOrder"
                                           name="finalTotalOfOrder">
                                </p>
                            </div>
                        </div>

                        <div class="col-md-12">
                            <div class="cart-detail p-3 p-md-4">
                                <h3 class="billing-heading mb-4">Phương thức thanh toán</h3>
                                <c:forEach var="payment" items="${paymentMethod}">
                                    <div class="form-group">
                                        <div class="col-md-12">
                                            <div class="radio">
                                                <label class="text-dark">
                                                    <input type="radio" id="paymentMethod" name="optradio"
                                                           value="${payment.key}" class="mr-2" checked="checked">
                                                        ${payment.value}
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                                <p>
                                    <button type="button" class="btn btn-primary py-3 px-4" id="btnOrder">Đặt hàng
                                    </button>
                                </p>
                                <br>

                            </div>
                        </div>
                    </div>
                </div> <!-- .col-md-8 -->
            </div>
        </form:form><!-- END -->
    </div>
</section> <!-- .section -->


<!-- Modal HTML -->
<div id="myModal" class="modal fade">
    <div class="modal-dialog modal-confirm">
        <div class="modal-content">
            <div class="modal-header justify-content-lg-center">
                <div class="icon-box">
                    <svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" fill="currentColor"
                         class="bi bi-check2" viewBox="0 0 16 16">
                        <path d="M13.854 3.646a.5.5 0 0 1 0 .708l-7 7a.5.5 0 0 1-.708 0l-3.5-3.5a.5.5 0 1 1 .708-.708L6.5 10.293l6.646-6.647a.5.5 0 0 1 .708 0"/>
                    </svg>
                </div>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body text-center">
                <h4>Chúc mừng!</h4>
                <p>Bạn đã đặt hàng thành công.</p>
                <button class="btn btn-success" id="btnOrderSuccess">
                    <span>Tiếp tục mua sắm</span>
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor"
                         class="bi bi-arrow-right" viewBox="0 0 16 16">
                        <path fill-rule="evenodd"
                              d="M1 8a.5.5 0 0 1 .5-.5h11.793l-3.147-3.146a.5.5 0 0 1 .708-.708l4 4a.5.5 0 0 1 0 .708l-4 4a.5.5 0 0 1-.708-.708L13.293 8.5H1.5A.5.5 0 0 1 1 8"/>
                    </svg>
                </button>
                <br>
                <br>
                <p>Trở về trang chủ sau <span id="secondsBackToHome"></span> giây.</p>
                <%--                <div id="timer" class="d-flex mt-5">--%>
                <%--                    <div class="time pl-3" id="secondsToHome"></div>--%>
                <%--                </div>--%>
            </div>
        </div>
    </div>
</div>

<script>
    <c:set var="orderAPI" value="/api/orders"/>

    //----- Reference: /static/web-user/js/main.js

    $(document).ready(function () {
        $('#btnOrder').click(function (event) {
            $('#form-order').submit();
        });
    });

    $(function () {
        $("form[name='form-order']").validate({
            rules: {
                fullName: {
                    required: true
                },
                phoneNumber: {
                    required: true
                },
                address: {
                    required: true
                }
            },
            messages: {
                fullName: {
                    required: "<span style='color: red'>Bạn hãy cập nhật họ tên cho tài khoản !</span>"
                },
                phoneNumber: {
                    required: "<span style='color: red'>Bạn hãy cập nhật số điện thoại cho tài khoản !</span>"
                },
                address: {
                    required: "<span style='color: red'>Phải nhập địa chỉ giao hàng !</span>"
                }
            },
            submitHandler: function () {
                let json = {};
                json["address"] = $('#address').val();
                json["totalOfOrder"] = $('#finalTotalOfOrder').val()
                json["paymentMethod"] = $('#paymentMethod:checked').val()

                if (confirm('Xác nhận thông tin đặt hàng là chính xác?')) {
                    order(json);
                }
            }
        });
    });

    let secondsBack = 5;

    function makeTimer() {
        $('#secondsBackToHome').html(secondsBack);

        secondsBack--;

        if (secondsBack < 1) {
            window.location.href = "/home";
        }
    }

    function order(json) {
        $.ajax({
            url: "${orderAPI}",
            method: "POST",
            data: JSON.stringify(json),
            contentType: "application/json; charset=UTF-8",
            dataType: "JSON",
            success: function (result) {
                setInterval(function () {
                    makeTimer();
                }, 1000);

                $('#myModal').modal();
            },
            error: function (result) {
                alert(result.responseJSON.message);
            }
        });
    }

    $('#btnOrderSuccess').click(function () {
        location.replace("/shop");
    });
</script>

</body>
</html>