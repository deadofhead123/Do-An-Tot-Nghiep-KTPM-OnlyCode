<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>
<c:url var="formURL" value="/admin/category-parent-list"/>
<c:url var="formAPI" value="/api/admin/categories"/>

<!DOCTYPE html>
<html lang="en">

<head>
    <title>Danh mục sản phẩm</title>
</head>

<body class="g-sidenav-show  bg-gray-100">

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

<div class="container-fluid py-2">

    <!-- User list -->
    <div class="row">
        <div class="col-12">
            <div class="card my-4">
                <div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
                    <div class="bg-gradient-dark shadow-dark border-radius-lg pt-4 pb-3">
                        <h6 class="text-white ps-3">Danh sách danh mục cha</h6>
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
                        </form:form>
                    </div>
                </div>

                <div class="card-body px-0 pb-2">
                    <div class="table-responsive p-0">

                        <display:table name="categorySearchResponseList.listResult" cellspacing="0"
                                       cellpadding="0"
                                       requestURI="${formURL}" partialList="true"
                                       sort="external"
                                       size="${categorySearchResponseList.totalItems}" defaultsort="2"
                                       defaultorder="ascending"
                                       id="tableList" pagesize="${categorySearchResponseList.maxPageItems}"
                                       export="false"
                                       class="table table-striped table-bordered table-hover aligns-item-center"
                                       style="margin: 0 1.5em;">
                            <display:column
                                    title="<fieldset class='input-group'> <input type='checkbox' id='checkAll'> </fieldset>"
                                    class="center select-cell"
                                    headerClass="center selected-cell">
                                <fieldset>
                                    <input type="checkbox" name="checkList"
                                           value="${tableList.id}"
                                           id="id"/>
                                </fieldset>
                            </display:column>

                            <display:column headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8" sortable="true" sortName="name"
                                    title="Tên danh mục">
                                <div class="align-middle">
                                    <span class="text-secondary text-md font-weight-bold">${tableList.name}</span>
                                </div>
                            </display:column>

                            <display:column headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8"
                                    title="Mô tả">
                                <div class="align-middle text-center">
                                    <span class="text-secondary text-md font-weight-bold">${tableList.description}</span>
                                </div>
                            </display:column>

                            <display:column
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8" sortable="true" sortName="createdAt"
                                    title="Ngày tạo">
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
                        </display:table>

                    </div>
                </div>
            </div>
        </div>
    </div>

</div>

<script>
    //----------------------------- Search category
    $(document).ready(function(){
        setTimeout(function (){
            $('#alertResult').hide();
        }, 2000);
    });

    $('#btnSearch').click(function () {
        $('#form-search').submit();
    });

    //----------------------------- Clear search form
    $('#btnDeleteParams').click(function () {
        window.location.href = "/admin/category-parent-list";
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
            deleteCategory(categoryId);
        }
    }

    function deleteCategory(categoryIds) {
        $.ajax({
            url: "${formAPI}/" + categoryIds,
            method: "PATCH",
            contentType: "application/json; charset=UTF-8",
            dataType: "JSON",
            success: function (result) {
                <%--if(result.data === "delete_success"){--%>
                <%--    window.location.href = "<c:url value='/admin/category-parent-list?message=delete_success'/>";--%>
                <%--}--%>
                alert(result.message);
                location.reload();
            },
            error: function (result) {
                alert(result.responseJSON.message);
                <%--window.location.href = "<c:url value='/admin/category-parent-list?message=error_system'/>";--%>
            }
        });
    }
</script>

</body>

</html>