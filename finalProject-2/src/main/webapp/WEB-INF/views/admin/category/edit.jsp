<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>
<c:url var="editCategoryURL" value="/api/admin/categories"/>

<!DOCTYPE html>
<html lang="en">

<head>
    <title>Danh mục sản phẩm</title>
</head>

<body class="g-sidenav-show bg-gray-100">

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

<div class="container-fluid px-2 px-md-6">
    <div class="page-header min-height-300 border-radius-xl mt-4"
         style="background-image: url('/web-user/images/bg_1.jpg');">
        <span class="mask bg-gradient-dark  opacity-1"></span>
    </div>

    <div class="card card-body mx-2 mx-md-2 mt-n6">
        <form:form method="get" id="form-edit" name="form-edit" modelAttribute="categoryEdit">
            <form:input path="id" type="hidden" id="id" name="id"/>
            <div class="row gx-4 mb-2">
                <div class="col-auto my-auto">
                    <div class="h-100 align-items-center">
                        <c:if test="${categoryEdit.id == null}">
                            <h4 class="mb-1">Thêm danh mục</h4>
                        </c:if>

                        <c:if test="${categoryEdit.id != null}">
                            <h4 class="mb-1">Sửa thông tin danh mục</h4>
                        </c:if>
                    </div>
                </div>
            </div>

            <div class="row">
                <!-- Contact Information -->
                <div class="col-12 col-xl-4"></div>
                <div class="col-12 col-xl-4">
                    <div class="card card-plain h-100">
                        <div class="card-header pb-0 p-3">
                            <div class="row">
                                <div class="col-md-8 d-flex align-items-center">
                                    <c:if test="${categoryEdit.id == null}">
                                        <h6 class="mb-0">Điền các thông tin cần thiết</h6>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="form-group py-1">
                                <label for="parentId"><strong class="text-dark">Danh mục cha</strong>&nbsp;(không chọn
                                    phần này nếu bạn muốn tạo danh mục cha)</label>
                                <form:select path="parentId" name="parentId" id="parentId" class="form-select px-2"
                                             style="border: 1px solid black">
                                    <c:if test="${categoryEdit.id == null}">
                                        <form:option value=""
                                                     label="-------------------------Chọn danh mục cha------------------------"/>
                                    </c:if>
                                    <c:if test="${categoryEdit.id != null}">
                                        <form:option value=""
                                                     label="-------------------------Để làm danh mục cha----------------------"/>
                                    </c:if>
                                    <form:options items="${parentCategories}"/>
                                </form:select>
                            </div>

                            <div class="form-group py-1">
                                <label for="name"><strong class="text-dark">Tên danh mục</strong></label>
                                <c:if test="${categoryEdit.id == null}">
                                    <form:input path="name" name="name" id="name" class="form-control px-2"
                                                style="border: 1px solid black"/>
                                </c:if>
                                <c:if test="${categoryEdit.id != null}">
                                    <form:input path="name" name="name" id="name" class="form-control px-2"
                                                style="border: 1px solid black" readonly="true"/>
                                </c:if>
                            </div>

                            <div class="form-group py-1">
                                <label for="description"><strong class="text-dark">Nội dung</strong></label>
                                <form:textarea path="description" name="description" id="description"
                                               class="form-control px-2" style="border: 1px solid black"
                                               rows="5"/>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-12 col-xl-5"></div>
                    <div class="col-12 col-xl-4 align-items-xxl-end">
                        <c:if test="${empty categoryEdit.id}">
                            <button type="button"
                                    class="btn btn-facebook px-4 py-2 ms-3 align-items-xxl-end"
                                    id="btnEditCategory">
                                Tạo
                            </button>
                        </c:if>

                        &nbsp;
                        <c:if test="${not empty categoryEdit.id}">
                            <button type="button"
                                    class="btn btn-facebook px-4 py-2 ms-3 align-items-xxl-end"
                                    id="btnEditCategory">Cập nhật
                            </button>
                        </c:if>

                        <c:if test="${not empty urlBack}">
                            <button type="button" class="btn bg-gradient-faded-dark px-3 py-2 ms-3 align-items-xxl-end">
                                <a class="text-white" href="${urlBack}">Quay lại</a>
                            </button>
                        </c:if>
                    </div>
                </div>
            </div>
        </form:form>
    </div>

</div>

<script>
    // Update Category's information
    $(document).ready(function () {
        $('#btnEditCategory').click(function () {
            $('#form-edit').submit();
        });
        setTimeout(function () {
            $('#alertResult').hide();
        }, 2000);
    });
    $(function () {
        $("form[name='form-edit']").validate({
            rules: {
                name: "required"
            },
            messages: {
                name: "Không bỏ trống"
            },
            submitHandler: function (form) {
                var formData = $('#form-edit').serializeArray();
                var dataArray = {};
                $.each(formData, function (i, v) {
                    dataArray["" + v.name + ""] = v.value.trim();
                });

                let action = "";

                if (dataArray["id"] === "") action = "thêm danh mục mới?";
                else action = "sửa thông tin danh mục?";

                if (confirm("Bạn chắc chắn muốn " + action)) {
                    editCategory(dataArray);
                }
            }
        });
    });

    function editCategory(json) {
        $.ajax({
            url: "${editCategoryURL}",
            method: "POST",
            data: JSON.stringify(json),
            contentType: "application/json; charset=UTF-8",
            dataType: "JSON",
            success: function (result) {
                console.log(result);

                if (result.data === 'insert_success') {
                    window.location.href = "<c:url value='/admin/category-edit?message=insert_success'/>";
                } else if (result.data === 'update_success') {
                    window.location.href = "<c:url value='/admin/category-edit-${id}?message=update_success'/>";
                }
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