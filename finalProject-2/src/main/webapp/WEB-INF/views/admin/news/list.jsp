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
    <c:if test="${not empty messageResponse}">
        <div class="row">
            <div class="col-12 col-xl-5"></div>
            <div class="col-12 col-xl-4">
                <div id="alertResult" class="alert alert-block alert-${alert} text-white w-lg-50 text-xxl-center">
                        ${messageResponse}
                </div>
            </div>
        </div>
    </c:if>

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
                                    <label for="name"><strong class="text-dark">Tên tin tức</strong></label>
                                    <form:input path="name" type="text" name="name" id="name"
                                                class="form-control px-2"
                                                style="border: 1px solid black"/>
                                </div>

                                <div class="col-lg-3 px-3">
                                    <label for="description"><strong class="text-dark">Mô tả</strong></label>
                                    <form:input path="description" type="text" name="description" id="description"
                                                class="form-control px-2"
                                                style="border: 1px solid black"/>
                                </div>

                                <div class="col-lg-2 px-3">
                                    <label for="description"><strong class="text-dark">Loại tin tức</strong></label>
                                    <form:select path="type" name="type" id="type" class="form-select px-2" style="border: 1px solid black">
                                        <form:option value="" label="--------------Chọn loại--------------"/>
                                        <form:options items="${typeList}"/>
                                    </form:select>
                                </div>

                                <div class="col-lg-2 px-3">
                                    <label for="hot"><strong class="text-dark">Tin tức nổi bật</strong></label>
                                    <form:select path="hot" id="hot" name="hot"
                                                 class="form-select px-2"
                                                 style="border: 1px solid black">
                                        <form:option value="" label="--------------Chọn kiểu--------------"/>
                                        <form:options items="${hotType}"/>
                                    </form:select>
                                </div>
                            </div>
                            <br>
                            <div class="input-group">
                                <div class="col-lg-3 px-3">
                                    <label for="viewFrom"><strong class="text-dark">Lượt xem từ</strong></label>
                                    <form:input path="viewFrom" type="number" name="viewFrom" id="viewFrom"
                                                class="form-control px-2"
                                                style="border: 1px solid black"/>
                                </div>

                                <div class="col-lg-3 px-3">
                                    <label for="viewTo"><strong class="text-dark">Lượt xem đến</strong></label>
                                    <form:input path="viewTo" type="number" name="viewTo" id="viewTo"
                                                class="form-control px-2"
                                                style="border: 1px solid black"/>
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

                <div class="card-body px-0 pb-2">
                    <div class="table-responsive p-0">

                        <display:table name="newsSearchResponse.listResult" cellspacing="0"
                                       cellpadding="0"
                                       requestURI="${formURI}" partialList="true"
                                       sort="external"
                                       size="${newsSearchResponse.totalItems}" defaultsort="2"
                                       defaultorder="ascending"
                                       id="tableList" pagesize="${newsSearchResponse.maxPageItems}"
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
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8"
                                    title="Tên tin tức">
                                <div class="align-middle text-center">
                                    <span class="text-secondary text-md font-weight-bold">${tableList.name}</span>
                                </div>
                            </display:column>

                            <display:column
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8"
                                    title="Mô tả tin tức">
                                <div class="align-middle text-center">
                                    <span class="text-secondary text-md font-weight-bold">${tableList.description}</span>
                                </div>
                            </display:column>

                            <display:column
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8"
                                    title="Lượt xem">
                                <div class="align-middle text-center">
                                    <span class="text-secondary text-md font-weight-bold">${tableList.view}</span>
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
            deleteNews(newsId);
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
        $.ajax({
            url: "${formAPI}/" + newsIds,
            method: "PATCH",
            contentType: "application/json; charset=UTF-8",
            dataType: "JSON",
            success: function (result) {
                console.log(result);

                // if (result.data === "delete_success") {
                //     window.location.href = "/admin/news-list?message=delete_success";
                // }
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