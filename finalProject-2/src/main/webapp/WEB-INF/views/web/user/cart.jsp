<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<c:url var="productSingleURL" value="/product-single"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Giỏ hàng</title>
</head>
<body class="goto-here">

<div class="hero-wrap hero-bread" style="background-image: url('web-user/images/bg_1.jpg');">
    <div class="container">
        <div class="row no-gutters slider-text align-items-center justify-content-center">
            <div class="col-md-9 ftco-animate text-center">
                <p class="breadcrumbs"><span class="mr-2"><a href="/home">Trang chủ</a></span></p>
                <h1 class="mb-0 bread">Giỏ hàng</h1>
            </div>
        </div>
    </div>
</div>

<section class="ftco-section ftco-cart">
    <div class="container">
        <div class="row">
            <div class="col-md-12 ftco-animate">
                <c:if test="${carts.size() == 0}">
                    <h3>Chưa có sản phẩm nào trong giỏ.</h3>
                </c:if>

                <c:if test="${carts.size() != 0}">
                    <h3>Các sản phẩm có trong giỏ:</h3>
                    <div class="justify-content-lg-end py-2" align="right">
                        <button type="button"
                                class="btn btn-danger px-4 py-2 ms-3"
                                id="btnDeleteGroup"
                                title="Xóa các sản phẩm đã chọn trong giỏ hàng">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="white"
                                 class="bi bi-x-lg" viewBox="0 0 16 16">
                                <path d="M2.146 2.854a.5.5 0 1 1 .708-.708L8 7.293l5.146-5.147a.5.5 0 0 1 .708.708L8.707 8l5.147 5.146a.5.5 0 0 1-.708.708L8 8.707l-5.146 5.147a.5.5 0 0 1-.708-.708L7.293 8z"/>
                            </svg>
                            <span style="color: white">Xóa hết</span>
                        </button>
                    </div>

                    <div class="cart-list">
                        <div class="table-container">
                            <table id="productTable" class="table">
                                <thead class="thead-primary">
                                <tr class="text-center">
                                    <th><input type="checkbox" id="checkAllInCart"/></th>
                                    <th>Ảnh đại diện</th>
                                    <th>Tên sản phẩm</th>
                                    <th>Giá bán</th>
                                    <th>Số lượng mua</th>
                                    <th>Thành tiền</th>
                                    <th>&nbsp;</th>
                                </tr>
                                </thead>

                                <tbody>
                                <c:forEach var="cartSingle" items="${carts}">
                                    <tr id="product-info" class="text-center">
                                        <td>
                                            <fieldset class='input-group'>
                                                <input type="checkbox" id="productId"
                                                       value="${cartSingle.productDTO.id}"/>
                                            </fieldset>
                                        </td>

                                        <td class="image-prod">
                                            <div class="img">
                                                <c:if test="${not empty cartSingle.productDTO.image}">
                                                    <c:set var="imagePath"
                                                           value="/repository${cartSingle.productDTO.image}"/>
                                                    <a href="${productSingleURL}-${cartSingle.productDTO.id}">
                                                        <img src="${imagePath}" id="viewImage" width="100"
                                                             height="100"
                                                             style="margin-top: 5px; margin-bottom: 5px"
                                                             alt="Không tìm thấy ảnh"></a>
                                                </c:if>

                                                <c:if test="${empty cartSingle.productDTO.image}">
                                                    <img src="/admin/image/default.png" id="viewImage"
                                                         width="100" height="100"
                                                         alt="Chưa có ảnh">
                                                </c:if>
                                            </div>
                                        </td>

                                        <td class="product-name">
                                            <h3>${cartSingle.productDTO.name}</h3>
                                        </td>

                                        <td class="price">
                                            <c:set var="priceWithDiscount"
                                                   value="${cartSingle.productDTO.price - cartSingle.productDTO.price * cartSingle.productDTO.discount / 100}"/>
                                            <input type="hidden" id="price" value="${priceWithDiscount}"/>
                                            <fmt:formatNumber value="${priceWithDiscount}" pattern="#,###"/>₫
                                        </td>

                                        <td class="quantity">
                                            <div class="input-group mb-3">
                                            <span class="input-group-btn mr-2">
                                                    <button type="button" id="quantity-left-minus"
                                                            class="quantity-left-minus btn" data-type="minus"
                                                            data-field="">
                                                        <i class="ion-ios-remove"></i>
                                                    </button>
                                            </span>

                                                <input type="number" id="quantity" name="quantity"
                                                       class="quantity form-control input-number"
                                                       value="${cartSingle.quantity}" min="1">

                                                <span class="input-group-btn ml-2">
                                                <button type="button" id="quantity-right-plus"
                                                        class="quantity-right-plus btn" data-type="plus"
                                                        data-field="">
                                                    <i class="ion-ios-add"></i>
                                                </button>
                                            </span>
                                            </div>
                                        </td>

                                        <td id="subTotal" class="total"><fmt:formatNumber
                                                value="${priceWithDiscount * cartSingle.quantity}"
                                                pattern="#,###"/>₫
                                        </td>

                                        <td class="product-remove"><a href="#" title="Xóa sản phẩm khỏi giỏ"
                                                                      onclick="deleteSingle(${cartSingle.productDTO.id})"><span
                                                class="ion-ios-close"></span></a></td>
                                    </tr>
                                    <!-- END TR-->
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>

        <div class="row justify-content-end">
            <%--            <div class="col-lg-4 mt-5 cart-wrap ftco-animate">--%>
            <%--                <div class="cart-total mb-3">--%>
            <%--                    <h3>Mã giảm giá</h3>--%>
            <%--                    <p>Nhập mã giảm giá của bạn</p>--%>
            <%--                    <form action="#" class="info">--%>
            <%--                        <div class="form-group">--%>
            <%--                            <input type="text" class="form-control text-left px-3" placeholder="">--%>
            <%--                        </div>--%>
            <%--                    </form>--%>
            <%--                </div>--%>
            <%--                <p><a href="checkout.html" class="btn btn-primary py-3 px-4">Áp dụng</a></p>--%>
            <%--            </div>--%>

            <script>
                function calculateTotalOfCart() {
                    const products = document.querySelectorAll('#product-info');
                    let total = 0;

                    products.forEach(item => {
                        let quantity = item.querySelector('#quantity').value;
                        let price = item.querySelector('#price').value;
                        total += quantity * price;
                    });

                    return total;
                }
            </script>

            <c:if test="${carts.size() != 0}">
                <div class="col-lg-4 mt-5 cart-wrap ftco-animate">
                    <div class="cart-detail cart-total mb-3">
                        <h3>Thông tin giỏ hàng</h3>
                        <p class="d-flex text-dark">
                            <span>Tiền hàng</span>
                            <span id="totalOfProduct">
                                <script>
                                    document.write(calculateTotalOfCart().toLocaleString() + "₫");
                                </script>
                            </span>
                        </p>

                        <p class="d-flex text-dark">
                            <span>Giảm giá</span>
                            <span>
                                <input id="discount" type="hidden" value="${discount}"/>
                                <fmt:formatNumber value="${discount}" pattern="#,###"/>₫
                            </span>
                        </p>

                        <hr>
                        <p class="d-flex total-price text-dark">
                            <span>Tổng tiền</span>
                            <span id="totalOfCart">
                                <script>
                                    document.write((calculateTotalOfCart() - $('#discount').val()).toLocaleString() + "₫");
                                </script>
                            </span>
                        </p>
                    </div>

                    <p><a href="#" class="btn btn-primary py-3 px-4" id="btnCheckout">Xác nhận thanh toán</a></p>
                </div>
            </c:if>
        </div>
    </div>
