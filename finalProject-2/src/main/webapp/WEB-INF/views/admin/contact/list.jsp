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
<%@include file="/common/taglib.jsp" %>
<c:url var="formURI" value="/admin/contact-list"/>

<!DOCTYPE html>
<html lang="en">

<head>
    <title>Liên hệ</title>
</head>

<body class="g-sidenav-show  bg-gray-100">

<div class="container-fluid py-2">

    <!-- User list -->
    <div class="row">
        <div class="col-12">
            <div class="card my-4">
                <div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
                    <div class="bg-gradient-dark shadow-dark border-radius-lg pt-4 pb-3">
                        <h6 class="text-white text-capitalize ps-3">Danh sách liên hệ</h6>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12 mx-3 my-3">
                        <form:form method="get" modelAttribute="contactSearch" id="form-search">
                            <!-- Row 1 -->
                            <div class="input-group">
                                <div class="col-lg-2 px-2">
                                    <label for="email"><strong>Email</strong></label>
                                    <form:input path="email" type="text" name="email" id="email"
                                                class="form-control px-2"
                                                style="border: 1px solid black"/>
                                </div>

                                <div class="col-lg-2 px-2">
                                    <label for="fullName"><strong>Họ tên</strong></label>
                                    <form:input path="fullName" type="text" name="fullName" id="fullName"
                                                class="form-control px-2"
                                                style="border: 1px solid black"/>
                                </div>

                                <div class="col-lg-2 px-2">
                                    <label for="phoneNumber"><strong>Số điện thoại</strong></label>
                                    <form:input path="phoneNumber" type="text" name="phoneNumber" id="phoneNumber"
                                                class="form-control px-2"
                                                style="border: 1px solid black"/>
                                </div>

                                <div class="col-lg-2 px-2">
                                    <label for="status"><strong>Tình trạng</strong></label>
                                    <form:select path="status" name="status" id="status"
                                                 class="form-control px-2"
                                                 style="border: 1px solid black">
                                        <form:options items="${listType}"/>
                                    </form:select>
                                </div>
                            </div>

                            <div class="input-group py-3">
                                <div class="col-lg-2 px-4">
                                    <button type="button" class="btn btn-primary" id="btnSearchContact">
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

                <div class="row">
                    <c:choose>
                        <c:when test="${contactResponseList.totalItems % contactResponseList.maxPageItems != 0}">
                            <c:set var="finalPage"
                                   value="${contactResponseList.totalItems / contactResponseList.maxPageItems + 1}"/>
                        </c:when>
                        <c:otherwise>
                            <c:set var="finalPage"
                                   value="${contactResponseList.totalItems / contactResponseList.maxPageItems}"/>
                        </c:otherwise>
                    </c:choose>

                    <div class="col-lg-12 mx-3 my-3">
                        <div class="input-group">
                            <div class="col-lg-3 px-3 py-3">
                                <label style="color: black; font-size: 16px;"><strong>Trang:</strong></label>&nbsp;
                                <span style="max-height: 70px; overflow-y: auto;">
                                    <select id="pageSelect">
                                        <c:forEach var="singlePage" begin="1" end="${finalPage}" step="1">
                                            <option value="${singlePage}">${singlePage}</option>
                                        </c:forEach>
                                    </select>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card-body px-0 pb-2">
                    <div class="table-responsive p-0">

                        <display:table name="contactResponseList.listResult" cellspacing="0"
                                       cellpadding="0"
                                       requestURI="${formURI}" partialList="false"
                                       sort="external"
                                       size="${contactResponseList.totalItems}" defaultsort="2"
                                       defaultorder="ascending"
                                       id="tableList"
                                       pagesize="${contactResponseList.maxPageItems}"
                                       export="true"
                                       class="table align-items-center table-striped table-bordered table-hover mb-0"
                                       style="margin: 0 1.5em;" >
                            <display:column
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8" sortable="true" sortName="fullName"
                                    title="Họ tên">
                                <div class="align-middle">
                                    <span class="text-secondary text-md font-weight-bold">${tableList.fullName}</span>
                                </div>
                            </display:column>

                            <display:column
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8" sortable="true" sortName="email"
                                    title="Email">
                                <div class="align-middle text-center">
                                    <span class="text-secondary text-md font-weight-bold">${tableList.email}</span>
                                </div>
                            </display:column>

                            <display:column
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8" sortable="true" sortName="phoneNumber"
                                    title="Số điện thoại">
                                <div class="align-middle text-center">
                                    <span class="text-secondary text-md font-weight-bold">${tableList.phoneNumber}</span>
                                </div>
                            </display:column>

                            <display:column
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8" sortable="true" sortName="createdAt"
                                    title="Thời gian tạo">
                                <div class="align-middle text-center">
                                    <span class="text-secondary text-md font-weight-bold"><fmt:formatDate value="${tableList.createdAt}" pattern="HH:mm:ss, dd/MM/yyyy"/></span>
                                </div>
                            </display:column>

                            <display:column
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8" sortable="true" sortName="modifiedAt"
                                    title="Thời gian sửa">
                                <div class="align-middle text-center">
                                    <span class="text-secondary text-md font-weight-bold"><fmt:formatDate value="${tableList.modifiedAt}" pattern="HH:mm:ss, dd/MM/yyyy"/></span>
                                </div>
                            </display:column>

                            <display:column
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8"
                                    title="Thao tác">
                                <div class="align-middle text-center">
                                    <c:if test="${tableList.reply != null}">
                                        <button class="badge badge-circle bg-gradient-faded-info"
                                                style="text-transform: capitalize">
                                            <a href="/admin/contact-edit-${tableList.id}"
                                               class="text-secondary font-weight-bold text-md text-white"
                                               title="Xem thông tin chi tiết của liên hệ">
                                                Chi tiết
                                            </a>
                                        </button>
                                    </c:if>

                                    <c:if test="${tableList.reply == null}">
                                        <button class="badge badge-circle bg-gradient-info"
                                                style="text-transform: capitalize">
                                            <a href="/admin/contact-edit-${tableList.id}"
                                               class="text-secondary font-weight-bold text-md text-white"
                                               title="Trả lời liên hệ">
                                                Trả lời
                                            </a>
                                        </button>
                                    </c:if>
                                </div>
                            </display:column>
                            <display:setProperty name="paging.banner.one_item_found"
                                                 value="<br/><div class='ms-3 col-sm-6 align-left'><div class='infos'>Tìm thấy <b>1</b> kết quả.</div></div>"/>
                            <display:setProperty name="paging.banner.all_items_found"
                                                 value="<br/><div class='ms-3 col-sm-6 infoBar align-left' style='margin-bottom: 20px;'><div class='infos'>Tìm thấy {0} kết quả.</div></div>"/>
                            <display:setProperty name="basic.msg.empty_list"
                                                 value="Không tìm thấy kết quả"/>
                            <display:setProperty name="paging.banner.no_items_found"
                                                 value="<br/><div class='ms-3 col-sm-6 align-left'><div class='infos'>Không tìm thấy kết quả nào.</div></div>"/>
                            <display:setProperty name="paging.banner.some_items_found"
                                                 value="<br/><div class='ms-3 col-sm-6 align-left'><div class='info-horizontal'>Tìm thấy <b>{0}</b> kết quả, hiển thị từ {2} đến {3}.</div></div>"/>
                            <display:setProperty name="export.banner"
                                                 value="<br/><div class='ms-4 col-sm-6 align-left'><div class='infos'>Xuất {0}</div></div>"/>
                        </display:table>

                    </div>
                </div>
            </div>
        </div>
    </div>

