<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>
<c:url var="productAPI" value="/api/admin/products"/>
<c:url var="importAPI" value="/api/admin/imports"/>
<c:url var="importAddURL" value="/admin/import-create"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Chi tiết nhập hàng</title>
</head>

<body class="g-sidenav-show bg-gray-100">

<div class="container-fluid px-2 px-md-6">
    <div class="page-header min-height-300 border-radius-xl mt-4"
         style="background-image: url('/web-user/images/bg_1.jpg');">
        <span class="mask bg-gradient-dark  opacity-1"></span>
    </div>

    <div class="card card-body mx-2 mx-md-2 mt-n6">
        <form:form method="get" id="form-create" name="form-create" modelAttribute="supplierEdit"
                   enctype="multipart/form-data">
            <div class="row gx-4 mb-2">
                <div class="col-auto my-auto">
                    <div class="h-100 align-items-center">
                        <h4 class="mb-1">Chi tiết nhập hàng</h4>
                    </div>
                </div>
            </div>

            <div class="row">
                <h5 class="mb-0">Thông tin nhà cung cấp</h5>
            </div>

            <div class="row">
                <!-- Supplier's information -->
                <div class="col-12 col-xl-4">
                    <div class="card card-plain h-100">
                        <div class="card-body">
                            <div class="form-group py-1">
                                <label for="name"><strong class="text-dark">Tên nhà cung cấp</strong></label>
                                <form:input path="name" name="name" id="name"
                                            class="form-control px-2"
                                            style="border: 1px solid black; color: black" readonly="true"/>
                            </div>

                            <div class="form-group py-2">
                                <label for="address"><strong class="text-dark">Địa chỉ</strong></label>
                                <form:input path="address" name="address" id="address"
                                            class="form-control px-2"
                                            style="border: 1px solid black; color: black" readonly="true"/>
                            </div>

                            <div class="form-group py-2">
                                <label for="email"><strong class="text-dark">Email</strong></label>
                                <form:input path="email" name="email" id="email"
                                            class="form-control px-2"
                                            style="border: 1px solid black; color: black" readonly="true"/>
                            </div>

                            <div class="form-group py-2">
                                <label for="phoneNumber"><strong class="text-dark">Số điện thoại</strong></label>
                                <form:input path="phoneNumber" name="phoneNumber" id="phoneNumber"
                                            class="form-control px-2"
                                            style="border: 1px solid black; color: black" readonly="true"/>
                            </div>

                        </div>
                    </div>
                </div>

                <div class="col-12 col-xl-4">
                    <div class="card card-plain h-100">
                        <div class="card-body text-dark">
                            <div class="form-group py-1">
                                <label for="note"><strong class="text-dark">Ghi chú</strong></label>
                                <form:textarea path="note" name="note" id="note"
                                               class="form-control px-2"
                                               rows="5"
                                               style="border: 1px solid black; color: black" readonly="true"/>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Products -->
                <div class="row pt-xxl-3 pb-xxl-3">
                    <div class="col-12 col-xl-4 align-items-xxl-end">
                        <h5 class="mb-0">Danh sách sản phẩm nhập</h5>
                    </div>
                </div>
                <br>
                <div class="row">
                    <div class="col-12 col-xl-12">
                        <div class="table-container">
                            <table id="product-table">
                                <thead>
                                <tr class="text-center" style="background-color: blue;">
                                    <th>Ảnh đại diện</th>
                                    <th>Tên sản phẩm</th>
                                    <th>Số lượng nhập</th>
                                    <th>Giá nhập</th>
                                    <th>Thành tiền</th>
                                </tr>
                                </thead>

                                <tbody>
                                <c:forEach var="productImport" items="${supplyDetailsResult}">
                                    <tr class="text-center" id="product-infor">
                                        <!-- Price -->
                                        <td valign="center">
                                            <c:if test="${not empty productImport.productDTO.image}">
                                                <c:set var="imagePath"
                                                       value="/repository${productImport.productDTO.image}"/>
                                                <img src="${imagePath}" id="viewImage" width="100" height="100"
                                                     style="margin-top: 5px; margin-bottom: 5px"
                                                     alt="Không tìm thấy ảnh">
                                            </c:if>

                                            <c:if test="${empty productImport.productDTO.image}">
                                                <img src="/admin/image/default.png" id="viewImage" width="100"
                                                     height="100"
                                                     alt="Chưa có ảnh">
                                            </c:if>
                                        </td>

                                        <!-- Name -->
                                        <td class="text-dark align-content-xxl-center"
                                            style="color: black">${productImport.productDTO.name}</td>

                                        <!-- Quantity -->
                                        <td class="text-dark align-content-xxl-center">
                                            <input type="hidden" value="${productImport.quantity}" id="quantity"
                                                   style="width: 70px"/>
                                                ${productImport.quantity}
                                        </td>

                                        <!-- Price import -->
                                        <td class="text-dark align-content-xxl-center">
                                            <input type="hidden" id="price" value="${productImport.price}"
                                                   style="width: 110px"/>
                                            <fmt:formatNumber value="${productImport.price}" pattern="#,###"/>₫
                                        </td>

                                        <!-- Sub total -->
                                        <td id="product-total" class="align-content-xxl-center" style="color: black"
                                            align="right">
                                            <fmt:formatNumber value="${productImport.quantity * productImport.price}"
                                                              pattern="#,###"/>₫
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- Total of import -->
                <div class="row pt-xxl-3 pb-xxl-2">
                    <div class="col-12 col-xl-12 text-end">
                        <strong class="text-dark">Tổng tiền nhập:</strong>
                        <span id="importTotal" class="text-dark">
                                        <script>
                                            const priceImports = document.querySelectorAll('#product-infor');
                                            let importTotal = 0;

                                            priceImports.forEach(item => {
                                                let quantity = item.querySelector('#quantity').value;
                                                let price = item.querySelector('#price').value;
                                                importTotal += quantity * price;
                                            });

                                            document.write(importTotal.toLocaleString() + "₫");
                                        </script>
                        </span>
                    </div>
                </div>

                <br>
                <div class="row">
                    <div class="col-12 col-xl-5"></div>
                    <div class="col-12 col-xl-4 align-items-xxl-end">
                        <button type="button" class="btn bg-gradient-faded-dark px-3 py-2 ms-3 align-items-xxl-end">
                            <a class="text-white" href="/admin/import-list">Quay lại</a>
                        </button>
                    </div>
                </div>
            </div>
        </form:form>
    </div>

</div>

<script>

</script>
</body>

</html>