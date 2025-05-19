<!--
=========================================================
* Material Dashboard 3 - v3.2.0
=========================================================

* Product Page: https://www.creative-tim.com/product/material-dashboard
* Copyright 2024 Creative Tim (https://www.creative-tim.com)
* Licensed under MIT (https://www.creative-tim.com/license)
* Coded by Creative Tim

=========================================================

* The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.javaweb.security.utils.SecurityUtils"%>
<%@include file="/common/taglib.jsp" %>
<c:url var="formURL" value="/admin/user-list"/>
<c:url var="userAPI" value="/api/admin/users"/>
<c:url var="userAddURL" value="/admin/user-add"/>

<!DOCTYPE html>
<html lang="en">

<head>
    <title>Danh sách người dùng</title>
</head>

<body class="g-sidenav-show  bg-gray-100">

<div class="container-fluid py-2">

    <!-- User list -->
    <div class="row">
        <div class="col-12">
            <div class="card my-4">
                <div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
                    <div class="bg-gradient-dark shadow-dark border-radius-lg pt-4 pb-3">
                        <h6 class="text-white text-capitalize ps-3">Danh sách người dùng</h6>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12 mx-3 my-3">
                        <form:form method="get" modelAttribute="userSearch" id="form-search">
                            <!-- Row 1 -->
                            <div class="input-group">
                                <div class="col-lg-2 px-3">
                                    <label for="email"><strong class="text-dark">Email</strong></label>
                                    <form:input path="email" type="text" name="email" id="email"
                                                class="form-control px-2"
                                                style="border: 1px solid black"/>
                                </div>
                                <div class="col-lg-1 px-3"></div>
                                <div class="col-lg-2 px-3">
                                    <label for="fullName">Họ tên</label>
                                    <form:input path="fullName" type="text" name="fullName" id="fullName"
                                                class="form-control px-2"
                                                style="border: 1px solid black"/>
                                </div>
                                <div class="col-lg-1 px-3"></div>
                                <div class="col-lg-2 px-3   ">
                                    <label for="phoneNumber"><strong class="text-dark">Số điện thoại</strong></label>
                                    <form:input path="phoneNumber" type="text" name="phoneNumber" id="phoneNumber"
                                                class="form-control px-2"
                                                style="border: 1px solid black"/>
                                </div>
                                <div class="col-lg-1 px-3"></div>
                                <div class="col-lg-2 px-3   ">
                                    <label for="address"><strong class="text-dark">Địa chỉ</strong></label>
                                    <form:input path="address" type="text" name="address" id="address"
                                                class="form-control px-2"
                                                style="border: 1px solid black"/>
                                </div>
                            </div>

                            <div class="input-group py-3">
                                <div class="col-lg-3 px-4">
                                    <button type="button" class="btn btn-primary" id="btnSeachUser">
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

                            <div class="input-group">
                                <div class="col-lg-2 px-3">
                                    <label for="discount"><strong class="text-dark">Giảm giá trên mỗi đơn hàng (đ)</strong></label>
                                    <input type="number" name="discount" id="discount"
                                                class="rounded px-2"
                                                style="border: 1px solid black" value="${userSearchResponse.listResult.get(0).discount}"/>
                                </div>
                            </div>

                            <div class="input-group py-3">
                                <div class="col-lg-3 px-4">
                                    <button type="button" class="btn btn-primary" id="btnApplyDiscount">
                                        Áp dụng
                                    </button>
                                </div>
                            </div>

                            <div class="input-group py-3">
                                <div class="col-lg-3 px-4"></div>
                                <div class="col-lg-3 px-4"></div>
                                <div class="col-lg-3 px-4"></div>
                                <div class="col-lg-3 px-4">
                                    <button type="button" class="btn btn-facebook" id="btnAddUser"
                                            title="Thêm tài khoản cho 'Nhân viên bán hàng'">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                             fill="currentColor" class="bi bi-plus-circle" viewBox="0 0 16 16">
                                            <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
                                            <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4"/>
                                        </svg>
                                        <a href="${userAddURL}" class="text-white">Thêm</a>
                                    </button>
                                    &nbsp; &nbsp;
                                    <button type="reset" class="btn btn-dark-blue"
                                            onclick="btnLockOrUnlockGroupUsers(1)"
                                            title="Mở khóa những tài khoản được chọn">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                             fill="currentColor" class="bi bi-unlock-fill" viewBox="0 0 16 16">
                                            <path d="M11 1a2 2 0 0 0-2 2v4a2 2 0 0 1 2 2v5a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V9a2 2 0 0 1 2-2h5V3a3 3 0 0 1 6 0v4a.5.5 0 0 1-1 0V3a2 2 0 0 0-2-2"/>
                                        </svg>
                                        Mở hết
                                    </button>
                                    &nbsp; &nbsp;
                                    <button type="reset" class="btn btn-danger" onclick="btnLockOrUnlockGroupUsers(0)"
                                            title="Khóa những tài khoản được chọn">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                             fill="currentColor" class="bi bi-lock-fill" viewBox="0 0 16 16">
                                            <path d="M8 1a2 2 0 0 1 2 2v4H6V3a2 2 0 0 1 2-2m3 6V3a3 3 0 0 0-6 0v4a2 2 0 0 0-2 2v5a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2"/>
                                        </svg>
                                        Khóa hết
                                    </button>
                                </div>
                            </div>
                        </form:form>
                    </div>
                </div>

                <div class="card-body px-0 pb-2">
                    <div class="table-responsive p-0">

                        <display:table name="userSearchResponse.listResult" cellspacing="0"
                                       cellpadding="0"
                                       requestURI="${formURL}" partialList="true"
                                       sort="external"
                                       size="${userSearchResponse.totalItems}" defaultsort="2"
                                       defaultorder="ascending"
                                       id="tableList" pagesize="${userSearchResponse.maxPageItems}"
                                       export="false"
                                       class="table align-items-center table-striped table-bordered table-hover mb-0"
                                       style="margin: 0 1.5em;">
                            <display:column
                                    title="<fieldset class='input-group'> <input type='checkbox' id='checkAll'> </fieldset>"
                                    class="center select-cell"
                                    headerClass="center select-cell">
                                <fieldset>
                                    <input type="checkbox" name="checkList"
                                           value="${tableList.id}"
                                           id="id"/>
                                </fieldset>
                            </display:column>

                            <display:column
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8"
                                    title="Họ tên">
                                <div class="align-middle">
                                    <span class="text-secondary text-md font-weight-bold">${tableList.fullName}</span>
                                </div>
                            </display:column>

                            <display:column
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8"
                                    title="Trạng thái">
                                <div class="align-middle text-center">
                            <span class="text-secondary text-md font-weight-bold">
                              <c:if test="${tableList.isActive == 1}">Hoạt động</c:if>
                              <c:if test="${tableList.isActive != 1}">Khóa</c:if>
                            </span>
                                </div>
                            </display:column>

                            <display:column
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8"
                                    title="Ngày tạo">
                                <div class="align-middle text-center">
                                    <span class="text-secondary text-md font-weight-bold">${tableList.createdAt}</span>
                                </div>
                            </display:column>

                            <display:column
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8"
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
                                        <a href="/admin/user-detail-${tableList.id}"
                                           class="text-secondary font-weight-bold text-md text-white"
                                           title="Xem thông tin chi tiết của tài khoản">
                                            Chi tiết
                                        </a>
                                    </button>

                                    <!-- Lock if user is active, Unlock if user is locked -->
                                    <c:if test="${tableList.isActive == 1}">
                                        <button class="badge badge-circle bg-gradient-warning"
                                                style="text-transform: capitalize"
                                                onclick="lockSingleUser(${tableList.id})">
                                            <a href="javascript:;"
                                               class="text-secondary font-weight-bold text-md text-white"
                                               title="Khóa tài khoản" id="btnLockUser">
                                                Khóa
                                            </a>
                                        </button>
                                    </c:if>

                                    <c:if test="${tableList.isActive != 1}">
                                        <button class="badge badge-circle bg-gradient-faded-dark-blue"
                                                style="text-transform: capitalize"
                                                onclick="unlockSingleUser(${tableList.id})">
                                            <a href="javascript:;"
                                               class="text-secondary font-weight-bold text-md text-white"
                                               title="Mở khóa tài khoản">
                                                Mở khóa
                                            </a>
                                        </button>
                                    </c:if>
                                </div>
                            </display:column>
                            <display:setProperty name="paging.banner.one_item_found"
                                                 value="<br/><div class='ms-3 col-sm-6 align-left'><div class='infos'>Tìm thấy <b>1</b> tài khoản.</div></div>"/>

                            <display:setProperty name="basic.msg.empty_list"
                                                 value="Không tìm thấy kết quả"/>
                            <display:setProperty name="paging.banner.no_items_found"
                                                 value="<br/><div class='ms-3 col-sm-6 align-left'><div class='infos'>Không tìm thấy tài khoản nào.</div></div>"/>
                            <display:setProperty name="paging.banner.some_items_found"
                                                 value="<br/><div class='ms-3 col-sm-6 align-left'><div class='info-horizontal'>Tìm thấy <b>{0}</b> tài khoản, hiển thị từ {2} đến {3}.</div></div>"/>
                        </display:table>

                    </div>
                </div>
            </div>
        </div>
    </div>

</div>

<script>
    //----------------------------- Search user
    $('#btnSeachUser').click(function () {
        $('#form-search').submit();
    });

    //----------------------------- Clear search form
    $('#btnDeleteParams').click(function () {
        window.location.href("/admin/user-list");
    });

    // Check or uncheck all
    $('#checkAll').change(function (){
        let userIds = document.querySelectorAll('#id');

        if(this.checked){
            userIds.forEach(item => {
                item.setAttribute('checked', 'checked');
            });
        }
        else{
            userIds.forEach(item => {
                item.removeAttribute('checked');
            });
        }
    });

    //----------------------------- Lock SINGLE user
    function lockSingleUser(userId) {
        if (confirm("Bạn chắc chắn muốn KHÓA tài khoản này?")) {
            lockOrUnlockUser(userId, 0);
        }
    }

    //----------------------------- Unlock SINGLE user
    function unlockSingleUser(userId) {
        if (confirm('Bạn chắc chắn muốn MỞ KHÓA tài khoản này?')) {
            lockOrUnlockUser(userId, 1);
        }
    }

    //----------------------------- Lock, Unlock GROUP of user
    function btnLockOrUnlockGroupUsers(action) {
        let userIds = $('#tableList').find('tbody input[type=checkbox]:checked').map(function () {
            return $(this).val();
        }).get();

        console.log(userIds);

        if (userIds.length === 0) {
            alert('Bạn chưa chọn tài khoản nào!');
        } else {
            if (action === 0) {
                if (confirm('Bạn chắc chắn muốn KHÓA NHỮNG TÀI KHOẢN này?')) {
                    lockOrUnlockUser(userIds, action);
                }
            } else {
                if (confirm('Bạn chắc chắn muốn MỞ KHÓA NHỮNG TÀI KHOẢN này?')) {
                    lockOrUnlockUser(userIds, action);
                }
            }
        }
    }

    function lockOrUnlockUser(userIds, action) {
        $.ajax({
            url: "${userAPI}/lock/" + userIds + "?action=" + action,
            method: "PATCH",
            contentType: "application/json; charset=UTF-8",
            dataType: "JSON",
            success: function (result) {
                console.log(result);
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

    //----------Apply discount
    $('#btnApplyDiscount').click(function(){
        let discount = $('#discount').val();

        if(discount < 0){
            alert('Mức giảm giá phải từ 0đ trở lên!')
        }
        else if(confirm('Bạn chắc chắn muốn áp dụng mức giảm giá này cho tất cả người dùng?')){
            applyDiscount(discount);
        }
    });

    function applyDiscount(discount){
        $.ajax({
            url: "${userAPI}/discount?discount=" + discount,
            method: "PATCH",
            contentType: "application/json; charset=UTF-8",
            dataType: "JSON",
            success: function (result) {
                console.log(result);
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
</script>

</body>

</html>