</div>

<script>
    let currentURL = window.location.href;
    let currentPageString = "", page = 1;

    $(document).ready(function () {
        getPageOnURL();

        $('#pageSelect').val(page);
    });

    function getPageOnURL() {
        // Set page for page choosing select
        let startPageIdxString;

        let endPageIdxString = currentURL.indexOf("p=");
        if (endPageIdxString !== -1) {
            startPageIdxString = endPageIdxString;
            page = "";

            // find page's value (a string)
            for (endPageIdxString = endPageIdxString + 2; endPageIdxString < currentURL.length; endPageIdxString++) {
                let currentChar = currentURL[endPageIdxString];

                if (currentChar >= "0" && currentChar <= "9") page += currentChar;
                else break;
            }

            page = parseInt(page);
            currentPageString = currentURL.substring(startPageIdxString, endPageIdxString);
        }
    }

    //----------------------------- Direct to page selected with page choosen in #pageSelect
    $('#pageSelect').change(function () {
        // When deleting, back to previous page if this isn't page 1
        let pageToDirect = parseInt(this.value);

        // Get current page
        if (currentPageString !== "") {
            currentURL = currentURL.replace(currentPageString, "p=" + parseInt(this.value)); // replace old page string
        } else {
            currentURL += "?${tableId}=" +pageToDirect;
        }

        window.location.href = currentURL;
    });

    //----------------------------- Search contact
    $('#btnSearchContact').click(function () {
        $('#form-search').submit();
    });

    //----------------------------- Clear search form
    $('#btnDeleteParams').click(function () {
        window.location.href = "/admin/contact-list";
    });
</script>

</body>

</html>