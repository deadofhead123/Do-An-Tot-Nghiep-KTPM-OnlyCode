<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="com.javaweb.util.OrderStatusCode"%>
<%@include file="/common/taglib.jsp" %>
<c:url var="productAPI" value="/api/admin/products"/>
<c:url var="orderAPI" value="/api/admin/orders"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Chi tiết đơn hàng</title>
</head>

<body class="g-sidenav-show bg-gray-100">

<c:if test="${not empty messageResponse}">
    <div class="row">
        <div class="col-12 col-xl-5"></div>
        <div class="col-12 col-xl-4">
            <div id="alertResult" class="alert alert-block alert-${alert} text-white w-lg-50 text-xxl-center">
                    ${messageResponse}
            </div>
        </div>
    </div>
</c:if>

<div class="container-fluid px-2 px-md-6">
    <div class="page-header min-height-300 border-radius-xl mt-4"
         style="background-image: url('/web-user/images/bg_1.jpg');">
        <span class="mask bg-gradient-dark  opacity-1"></span>
    </div>

    <div class="card card-body mx-2 mx-md-2 mt-n6">
        <form:form method="get" id="form-edit" name="form-edit" modelAttribute="orderEdit"
                   enctype="multipart/form-data">
            <form:input path="id" type="hidden"/>
            <div class="row gx-4 mb-2">
                <div class="col-auto my-auto">
                    <div class="h-100 align-items-center">
                        <h3 class="mb-1">Chi tiết đơn hàng</h3>
                    </div>
                </div>
            </div>

            <div class="row">
                <h5 class="mb-0">Thông tin giao hàng</h5>
            </div>

            <div class="row">
                <!-- Supplier's information -->
                <div class="col-12 col-xl-12">
                    <div class="card card-plain h-100">
                        <div class="card-body">
                            <div class="form-group" style="font-size: 16px">
                                <span class="text-dark"><strong>Họ tên</strong>: ${orderEdit.userDTO.fullName}</span>
                            </div>

                            <div class="form-group" style="font-size: 16px">
                                <span class="text-dark"><strong>Số điện thoại</strong>: ${orderEdit.userDTO.phoneNumber}</span>
                            </div>

                            <div class="form-group" style="font-size: 16px">
                                <span class="text-dark"><strong>Địa chỉ giao hàng</strong>: ${orderEdit.address}</span>
                            </div>

                            <div class="form-group" style="font-size: 16px">
                                <span class="text-dark"><strong>Phương thức thanh toán</strong>:
                                    <c:forEach var="paymentMethodSingle" items="${paymentMethod}">
                                        <c:if test="${paymentMethodSingle.key == orderEdit.paymentMethod}">
                                            ${paymentMethodSingle.value}
                                        </c:if>
                                    </c:forEach>
                                </span>
                            </div>

                        </div>
                    </div>
                </div>

                <!-- Products -->
                <div class="row pt-xxl-3">
                    <div class="col-12 col-xl-4 align-items-xxl-end">
                        <h5 class="mb-0">Danh sách sản phẩm mua</h5>
                    </div>
                </div>

                <div class="row">
                    <div class="col-12 col-xl-12">
                        <table class="table table-bordered table-striped table-hover text-dark">
                            <tr align="center">
                                <th></th>
                                <th>Ảnh đại diện</th>
                                <th>Tên sản phẩm</th>
                                <th>Số lượng mua</th>
                                <c:if test="${orderEdit.status == 'IN_PROGRESS'}">
                                    <th>Số lượng còn</th>
                                </c:if>
                                <th>Giá mua</th>
                                <th>Thành tiền</th>
                            </tr>

                            <c:forEach var="productOfOrder" items="${productsOfOrder}">
                                <tr id="productOfOrderInfo">
                                    <td class="text-center align-content-xxl-center">
                                        <c:if test="${productOfOrder.productDTO.isActive == 0}">
                                            <span class="text-danger">Đã ngừng bán</span>
                                        </c:if>
                                    </td>

                                    <td class="text-center">
                                        <c:if test="${not empty productOfOrder.productDTO.image}">
                                            <c:set var="imagePath"
                                                   value="/repository${productOfOrder.productDTO.image}"/>
                                            <img src="${imagePath}" id="viewImage" width="100" height="100"
                                                 style="margin-top: 5px; margin-bottom: 5px" alt="Không tìm thấy ảnh">
                                        </c:if>

                                        <c:if test="${empty productOfOrder.productDTO.image}">
                                            <img src="/admin/image/default.png" id="viewImage" width="100" height="100"
                                                 alt="Chưa có ảnh">
                                        </c:if>
                                    </td>

                                    <td class="text-dark align-content-xxl-center">
                                            ${productOfOrder.productDTO.name}
                                    </td>

                                    <td class="text-dark align-content-xxl-center">
                                        <input type="hidden" value="${productOfOrder.quantity}"
                                               id="quantityOfProductInOrder"/>
                                            ${productOfOrder.quantity}
                                    </td>

                                    <input type="hidden" value="${productOfOrder.productDTO.quantity}" id="quantityOfProduct"/>
                                    <c:if test="${orderEdit.status == 'IN_PROGRESS'}">
                                        <td class="text-dark align-content-xxl-center">
                                            <c:if test="${productOfOrder.productDTO.quantity < productOfOrder.quantity}">
                                                <span style="color: red">${productOfOrder.productDTO.quantity} (không đủ giao hàng)</span>
                                            </c:if>
                                            <c:if test="${productOfOrder.productDTO.quantity >= productOfOrder.quantity}">
                                                <span style="color: blue">${productOfOrder.productDTO.quantity}</span>
                                            </c:if>
                                        </td>
                                    </c:if>

                                    <td class="price text-dark align-content-xxl-center">
                                        <fmt:formatNumber value="${productOfOrder.priceInPurchase}" pattern="#,###"/>₫
                                    </td>

                                    <td class="price text-dark align-content-xxl-center">
                                        <fmt:formatNumber
                                                value="${productOfOrder.priceInPurchase * productOfOrder.quantity}"
                                                pattern="#,###"/>₫
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
                    </div>
                </div>

                <div class="row justify-content-xxl-end">
                    <div class="col-12 col-xl-3">
                        <div class="cart-detail cart-total p-3 p-md-4 text-dark">
                            <h5>Tổng chi phí</h5>
                            <p class="d-flex">
                                <span>Tiền hàng</span>
                                <span><fmt:formatNumber value="${orderEdit.total}" pattern="#,###"/> ₫</span>
                                <input type="hidden" value="${orderEdit.total}" id="totalOfOrder" name="totalOfOrder">
                            </p>

                            <p class="d-flex">
                                <span>Giảm giá</span>
                                <span><input id="discount" type="hidden" value="${orderEdit.discount}"/>
                                    <fmt:formatNumber value="${orderEdit.discount}" pattern="#,###"/>₫
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
                            </p>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-12 col-xl-4"></div>
                    <div class="col-12 col-xl-4">
                        <div class="form-group">
                            <label for="status"><span class="text-dark"><strong>Trạng thái:</strong></span></label>
                            <form:select path="status" name="parentId" id="parentId" class="form-select px-2"
                                         style="border: 1px solid black">
                                <form:options items="${statusType}"/>
                            </form:select>
                        </div>

                        <div class="form-group py-1">
                            <label for="note"><strong class="text-dark">Lý do hủy đơn (nếu có)</strong></label>
                            <form:textarea path="note" name="note" id="note"
                                           class="form-control px-2"
                                           rows="8"
                                           style="border: 1px solid black"/>
                        </div>
                    </div>
                </div>

                <div class="row py-3">
                    <div class="col-12 col-xl-5 align-items-xxl-end"></div>
                    <div class="col-12 col-xl-4 align-items-xxl-end">
                        <button type="button" class="btn btn-facebook px-3 py-2 ms-3 align-items-xxl-end"
                                id="btnUpdate">
                            <a class="text-white" href="#">Cập nhật</a>
                        </button>

                        <button type="button" class="btn bg-gradient-faded-dark px-3 py-2 ms-3 align-items-xxl-end">
                            <a class="text-white" href="/admin/order-list">Quay lại</a>
                        </button>
                    </div>
                </div>
            </div>
        </form:form>
    </div>

