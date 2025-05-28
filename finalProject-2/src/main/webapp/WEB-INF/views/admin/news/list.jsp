<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>
<c:url var="formAPI" value="/api/admin/news"/>
<c:url var="formURI" value="/admin/news-list"/>

<!DOCTYPE html>
<html lang="en">

<head>
    <title>Tin tức</title>
</head>

<body class="g-sidenav-show  bg-gray-100">

<div class="container-fluid py-2">
    <!-- User list -->
    <div class="row">
        <div class="col-12">
            <div class="card my-4">
                <div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
                    <div class="bg-gradient-dark shadow-dark border-radius-lg pt-4 pb-3">
                        <h6 class="text-white text-capitalize ps-3">Danh sách tin tức</h6>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12 mx-3 my-3">
                        <form:form method="get" modelAttribute="newsSearch" id="form-search">
                            <!-- Row 1 -->
                            <div class="input-group">
                                <div class="col-lg-3 px-3">
                                    <label for="name"><strong class="text-dark" style="font-size: 15px;">Tên tin tức</strong></label>
                                    <form:input path="name" type="text" name="name" id="name"
                                                class="form-control px-2"
                                                style="border: 1px solid black; font-size: 17px;"/>
                                </div>

                                <div class="col-lg-3 px-3">
                                    <label for="description"><strong class="text-dark" style="font-size: 15px;">Mô tả</strong></label>
                                    <form:input path="description" type="text" name="description" id="description"
                                                class="form-control px-2"
                                                style="border: 1px solid black; font-size: 17px;"/>
                                </div>

                                <div class="col-lg-2 px-3">
                                    <label for="description"><strong class="text-dark" style="font-size: 15px;">Loại tin tức</strong></label>
                                    <form:select path="type" name="type" id="type" class="form-select px-2" style="border: 1px solid black; font-size: 17px;">
                                        <form:option value="" label="----------Chọn loại--------------"/>
                                        <form:options items="${typeList}"/>
                                    </form:select>
                                </div>

                                <div class="col-lg-2 px-3">
                                    <label for="hot"><strong class="text-dark" style="font-size: 15px;">Tin tức nổi bật</strong></label>
                                    <form:select path="hot" id="hot" name="hot"
                                                 class="form-select px-2"
                                                 style="border: 1px solid black; font-size: 17px;">
                                        <form:option value="" label="----------Chọn kiểu--------------"/>
                                        <form:options items="${hotType}"/>
                                    </form:select>
                                </div>
                            </div>
                            <br>
                            <div class="input-group">
                                <div class="col-lg-3 px-3">
                                    <label for="viewFrom"><strong class="text-dark" style="font-size: 15px;">Lượt xem từ</strong></label>
                                    <form:input path="viewFrom" type="number" name="viewFrom" id="viewFrom"
                                                class="form-control px-2"
                                                style="border: 1px solid black; font-size: 17px;"/>
                                </div>

                                <div class="col-lg-3 px-3">
                                    <label for="viewTo"><strong class="text-dark" style="font-size: 15px;">Lượt xem đến</strong></label>
                                    <form:input path="viewTo" type="number" name="viewTo" id="viewTo"
                                                class="form-control px-2"
                                                style="border: 1px solid black; font-size: 17px;"/>
                                </div>
                            </div>

                            <div class="input-group py-3">
                                <div class="col-lg-3 px-4">
                                    <button type="button" class="btn btn-primary" id="btnSeachNews">
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
                                            title="Thêm tin tức">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                             fill="currentColor" class="bi bi-plus-circle" viewBox="0 0 16 16">
                                            <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
                                            <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4"/>
                                        </svg>
                                        <a href="/admin/news-edit" class="text-white">Thêm mới</a>
                                    </button>
                                    &nbsp; &nbsp;
                                    <button type="reset" class="btn btn-danger" onclick="btnDeleteGroupNews()"
                                            title="Xóa những tin tức được chọn">
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
                        <c:when test="${newsSearchResponse.totalItems % newsSearchResponse.maxPageItems != 0}">
                            <c:set var="finalPage"
                                   value="${newsSearchResponse.totalItems / newsSearchResponse.maxPageItems + 1}"/>
                        </c:when>
                        <c:otherwise>
                            <c:set var="finalPage"
                                   value="${newsSearchResponse.totalItems / newsSearchResponse.maxPageItems}"/>
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

                        <display:table name="newsSearchResponse.listResult" cellspacing="0"
                                       cellpadding="0"
                                       requestURI="${formURI}" partialList="false"
                                       sort="external"
                                       size="${newsSearchResponse.totalItems}"
                                       defaultsort="2" defaultorder="ascending"
                                       id="tableList"
                                       pagesize="${newsSearchResponse.maxPageItems}"
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
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8"
                                    title="Ảnh đại diện">
                                <div class="align-middle text-center">
                                    <c:if test="${not empty tableList.image}">
                                        <c:set var="imagePath" value="/repository${tableList.image}"/>
                                        <img src="${imagePath}" id="viewImage" width="100" height="100"
                                             style="margin-top: 5px; margin-bottom: 5px" alt="Không tìm thấy ảnh">
                                    </c:if>

                                    <!--Hiện ảnh đại diện mặc định-->
                                    <c:if test="${empty tableList.image}">
                                        <img src="/admin/image/default.png" id="viewImage" width="100" height="100"
                                             alt="Chưa có ảnh">
                                    </c:if>
                                </div>
                            </display:column>

                            <display:column
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8" sortable="true" sortName="name"
                                    title="Tên tin tức">
                                <div class="align-middle text-center">
                                    <span class="text-secondary text-md font-weight-bold">${tableList.name}</span>
                                </div>
                            </display:column>

