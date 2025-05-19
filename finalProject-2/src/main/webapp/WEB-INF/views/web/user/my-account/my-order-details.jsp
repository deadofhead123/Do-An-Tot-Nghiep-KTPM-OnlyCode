<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.javaweb.util.OrderStatusCode" %>
<%@include file="/common/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Tài khoản</title>

</head>

<body>
<h2>Chi tiết đơn hàng <span style="background-color: orange">#${orderInfo.id}</span></h2>

<div class="myaccount__body">
    <div class="form-group text-dark" style="font-size: 16px">
        <c:choose>
            <c:when test="${orderInfo.status == OrderStatusCode.CANCELED.toString()}">
                <h4>Đơn hàng này bị <span style="color: red">hủy</span> vì lý do:</h4>
                <p>- ${orderInfo.note}.</p>
            </c:when>

            <c:when test="${orderInfo.status == OrderStatusCode.DELIVERED.toString()}">
                <h4>Đơn hàng này <span style="color: green">được giao</span> lúc <fmt:formatDate
                        value="${orderInfo.modifiedAt}"
                        pattern="HH:mm:ss, dd/MM/yyyy"/>.</h4>
            </c:when>

            <c:when test="${orderInfo.status == OrderStatusCode.DELIVERING.toString()}">
                <h4>Đơn hàng này <span class="text-warning">đang được vận chuyển</span></h4>
            </c:when>

            <c:otherwise>
                <h4>Đơn hàng này <span class="text-warning">đang chờ xử lý</span></h4>
            </c:otherwise>
        </c:choose>
    </div>

    <br>

    <%--    <div class="row block-27">--%>
    <%--        		<!-- Information -->--%>
    <%--        <div class="col-md-12 order-md-last d-flex ftco-animate">--%>
    <h4>Thông tin giao hàng</h4>
    <form method="get" id="form-edit" name="form-edit" class="bg-white p-2 ftco-animate text-dark">
        <div class="form-group" style="font-size: 16px">
            <span class="text-dark">- Họ tên: </span>${orderInfo.userDTO.fullName}.
        </div>

        <div class="form-group" style="font-size: 16px">
            <span class="text-dark">- Số điện thoại: </span>${orderInfo.userDTO.phoneNumber}.
        </div>

        <div class="form-group" style="font-size: 16px">
            <span class="text-dark">- Địa chỉ giao hàng: </span>${orderInfo.address}.
        </div>

        <div class="form-group" style="font-size: 16px">
            <span class="text-dark">- Phương thức thanh toán: </span>
            <c:forEach var="paymentMethodSingle" items="${paymentMethod}">
                <c:if test="${paymentMethodSingle.key == orderInfo.paymentMethod}">
                    ${paymentMethodSingle.value}
                </c:if>
            </c:forEach>

        </div>
    </form>
    <br>
    <h4>Các sản phẩm đã mua</h4>
    <table class="table table-bordered table-striped table-hover text-dark">
        <tr>
            <th>Ảnh đại diện</th>
            <th>Tên sản phẩm</th>
            <th>Số lượng mua</th>
            <th>Giá mua</th>
            <th>Thành tiền</th>
        </tr>

        <c:forEach var="productOfOrder" items="${productsOfOrder}">
            <tr>
                <td class="image-prod">
                    <div class="img"
                         style="background-image:url('/repository${productOfOrder.productDTO.image}');"></div>
                </td>

                <td class="product-name">
                    <h3>${productOfOrder.productDTO.name}</h3>
                </td>

                <td class="product-name">
                    <h3>${productOfOrder.quantity}</h3>
                </td>

                <td class="price">
                    <fmt:formatNumber value="${productOfOrder.priceInPurchase}" pattern="#,###"/>₫
                </td>

                <td class="price">
                    <fmt:formatNumber value="${productOfOrder.priceInPurchase * productOfOrder.quantity}"
                                      pattern="#,###"/>₫
                </td>
            </tr>
        </c:forEach>
    </table>

    <div class="row mt-5 pt-3 justify-content-lg-end">
        <div class="col-md-4 d-flex mb-5">
            <div class="cart-detail cart-total p-3 p-md-4 text-dark">
                <h3>Tổng chi phí</h3>
                <p class="d-flex">
                    <span>Tiền hàng</span>
                    <span><fmt:formatNumber value="${orderInfo.total}" pattern="#,###"/> ₫</span>
                    <input type="hidden" value="${orderInfo.total}" id="totalOfOrder" name="totalOfOrder">
                </p>

                <p class="d-flex">
                    <span>Giảm giá</span>
                    <span><input id="discount" type="hidden" value="${orderInfo.discount}"/>
                                    <fmt:formatNumber value="${orderInfo.discount}" pattern="#,###"/>₫
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
    <%--        </div>--%>
    <%--    </div>--%>
</div>

</body>
</html>