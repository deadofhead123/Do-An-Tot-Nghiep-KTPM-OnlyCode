<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.javaweb.util.OrderStatusCode" %>
<%@include file="/common/taglib.jsp" %>
<c:set var="pageURL" value="/my-orders"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Tài khoản</title>
</head>

<body>

<div class="myaccount__body">
    <%--    <div class="row block-27">--%>
    <%--        		<!-- Information -->--%>
    <%--        <div class="col-md-12 order-md-last d-flex ftco-animate">--%>
    <c:choose>
        <c:when test="${not empty orders.content}">
            <h3>Đơn hàng đã đặt</h3>
            <table class="table table-bordered table-striped table-hover text-dark">
                <tr>
                    <th>Mã đơn hàng</th>
                    <th>Thời gian tạo</th>
                    <th>Tình trạng</th>
                    <th>Tổng tiền</th>
                    <th>Thao tác</th>
                </tr>

                <c:forEach var="orderSingle" items="${orders.content}">
                    <tr>
                        <td>#${orderSingle.id}</td>

                        <td>
                            <fmt:formatDate value="${orderSingle.createdAt}" pattern="HH:mm:ss, dd/MM/yyyy"/>
                        </td>

                        <td>
                            <c:forEach var="statusSingle" items="${statusType}">
                                <c:if test="${orderSingle.status == statusSingle.key}">
                                    <c:choose>
                                        <c:when test="${orderSingle.status == OrderStatusCode.CANCELED.toString()}">
                                            <span style="color: red">${statusSingle.value}</span>
                                        </c:when>

                                        <c:when test="${orderSingle.status == OrderStatusCode.DELIVERING.toString()}">
                                            <span style="color: orange">${statusSingle.value}</span>
                                        </c:when>

                                        <c:when test="${orderSingle.status == OrderStatusCode.DELIVERED.toString()}">
                                            <span style="color: green">${statusSingle.value}</span>
                                        </c:when>

                                        <c:otherwise>
                                            ${statusSingle.value}
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>
                            </c:forEach>
                        </td>

                        <td><fmt:formatNumber value="${orderSingle.total - orderSingle.discount}" pattern="#,###"/>₫
                        </td>

                        <td>
                            <button type="button" class="btn btn-info py-1 px-3" id="btnUpdate">
                                <a href="/my-order-details-${orderSingle.id}" class="text-white"
                                   title="Xem thông tin chi tiết của đơn hàng">
                                    Chi tiết
                                </a>
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </table>

            <div class="row mt-5">
                <div class="col text-center">
                    <div class="block-27">
                        <ul>
                            <c:if test="${orders.hasPrevious()}">
                                <li>
                                    <a href="${pageURL}?page=0&maxPageItems=${orders.size}">&lt;&lt;</a>
                                </li>
                            </c:if>

                            <c:if test="${orders.hasPrevious()}">
                                <li>
                                    <a href="${pageURL}?page=${orders.number - 1}&maxPageItems=${orders.size}">&lt;</a>
                                </li>
                            </c:if>

                            <c:forEach var="i" begin="0" end="${orders.totalPages - 1}">
                                <c:choose>
                                    <c:when test="${i == orders.number}">
                                        <li class="active"><span>${i + 1}</span></li>
                                    </c:when>

                                    <c:when test="${i == 0 || i == orders.totalPages - 1 || i == orders.number - 1 || i == orders.number + 1}">
                                        <li>
                                            <a href="${pageURL}?page=${i}&maxPageItems=${orders.size}">${i + 1}</a>
                                        </li>
                                    </c:when>

                                    <c:when test="${( orders.number > 2 && i == orders.number - 2 ) || (i == orders.number + 2 && orders.number < orders.totalPages - 3)}">
                                        <li><span>...</span></li>
                                    </c:when>
                                </c:choose>
                            </c:forEach>

                            <c:if test="${orders.hasNext()}">
                                <li>
                                    <a href="${pageURL}?page=${orders.number + 1}&maxPageItems=${orders.size}">></a>
                                </li>
                            </c:if>

                            <c:if test="${orders.hasNext()}">
                                <li>
                                    <a href="${pageURL}?page=${orders.totalPages - 1}&maxPageItems=${orders.size}">>&gt;</a>
                                </li>
                            </c:if>
                        </ul>
                    </div>
                </div>
            </div>
        </c:when>

        <c:otherwise>
            <h3>Bạn chưa đặt đơn hàng nào.</h3>
        </c:otherwise>
    </c:choose>
    <%--        </div>--%>
    <%--    </div>--%>
</div>

</body>
</html>