</section>

<script>
    <c:set var="cartAPI" value="/api/carts"/>

    function openImage(input, imageView) {
        if (input.files && input.files[0]) {
            let reader = new FileReader();
            reader.onload = function (e) {
                $('#' + imageView).attr('src', reader.result);
            }
            reader.readAsDataURL(input.files[0]);
        }
    }

    $('#checkAllInCart').change(function () {
        if (this.checked) {
            document.querySelectorAll('#productId').forEach(item => {
                item.setAttribute('checked', 'checked');
            });
        } else {
            document.querySelectorAll('#productId').forEach(item => {
                item.removeAttribute('checked');
            });
        }
    });

    const quantityMinusButtons = document.querySelectorAll('#quantity-left-minus');
    quantityMinusButtons.forEach(item => {
        item.onclick = function () {
            const row = this.parentElement.parentElement.parentElement.parentElement;

            let productId = row.querySelector('#productId').value;
            let quantityAfter = parseInt(row.querySelector('#quantity').value) - 1;
            let price = row.querySelector('#price').value;

            if (quantityAfter > 0) {
                $.ajax({
                    url: "${cartAPI}" + "?productId=" + productId + "&quantity=" + quantityAfter,
                    method: "PATCH",
                    contentType: "application/json; charset=UTF-8",
                    dataType: "JSON",
                    success: function (result) {
                        let total = quantityAfter * price;
                        row.querySelector('#quantity').value = quantityAfter;
                        row.querySelector('#subTotal').textContent = total.toLocaleString();

                        document.getElementById('totalOfProduct').textContent = calculateTotalOfCart().toLocaleString() + "₫";
                        document.getElementById('totalOfCart').textContent = (calculateTotalOfCart() - $('#discount').val()).toLocaleString() + "₫";
                    },
                    error: function (result) {
                        alert(result.responseJSON.message);
                    }
                });
            }
        }
    });

    const quantityPlusButtons = document.querySelectorAll('#quantity-right-plus');
    quantityPlusButtons.forEach(item => {
        item.onclick = function () {
            const row = this.parentElement.parentElement.parentElement.parentElement;

            let productId = row.querySelector('#productId').value;
            let quantityAfter = parseInt(row.querySelector('#quantity').value) + 1;
            let price = row.querySelector('#price').value;

            console.log(quantityAfter);

            if (quantityAfter > 0) {
                $.ajax({
                    url: "${cartAPI}" + "?productId=" + productId + "&quantity=" + quantityAfter,
                    method: "PATCH",
                    contentType: "application/json; charset=UTF-8",
                    dataType: "JSON",
                    success: function (result) {
                        let total = quantityAfter * price;
                        row.querySelector('#quantity').value = quantityAfter;
                        row.querySelector('#subTotal').textContent = total.toLocaleString();

                        document.getElementById('totalOfProduct').textContent = calculateTotalOfCart().toLocaleString() + "₫";
                        document.getElementById('totalOfCart').textContent = (calculateTotalOfCart() - $('#discount').val()).toLocaleString() + "₫";
                    },
                    error: function (result) {
                        alert(result.responseJSON.message);
                    }
                });
            }
        }
    });

    const quantityInputs = document.querySelectorAll('#quantity');
    quantityInputs.forEach(item => {
        item.addEventListener('keyup', function () {
            const row = this.parentElement.parentElement.parentElement;

            let productId = row.querySelector('#productId').value;
            let quantityAfter = row.querySelector('#quantity').value;
            let price = row.querySelector('#price').value;

            if (quantityAfter > 0) {
                $.ajax({
                    url: "${cartAPI}" + "?productId=" + productId + "&quantity=" + quantityAfter,
                    method: "PATCH",
                    contentType: "application/json; charset=UTF-8",
                    dataType: "JSON",
                    success: function (result) {
                        let total = quantityAfter * price;
                        row.querySelector('#subTotal').textContent = total.toLocaleString();

                        document.getElementById('totalOfProduct').textContent = calculateTotalOfCart().toLocaleString() + "₫";
                        document.getElementById('totalOfCart').textContent = (calculateTotalOfCart() - $('#discount').val()).toLocaleString() + "₫";
                    },
                    error: function (result) {
                        alert(result.responseJSON.message);
                    }
                });
            }
        });
    });


    // ---------- Delete product
    function deleteSingle(productId) {
        if (confirm('Bạn chắc chắn muốn xóa sản phẩm này khỏi giỏ?')) {
            deleteProduct(productId);
        }
    }

    $('#btnDeleteGroup').click(function () {
        let productIds = $('#productTable').find('tbody input[type=checkbox]:checked').map(function () {
            return $(this).val();
        }).get();

        if (productIds.length < 1) {
            alert('Bạn chưa chọn sản phẩm để xóa!');
        } else if (confirm('Bạn chắc chắn muốn xóa các sản phẩm được chọn?')) {
            deleteProduct(productIds);
        }
    });

    function deleteProduct(productIds) {
        $.ajax({
            url: "${cartAPI}" + "/" + productIds,
            method: "DELETE",
            contentType: "application/json; charset=UTF-8",
            dataType: "JSON",
            success: function (result) {
                alert(result.message);
                location.reload();
            },
            error: function (result) {
                alert(result.responseJSON.message);
            }
        });
    }

    $('#btnCheckout').click(function (event) {
        event.preventDefault();

        let sizeOfCart = 0;
        let quantities = document.querySelectorAll('#quantity');
        quantities.forEach(item => {
            sizeOfCart += item.value;
        });

        if (sizeOfCart < 1) {
            alert('Chưa có sản phẩm nào trong giỏ, không thể thanh toán');
        } else {
            window.location.href = "/checkout";
        }
    });
</script>

</body>
</html>