<%--                            <display:column--%>
<%--                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8" style="height: 200px;"--%>
<%--                                    title="Mô tả tin tức">--%>
<%--                                <div class="align-middle text-center">--%>
<%--                                    <span class="text-secondary text-md font-weight-bold">${tableList.description}</span>--%>
<%--                                </div>--%>
<%--                            </display:column>--%>

                            <display:column
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8" sortable="true" sortName="views"
                                    title="Lượt xem">
                                <div class="align-middle text-center">
                                    <span class="text-secondary text-md font-weight-bold">${tableList.view}</span>
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
                                    <button class="badge badge-circle bg-gradient-info"
                                            style="text-transform: capitalize">
                                        <a href="/admin/news-edit-${tableList.id}"
                                           class="text-secondary font-weight-bold text-md text-white"
                                           title="Xem, cập nhật thông tin chi tiết của tin tức">
                                            Cập nhật
                                        </a>
                                    </button>

                                    <button class="badge badge-circle bg-gradient-warning"
                                            style="text-transform: capitalize"
                                            onclick="deleteSingleNews(${tableList.id})">
                                        <a href="javascript:;"
                                           class="text-secondary font-weight-bold text-md text-white"
                                           title="Xóa tin tức" id="btnDeleteNews">
                                            Xóa
                                        </a>
                                    </button>
                                </div>
                            </display:column>
                            <display:setProperty name="paging.banner.one_item_found"
                                                 value="<br/><div class='ms-3 col-sm-6 align-left'><div class='infos'>Tìm thấy <b>1</b> tin tức.</div></div>"/>
                            <display:setProperty name="paging.banner.all_items_found"
                                                 value="<br/><div class='ms-3 col-sm-6 align-left'><div class='infos'>Tìm thấy <b>{0}</b> tin tức.</div></div>"/>

                            <display:setProperty name="basic.msg.empty_list"
                                                 value="Không tìm thấy kết quả"/>
                            <display:setProperty name="paging.banner.no_items_found"
                                                 value="<br/><div class='ms-3 col-sm-6 align-left'><div class='infos'>Không tìm thấy tin tức nào.</div></div>"/>
                            <display:setProperty name="paging.banner.some_items_found"
                                                 value="<br/><div class='ms-3 col-sm-6 align-left'><div class='info-horizontal'>Tìm thấy <b>{0}</b> tin tức, hiển thị từ {2} đến {3}.</div></div>"/>
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

    //----------------------------- Search user
    $('#btnSeachNews').click(function () {
        $('#form-search').submit();
    });

    //----------------------------- Clear search form
    $('#btnDeleteParams').click(function () {
        window.location.href = "/admin/news-list";
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

    //----------------------------- Delete single news
    function deleteSingleNews(newsId) {
        if (confirm("Bạn chắc chắn muốn XÓA TIN TỨC này?")) {
            deleteNews([newsId]);
        }
    }

    //----------------------------- Delete all news selected
    function btnDeleteGroupNews() {
        let newsIds = $('#tableList').find('tbody input[type=checkbox]:checked').map(function () {
            return $(this).val();
        }).get();

        console.log(newsIds);

        if (newsIds.length === 0) {
            alert('Bạn chưa chọn tin tức nào!');
        } else {
            if (confirm('Bạn chắc chắn muốn XÓA NHỮNG TIN TỨC này?')) {
                deleteNews(newsIds);
            }
        }
    }

    function deleteNews(newsIds) {
        // Find last page
        let totalItems = ${newsSearchResponse.totalItems};
        let maxPageItems = ${newsSearchResponse.maxPageItems};
        let finalPage = Math.ceil(totalItems / maxPageItems);

        $.ajax({
            url: "${formAPI}/" + newsIds,
            method: "PATCH",
            contentType: "application/json; charset=UTF-8",
            dataType: "JSON",
            success: function (result) {
                // When deleting, back to previous page if this isn't page 1
                if (currentPageString !== "") {
                    // If current page is final; and you delete all record in this page, create an URL with previous page of this page
                    if (page !== 1 && page === finalPage && (newsIds.length) === (document.querySelectorAll('#id').length)) {
                        page--;
                        currentURL = currentURL.replace(currentPageString, "p=" + page); // replace old page string
                    }
                }

                alert(result.message);
                window.location.href = currentURL;
            },
            error: function (result) {
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