</div>

<script>
    $(document).ready(function () {
        // Hide alert on head of page
        setTimeout(function () {
            $('#alertResult').hide()
        }, 2000);
    })

    $('#btnUpdate').click(function (event) {
        event.preventDefault();

        var json = {};
        var formData = $('#form-edit').serializeArray();

        $.each(formData, function (idx, it) {
            json["" + it.name + ""] = it.value.trim();
        });

        console.log(json);

        let quantityCheck = 1;
        let quantities = document.querySelectorAll('#productOfOrderInfo');
        quantities.forEach(item => {
            let quantityOfProduct = parseInt(item.querySelector('#quantityOfProduct').value);
            let quantityOfProductInOrder = parseInt(item.querySelector('#quantityOfProductInOrder').value);

            if (quantityOfProduct < quantityOfProductInOrder) {
                quantityCheck = 0;
            }
        });

        if (quantityCheck === 0 && json["status"] === '${OrderStatusCode.DELIVERING.toString()}') {
            alert('Có sản phẩm không đủ số lượng để bán, không thể giao hàng !');
        } else if (json["status"] === '${OrderStatusCode.CANCELED.toString()}' && json["note"] === '') {
            alert('Bạn phải nhập lý do hủy đơn !');
        } else if (confirm('Bạn chắc chắn muốn cập nhật đơn hàng ?')) {
            updateOrder(json);
        }
    });

    function updateOrder(json) {
        $.ajax({
            url: "${orderAPI}",
            method: "PUT",
            data: JSON.stringify(json),
            contentType: "application/json; charset=UTF-8",
            dataType: "JSON",
            success: function (result) {
                console.log(result.data);
                if (result.data === 'update_success') {
                    window.location.href = "<c:url value='/admin/order-edit-${orderEdit.id}?message=update_success'/>";
                }
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