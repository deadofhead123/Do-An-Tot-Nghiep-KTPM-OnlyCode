<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>
<c:url var="formURL" value="/admin/category-child-list"/>
<c:url var="formAPI" value="/api/admin/categories"/>

<!DOCTYPE html>
<html lang="en">

<head>
    <title>Danh mục sản phẩm (con)</title>
</head>

<body class="g-sidenav-show  bg-gray-100">

<div class="container-fluid py-2">

    <!-- User list -->
    <div class="row">
        <div class="col-12">
            <div class="card my-4">
                <div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
                    <div class="bg-gradient-dark shadow-dark border-radius-lg pt-4 pb-3">
                        <h6 class="text-white ps-3">Danh sách danh mục con</h6>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12 mx-3 my-3">
                        <form:form method="get" modelAttribute="categorySearch" id="form-search">
                            <!-- Row 1 -->
                            <div class="input-group">
                                <div class="col-lg-3 px-3">
                                    <label for="name"><strong class="text-dark">Tên danh mục</strong></label>
                                    <form:input path="name" type="text" name="name" id="name"
                                                class="form-control px-2"
                                                style="border: 1px solid black"/>
                                </div>

                                <div class="col-lg-3 px-3">
                                    <label for="parentId"><strong class="text-dark">Danh mục cha</strong></label>
                                    <form:select path="parentId" name="parentId" id="parentId"
                                                 class="form-select px-2"
                                                 style="border: 1px solid black">
                                        <form:option value=""
                                                     label="-------------------Chọn danh mục cha--------------------"/>
                                        <form:options items="${parentCategories}"/>
                                    </form:select>
                                </div>
                            </div>

                            <div class="input-group py-3">
                                <div class="col-lg-3 px-4">
                                    <button type="button" class="btn btn-primary" id="btnSearch">
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
                                <div class="col-lg-10 px-4"></div>
                                <div class="col-lg-2 px-4">
                                    &nbsp; &nbsp;
                                    <button type="reset" class="btn btn-danger" id="btnDeleteAllCategory"
                                            title="Xóa các danh mục được chọn">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                             fill="currentColor" class="bi bi-lock-fill" viewBox="0 0 16 16">
                                            <path d="M8 1a2 2 0 0 1 2 2v4H6V3a2 2 0 0 1 2-2m3 6V3a3 3 0 0 0-6 0v4a2 2 0 0 0-2 2v5a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2"/>
                                        </svg>
                                        Xóa hết
                                    </button>
                                </div>
                            </div>
                        </form:form>
                    </div>
                </div>

                <div class="row">
                    <c:choose>
                        <c:when test="${categorySearchResponseList.totalItems % categorySearchResponseList.maxPageItems != 0}">
                            <c:set var="finalPage"
                                   value="${categorySearchResponseList.totalItems / categorySearchResponseList.maxPageItems + 1}"/>
                        </c:when>
                        <c:otherwise>
                            <c:set var="finalPage"
                                   value="${categorySearchResponseList.totalItems / categorySearchResponseList.maxPageItems}"/>
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

                        <display:table name="categorySearchResponseList.listResult" cellspacing="0"
                                       cellpadding="0"
                                       requestURI="${formURL}" partialList="false"
                                       sort="external"
                                       size="${categorySearchResponseList.totalItems}" defaultsort="2"
                                       defaultorder="ascending"
                                       id="tableList" pagesize="${categorySearchResponseList.maxPageItems}"
                                       export="true"
                                       class="table align-items-center table-striped table-bordered table-hover mb-0"
                                       style="margin: 0 1.5em;">
                            <display:column
                                    title="<fieldset class='input-group justify-content-xxl-center align-items-xxl-center'> <input type='checkbox' id='checkAll'> </fieldset>"
                                    class="center select-cell"
                                    headerClass="justify-content-xxl-center align-items-xxl-center">
                                <fieldset>
                                    <input type="checkbox" name="checkList"
                                           value="${tableList.id}"
                                           id="id"/>
                                </fieldset>
                            </display:column>

                            <display:column
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8" sortable="true" sortName="name"
                                    title="Tên danh mục">
                                <div class="align-middle">
                                    <span class="text-secondary text-md font-weight-bold">${tableList.name}</span>
                                </div>
                            </display:column>

                            <display:column
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8"
                                    title="Mô tả">
                                <div class="align-middle text-center">
                                    <span class="text-secondary text-md font-weight-bold">${tableList.description}</span>
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
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8" sortable="true" sortName="createdAt"
                                    title="Thời gian sửa">
                                <div class="align-middle text-center">
                                    <span class="text-secondary text-md font-weight-bold"><fmt:formatDate value="${tableList.modifiedAt}" pattern="HH:mm:ss, dd/MM/yyyy"/></span>
                                </div>
                            </display:column>

                            <display:column
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8"
                                    title="Thao tác">
                                <div class="align-middle text-center">
                                    <button class="badge badge-circle bg-gradient-info"
                                            style="text-transform: capitalize">
                                        <a href="/admin/category-edit-${tableList.id}"
                                           class="text-secondary font-weight-bold text-md text-white"
                                           title="Cập nhật thông tin danh mục">
                                            Cập nhật
                                        </a>
                                    </button>

                                    <button class="badge badge-circle bg-gradient-warning"
                                            style="text-transform: capitalize"
                                            onclick="deleteSingleCategory(${tableList.id})">
                                        <a href="#"
                                           class="text-secondary font-weight-bold text-md text-white"
                                           title="Xóa danh mục">
                                            Xóa
                                        </a>
                                    </button>
                                </div>
                            </display:column>
                            <display:setProperty name="paging.banner.one_item_found"
                                                 value="<br/><div class='ms-3 col-sm-6 align-left'><div class='infos'>Tìm thấy <b>1</b> danh mục.</div></div>"/>
                            <display:setProperty name="paging.banner.all_items_found"
                                                 value="<br/><div class='ms-3 col-sm-6 infoBar align-left' style='margin-bottom: 20px;'><div class='infos'>Tìm thấy {0} danh mục.</div></div>"/>
                            <display:setProperty name="basic.msg.empty_list"
                                                 value="Không tìm thấy danh mục nào."/>
                            <display:setProperty name="paging.banner.no_items_found"
                                                 value="<br/><div class='ms-3 col-sm-6 align-left'><div class='infos'>Không tìm thấy danh mục nào.</div></div>"/>
                            <display:setProperty name="paging.banner.some_items_found"
                                                 value="<br/><div class='ms-3 col-sm-6 align-left'><div class='info-horizontal'>Tìm thấy <b>{0}</b> danh mục, hiển thị từ {2} đến {3}.</div></div>"/>
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

    $(document).ready(function (){
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


    //----------------------------- Search category
    $('#btnSearch').click(function () {
        $('#form-search').submit();
    });

    //----------------------------- Clear search form
    $('#btnDeleteParams').click(function () {
        window.location.assign("/admin/category-child-list");
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

    function deleteSingleCategory(categoryId){
        if(confirm("Bạn chắc chắn muốn xóa danh mục này?")){
            deleteCategory([categoryId]);
        }
    }

    $('#btnDeleteAllCategory').click(function(){
        let categoryIds = $('#tableList').find("tbody td input[type=checkbox]:checked").map(function(){
            return this.value;
        }).get();

        console.log(categoryIds);

        if(categoryIds.length === 0){
            alert('Bạn chưa chọn danh mục con nào để xóa!');
        }
        else{
            if(confirm("Bạn chắc chắn muốn xóa các danh mục được chọn?")){
                deleteCategory(categoryIds);
            }
        }
    });

    function deleteCategory(categoryIds) {
         // Find last page
        let totalItems = ${categorySearchResponseList.totalItems};
        let maxPageItems = ${categorySearchResponseList.maxPageItems};
        let finalPage = Math.ceil(totalItems / maxPageItems);

        $.ajax({
            url: "${formAPI}/" + categoryIds,
            method: "PATCH",
            contentType: "application/json; charset=UTF-8",
            dataType: "JSON",
            success: function (result) {
                // When deleting, back to previous page if this isn't page 1
                if (currentPageString !== "") {
                    // If current page is final; and you delete all record in this page, create an URL with previous page of this page
                    if (page !== 1 && page === finalPage && (categoryIds.length) === (document.querySelectorAll('#id').length)) {
                        page--;
                        currentURL = currentURL.replace(currentPageString, "p=" + page); // replace old page string
                    }
                }

                alert(result.message);
                window.location.href = currentURL;
            },
            error: function (result) {
                alert(result.responseJSON.message);
                <%--window.location.href = "<c:url value='/admin/category-child-list?message=error_system'/>";--%>
            }
        });
    }
</script>

</body>

</html>