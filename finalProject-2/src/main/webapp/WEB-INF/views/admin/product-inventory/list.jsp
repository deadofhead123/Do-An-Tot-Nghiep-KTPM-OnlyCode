<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.javaweb.util.ProductInventoryStatus" %>
<%@include file="/common/taglib.jsp" %>
<c:url var="formURI" value="/admin/productInventory-list"/>
<c:url var="productInventoryEditURL" value="/admin/productInventory-detail"/>
<c:url var="productInventoryDropURL" value="/admin/productInventory-drop"/>

<!DOCTYPE html>
<html lang="en">

<head>
    <title>Kho hàng</title>
</head>

<body class="g-sidenav-show  bg-gray-100">

<div class="container-fluid py-2">

    <!-- User list -->
    <div class="row">
        <div class="col-12">
            <div class="card my-4">
                <div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
                    <div class="bg-gradient-dark shadow-dark border-radius-lg pt-4 pb-3">
                        <h6 class="text-white text-capitalize ps-3">Danh sách sản phẩm con</h6>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12 mx-3 my-3">
                        <!-- Search form -->
                        <form:form method="get" modelAttribute="productInventorySearch" id="form-search">
                            <!-- Row 1 -->
                            <div class="input-group">
                                <div class="col-lg-2 px-3">
                                    <label for="id"><strong class="text-dark">Mã sản phẩm</strong></label>
                                    <form:input path="id" type="number" name="id" id="id"
                                                class="form-control px-2"
                                                style="border: 1px solid black"/>
                                </div>

                                <div class="col-lg-3 px-3">
                                    <label for="name"><strong class="text-dark">Tên sản phẩm</strong></label>
                                    <form:input path="name" type="text" name="name" id="name"
                                                class="form-control px-2"
                                                style="border: 1px solid black"/>
                                </div>

                                <div class="col-lg-3 px-3">
                                    <label for="supplierId"><strong class="text-dark">Mã lần nhập hàng</strong></label>
                                    <form:input path="supplierId" type="text" name="supplierId" id="supplierId"
                                                class="form-control px-2"
                                                style="border: 1px solid black"/>
                                </div>

                                <div class="col-lg-3 px-3">
                                    <label for="orderId"><strong class="text-dark">Mã đơn hàng</strong></label>
                                    <form:input path="orderId" type="text" name="orderId" id="orderId"
                                                class="form-control px-2"
                                                style="border: 1px solid black"/>
                                </div>
                            </div>
                            <br>

                            <div class="input-group">
                                <div class="col-lg-2 px-3">
                                    <label for="type"><strong class="text-dark">Danh mục</strong></label>
                                    <form:select path="categoryId" name="type" id="type" class="form-select px-2"
                                                 style="border: 1px solid black">
                                        <form:option value="" label="----------Chọn danh mục----------"/>
                                        <form:options items="${categories}"/>
                                    </form:select>
                                </div>
                            </div>
                            <br>

                            <h5>Tình trạng của sản phẩm con</h5>
                            <div class="input-group">
                                <div class="col-lg-2 px-3">
                                    <label for="type"><strong class="text-dark">Tình trạng</strong></label>
                                    <form:select path="status" name="status" id="status" class="form-select px-2"
                                                 style="border: 1px solid black">
                                        <form:option value="" label="----------Chọn tình trạng----------"/>
                                        <form:options items="${productInventoryStatus}"/>
                                    </form:select>
                                </div>

                                <div class="col-lg-1 px-xxl-3"></div>

                                <div class="col-lg-2 px-xxl-3">
                                    <label for="statusTimeFrom"><strong class="text-dark">Thời gian từ</strong></label>
                                    <form:input path="statusTimeFrom" type="date" name="statusTimeFrom" id="statusTimeFrom"
                                                class="form-control px-2"
                                                style="border: 1px solid black"/>
                                </div>

                                <div class="col-lg-2 px-xxl-3">
                                    <label for="statusTimeTo"><strong class="text-dark">Thời gian đến</strong></label>
                                    <form:input path="statusTimeTo" type="date" name="statusTimeTo" id="statusTimeTo"
                                                class="form-control px-2"
                                                style="border: 1px solid black"/>
                                </div>
                            </div>
                            <br>

                            <div class="input-group py-3">
                                <div class="col-lg-3 px-4">
                                    <button type="button" class="btn btn-primary" id="btnSeach">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                             fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                                            <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
                                        </svg>
                                        Tìm kiếm
                                    </button>
                                    &nbsp;
                                    <button type="reset" class="btn btn-warning" id="btnDeleteParams">Xóa</button>
                                </div>
                            </div>

                            <div class="input-group py-3">
                                <div class="col-lg-3 px-4"></div>
                                <div class="col-lg-3 px-4"></div>
                                <div class="col-lg-3 px-4"></div>
                                <div class="col-lg-3 px-4">
                                    <button type="button" class="btn btn-danger" id="btnAddUser"
                                            title="Thêm sản phẩm">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                             fill="currentColor" class="bi bi-x-lg" viewBox="0 0 16 16">
                                            <path d="M2.146 2.854a.5.5 0 1 1 .708-.708L8 7.293l5.146-5.147a.5.5 0 0 1 .708.708L8.707 8l5.147 5.146a.5.5 0 0 1-.708.708L8 8.707l-5.146 5.147a.5.5 0 0 1-.708-.708L7.293 8z"/>
                                        </svg>
                                        <a href="${productInventoryDropURL}" class="text-white">Bỏ hàng</a>
                                    </button>
                                </div>
                            </div>
                        </form:form>
                    </div>
                </div>

                <div class="card-body px-0 pb-2">
                    <div class="table-responsive p-0">

                        <display:table name="productInventorySearchResponse.listResult" cellspacing="0"
                                       cellpadding="0"
                                       requestURI="${formURI}" partialList="true"
                                       sort="external"
                                       size="${productInventorySearchResponse.totalItems}" defaultsort="2"
                                       defaultorder="ascending"
                                       id="tableList" pagesize="${productInventorySearchResponse.maxPageItems}"
                                       export="false"
                                       class="table align-items-center table-striped table-bordered table-hover mb-0"
                                       style="margin: 0 1.5em;">
                            <display:column
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8" sortable="true" sortName="id"
                                    title="Mã sản phẩm">
                                <div class="align-middle text-center">
                                    <span class="text-secondary text-md font-weight-bold">${tableList.id}</span>
                                </div>
                            </display:column>

                            <display:column
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8"
                                    title="Ảnh đại diện">
                                <div class="align-middle text-center">
                                    <c:if test="${not empty tableList.productDTO.image}">
                                        <c:set var="imagePath" value="/repository${tableList.productDTO.image}"/>
                                        <img src="${imagePath}" id="viewImage" width="100" height="100"
                                             style="margin-top: 5px; margin-bottom: 5px" alt="Không tìm thấy ảnh">
                                    </c:if>

                                    <c:if test="${empty tableList.productDTO.image}">
                                        <img src="/admin/image/default.png" id="viewImage" width="100" height="100"
                                             alt="Chưa có ảnh">
                                    </c:if>
                                </div>
                            </display:column>

                            <display:column
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8"
                                    title="Tên sản phẩm">
                                <div class="align-middle text-center">
                                    <span class="text-secondary text-md font-weight-bold">${tableList.productDTO.name}</span>
                                </div>
                            </display:column>

                            <display:column
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8" sortable="true" sortName="priceInImport"
                                    title="Giá nhập">
                                <div class="align-middle text-center">
                                    <span class="text-secondary text-md font-weight-bold">
                                        <fmt:formatNumber value="${tableList.priceInImport}" pattern="#,###"/>₫
                                    </span>
                                </div>
                            </display:column>

                            <display:column
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8" sortable="true" sortName="status"
                                    title="Trạng thái">
                                <div class="align-middle text-center">
                                    <span class="text-secondary text-md font-weight-bold">
                                        <c:forEach var="statusSingle" items="${productInventoryStatus}">
                                            <c:if test="${statusSingle.key == tableList.status}">
                                                <c:choose>
                                                    <c:when test="${statusSingle.key == ProductInventoryStatus.CORRUPTED.toString()}">
                                                        <span class="text-danger">${statusSingle.value}</span>
                                                    </c:when>
                                                    <c:when test="${statusSingle.key == ProductInventoryStatus.DELIVERED.toString()}">
                                                        <span class="text-success">${statusSingle.value}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${statusSingle.value}
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:if>
                                        </c:forEach>
                                    </span>
                                </div>
                            </display:column>

                            <display:column
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8" sortable="true" sortName="createdAt"
                                    title="Ngày nhập">
                                <div class="align-middle text-center">
                                    <span class="text-secondary text-md font-weight-bold">${tableList.createdAt}</span>
                                </div>
                            </display:column>

                            <display:column
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8" sortable="true" sortName="modifiedAt"
                                    title="Ngày sửa">
                                <div class="align-middle text-center">
                                    <span class="text-secondary text-md font-weight-bold">${tableList.modifiedAt}</span>
                                </div>
                            </display:column>

                            <display:column
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8"
                                    title="Thao tác">
                                <div class="align-middle text-center">
                                    <button class="badge badge-circle bg-gradient-info"
                                            style="text-transform: capitalize">
                                        <a href="${productInventoryEditURL}-${tableList.id}"
                                           class="text-secondary font-weight-bold text-md text-white"
                                           title="Xem thông tin chi tiết của sản phẩm con">
                                            Chi tiết
                                        </a>
                                    </button>
                                </div>
                            </display:column>
                            <display:setProperty name="paging.banner.one_item_found"
                                                 value="<br/><div class='ms-3 col-sm-6 align-left'><div class='infos'>Tìm thấy <b>1</b> sản phẩm.</div></div>"/>
                            <display:setProperty name="paging.banner.all_items_found"
                                                 value="<br/><div class='ms-3 col-sm-6 align-left'><div class='infos'>Tìm thấy <b>{0}</b> sản phẩm.</div></div>"/>

                            <display:setProperty name="basic.msg.empty_list"
                                                 value="Không tìm thấy kết quả"/>
                            <display:setProperty name="paging.banner.no_items_found"
                                                 value="<br/><div class='ms-3 col-sm-6 align-left'><div class='infos'>Không tìm thấy sản phẩm nào.</div></div>"/>
                            <display:setProperty name="paging.banner.some_items_found"
                                                 value="<br/><div class='ms-3 col-sm-6 align-left'><div class='info-horizontal'>Tìm thấy <b>{0}</b> sản phẩm, hiển thị từ {2} đến {3}.</div></div>"/>
                        </display:table>

                    </div>
                </div>
            </div>
        </div>
    </div>

</div>

<script>
    $(document).ready(function () {
        setTimeout(function () {
            $('#alertResult').hide();
        }, 2000);
    });

    function openImage(input, imageView) {
        if (input.files && input.files[0]) {
            let reader = new FileReader();
            reader.onload = function (e) {
                $('#' + imageView).attr('src', reader.result);
            }
            reader.readAsDataURL(input.files[0]);
        }
    }

    //----------------------------- Search
    $('#btnSeach').click(function () {
        $('#form-search').submit();
    });

    //----------------------------- Clear search form
    $('#btnDeleteParams').click(function () {
        window.location.href = "${formURI}";
    });
</script>

</body>

</html>