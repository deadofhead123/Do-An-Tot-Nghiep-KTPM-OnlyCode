<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>
<c:url var="formURI" value="/admin/order-list"/>

<!DOCTYPE html>
<html lang="en">

<head>
    <title>Danh sách đơn hàng</title>
</head>

<body class="g-sidenav-show  bg-gray-100">

<div class="container-fluid py-2">

    <!-- User list -->
    <div class="row">
        <div class="col-12">
            <div class="card my-4">
                <div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
                    <div class="bg-gradient-dark shadow-dark border-radius-lg pt-4 pb-3">
                        <h6 class="text-white text-capitalize ps-3">Danh sách đơn hàng</h6>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12 mx-3 my-3">
                        <!-- Search form -->
                        <form:form method="get" modelAttribute="orderSearch" id="form-search">
                            <div class="input-group">
                                <div class="col-lg-2 px-3">
                                    <label for="id"><strong class="text-dark">Mã đơn hàng</strong></label>
                                    <form:input path="id" type="number" name="id" id="id"
                                                class="form-control px-2"
                                                style="border: 1px solid black"/>

                                </div>
                                <div class="col-lg-2 px-3">
                                    <label for="status"><strong class="text-dark">Trạng thái</strong></label>
                                    <form:select path="status" name="status" id="status" class="form-select px-2"
                                                 style="border: 1px solid black">
                                        <form:option value="" label="----------Chọn trạng thái----------"/>
                                        <form:options items="${statusType}"/>
                                    </form:select>
                                </div>
                            </div>
                            <br>
                            <div class="input-group">
                                <div class="col-lg-2 px-3">
                                    <label for="createdAtFrom"><strong class="text-dark">Thời gian đặt
                                        từ</strong></label>
                                    <form:input path="createdAtFrom" type="date" name="createdAtFrom" id="createdAtFrom"
                                                class="form-control px-2"
                                                style="border: 1px solid black"/>
                                </div>

                                <div class="col-lg-2 px-3">
                                    <label for="createdAtTo"><strong class="text-dark">Thời gian đặt
                                        đến</strong></label>
                                    <form:input path="createdAtTo" type="date" name="createdAtTo" id="createdAtTo"
                                                class="form-control px-2"
                                                style="border: 1px solid black"/>
                                </div>
                            </div>

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
                        </form:form>
                    </div>
                </div>

                <div class="card-body px-0 pb-2">
                    <div class="table-responsive p-0">

                        <display:table name="orderSearchResponse.listResult" cellspacing="0"
                                       cellpadding="0"
                                       requestURI="${formURI}" partialList="true"
                                       sort="external"
                                       size="${orderSearchResponse.totalItems}" defaultsort="2"
                                       defaultorder="ascending"
                                       id="tableList" pagesize="${orderSearchResponse.maxPageItems}"
                                       export="false"
                                       class="table align-items-center table-striped table-bordered table-hover mb-0"
                                       style="margin: 0 1.5em;">

                            <display:column
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8" sortable="true" sortName="id"
                                    title="Mã đơn hàng">
                                <div class="align-middle text-center">
                                    <span class="text-secondary text-md font-weight-bold">${tableList.id}</span>
                                </div>
                            </display:column>

                            <display:column
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8" sortable="true" sortName="total - od.discount"
                                    title="Tổng tiền">
                                <div class="align-middle text-center">
                                    <span class="text-secondary text-md font-weight-bold"><fmt:formatNumber value='${tableList.totalFinal}' pattern='#,###'/>₫</span>
                                </div>
                            </display:column>

                            <display:column
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8" sortable="true" sortName="address"
                                    title="Địa chỉ giao hàng">
                                <div class="align-middle text-center">
                                    <span class="text-secondary text-md font-weight-bold">${tableList.address}</span>
                                </div>
                            </display:column>

                            <display:column
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8" sortable="true" sortName="status"
                                    title="Trạng thái">
                                <div class="align-middle text-center">
                                    <span class="text-secondary text-md font-weight-bold">
                                        <c:forEach var="statusSingle" items="${statusType}">
                                            <c:if test="${statusSingle.key == tableList.status}">
                                                <c:choose>
                                                    <c:when test="${tableList.status == 'CANCELED'}">
                                                        <span style="color: red">${statusSingle.value}</span>
                                                    </c:when>

                                                    <c:when test="${tableList.status == 'DELIVERING'}">
                                                        <span style="color: orange">${statusSingle.value}</span>
                                                    </c:when>

                                                    <c:when test="${tableList.status == 'DELIVERED'}">
                                                        <span style="color: green">${statusSingle.value}</span>
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
                                    title="Thời gian đặt">
                                <div class="align-middle text-center">
                                    <span class="text-secondary text-md font-weight-bold">
                                        <fmt:formatDate value="${tableList.createdAt}" pattern="HH:mm:ss, dd/MM/yyyy"/>
                                    </span>
                                </div>
                            </display:column>

                            <display:column
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8" sortable="true" sortName="modifiedAt"
                                    title="Thời gian giao">
                                <div class="align-middle text-center">
                                    <span class="text-secondary text-md font-weight-bold">
                                        <c:choose>
                                            <c:when test="${tableList.status == 'DELIVERED'}">
                                                <fmt:formatDate value="${tableList.modifiedAt}"
                                                                pattern="HH:mm:ss, dd/MM/yyyy"/>
                                            </c:when>
                                        </c:choose>
                                    </span>
                                </div>
                            </display:column>

                            <display:column
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8"
                                    title="Thao tác">
                                <div class="align-middle text-center">
                                    <button class="badge badge-circle bg-gradient-info"
                                            style="text-transform: capitalize">
                                        <a href="/admin/order-edit-${tableList.id}"
                                           class="text-secondary font-weight-bold text-md text-white"
                                           title="Xem thông tin chi tiết, cập nhật trạng thái của đơn hàng">
                                            Cập nhật
                                        </a>
                                    </button>
                                </div>
                            </display:column>
                            <display:setProperty name="paging.banner.one_item_found"
                                                 value="<br/><div class='ms-3 col-sm-6 align-left'><div class='infos'>Tìm thấy <b>1</b> đơn hàng.</div></div>"/>
                            <display:setProperty name="paging.banner.all_items_found"
                                                 value="<br/><div class='ms-3 col-sm-6 align-left'><div class='infos'>Tìm thấy <b>{0}</b> đơn hàng.</div></div>"/>

                            <display:setProperty name="basic.msg.empty_list"
                                                 value="Không tìm thấy kết quả"/>
                            <display:setProperty name="paging.banner.no_items_found"
                                                 value="<br/><div class='ms-3 col-sm-6 align-left'><div class='infos'>Không tìm thấy đơn hàng nào.</div></div>"/>
                            <display:setProperty name="paging.banner.some_items_found"
                                                 value="<br/><div class='ms-3 col-sm-6 align-left'><div class='info-horizontal'>Tìm thấy <b>{0}</b> đơn hàng, hiển thị từ {2} đến {3}.</div></div>"/>
                        </display:table>

                    </div>
                </div>
            </div>
        </div>
    </div>

</div>

<script>
    // $(document).ready(function () {
    //     let formatter = new Intl.DateTimeFormat('en-CA', {year: 'numeric', month: '2-digit', day: '2-digit'});
    //     $('#createdAtFrom').val(formatter.format(new Date()));
    //     $('#createdAtTo').val(formatter.format(new Date()));
    // });

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