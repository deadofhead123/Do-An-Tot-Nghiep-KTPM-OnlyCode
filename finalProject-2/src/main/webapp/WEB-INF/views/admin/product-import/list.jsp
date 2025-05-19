<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>
<c:url var="formAPI" value="/api/admin/imports"/>
<c:url var="formURI" value="/admin/import-list"/>

<!DOCTYPE html>
<html lang="en">

<head>
    <title>Danh sách nhập hàng</title>
</head>

<body class="g-sidenav-show  bg-gray-100">

<div class="container-fluid py-2">

    <!-- User list -->
    <div class="row">
        <div class="col-12">
            <div class="card my-4">
                <div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
                    <div class="bg-gradient-dark shadow-dark border-radius-lg pt-4 pb-3">
                        <h6 class="text-white text-capitalize ps-3">Danh sách nhập hàng</h6>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12 mx-3 my-3">
                        <!-- Search form -->
                        <form:form method="get" modelAttribute="importSearch" id="form-search">
                            <!-- Row 1 -->
                            <div class="input-group">
                                <div class="col-lg-3 px-3">
                                    <label for="name"><strong class="text-dark">Tên nhà cung cấp</strong></label>
                                    <form:input path="name" type="text" name="name" id="name"
                                                class="form-control px-2"
                                                style="border: 1px solid black"/>
                                </div>

                                <div class="col-lg-3 px-3">
                                    <label for="address"><strong class="text-dark">Địa chỉ</strong></label>
                                    <form:input path="address" type="text" name="address" id="address"
                                                class="form-control px-2"
                                                style="border: 1px solid black"/>
                                </div>

                                <div class="col-lg-2 px-3">
                                    <label for="createdAtFrom"><strong class="text-dark">Thời gian nhập từ</strong></label>
                                    <form:input path="createdAtFrom" type="date" name="createdAtFrom" id="createdAtFrom"
                                                class="form-control px-2"
                                                style="border: 1px solid black"/>
                                </div>

                                <div class="col-lg-2 px-3">
                                    <label for="createdAtTo"><strong class="text-dark">Thời gian nhập đến</strong></label>
                                    <form:input path="createdAtTo" type="date" name="createdAtFrom" id="createdAtFrom"
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
                                    <button type="button" class="btn btn-facebook" id="btnAddUser"
                                            title="Tạo lần nhập hàng mới">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                             fill="currentColor" class="bi bi-plus-circle" viewBox="0 0 16 16">
                                            <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
                                            <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4"/>
                                        </svg>
                                        <a href="/admin/import-create" class="text-white">Thêm mới</a>
                                    </button>
                                </div>
                            </div>
                        </form:form>
                    </div>
                </div>

                <div class="card-body px-0 pb-2">
                    <div class="table-responsive p-0">

                        <display:table name="supplierSearchResponse.listResult" cellspacing="0"
                                       cellpadding="0"
                                       requestURI="${formURI}" partialList="true"
                                       sort="external"
                                       size="${supplierSearchResponse.totalItems}" defaultsort="2"
                                       defaultorder="ascending"
                                       id="tableList" pagesize="${supplierSearchResponse.maxPageItems}"
                                       export="false"
                                       class="table align-items-center table-striped table-bordered table-hover mb-0"
                                       style="margin: 0 1.5em;">
                            <display:column
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8"
                                    title="Mã lần nhập hàng">
                                <div class="align-middle text-center">
                                    <span class="text-secondary text-md font-weight-bold">${tableList.id}</span>
                                </div>
                            </display:column>

                            <display:column
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8"
                                    title="Tên nhà cung cấp">
                                <div class="align-middle text-center">
                                    <span class="text-secondary text-md font-weight-bold">${tableList.name}</span>
                                </div>
                            </display:column>

                            <display:column
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8"
                                    title="Địa chỉ">
                                <div class="align-middle text-center">
                                    <span class="text-secondary text-md font-weight-bold">${tableList.address}</span>
                                </div>
                            </display:column>

                            <display:column
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8"
                                    title="Thời gian nhập">
                                <div class="align-middle text-center">
                                    <span class="text-secondary text-md font-weight-bold">
                                        <fmt:formatDate value="${tableList.createdAt}" pattern="HH:mm:ss, dd/MM/yyyy"/>
                                    </span>
                                </div>
                            </display:column>

                            <display:column
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8"
                                    title="Thao tác">
                                <div class="align-middle text-center">
                                    <button class="badge badge-circle bg-gradient-info"
                                            style="text-transform: capitalize">
                                        <a href="/admin/import-detail-${tableList.id}"
                                           class="text-secondary font-weight-bold text-md text-white"
                                           title="Xem thông tin chi tiết của lần nhập hàng">
                                            Chi tiết
                                        </a>
                                    </button>
                                </div>
                            </display:column>
                            <display:setProperty name="paging.banner.one_item_found"
                                                 value="<br/><div class='ms-3 col-sm-6 align-left'><div class='infos'>Tìm thấy <b>1</b> lần nhập hàng.</div></div>"/>
                            <display:setProperty name="paging.banner.all_items_found"
                                                 value="<br/><div class='ms-3 col-sm-6 align-left'><div class='infos'>Tìm thấy <b>{0}</b> lần nhập hàng.</div></div>"/>

                            <display:setProperty name="basic.msg.empty_list"
                                                 value="Không tìm thấy kết quả"/>
                            <display:setProperty name="paging.banner.no_items_found"
                                                 value="<br/><div class='ms-3 col-sm-6 align-left'><div class='infos'>Không tìm thấy lần nhập hàng nào.</div></div>"/>
                            <display:setProperty name="paging.banner.some_items_found"
                                                 value="<br/><div class='ms-3 col-sm-6 align-left'><div class='info-horizontal'>Tìm thấy <b>{0}</b> lần nhập hàng, hiển thị từ {2} đến {3}.</div></div>"/>
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