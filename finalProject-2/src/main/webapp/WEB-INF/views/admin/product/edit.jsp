<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>
<c:url var="editURL" value="/api/admin/products"/>
<c:url var="formURI" value="/api/admin/products"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Sản phẩm</title>
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
        <form:form method="get" id="form-edit" name="form-edit" modelAttribute="productEdit"
                   enctype="multipart/form-data">
            <form:input path="id" type="hidden" id="id" name="id"/>
            <div class="row gx-4 mb-2">
                <div class="col-auto my-auto">
                    <div class="h-100 align-items-center">
                        <c:if test="${productEdit.id == null}">
                            <h5 class="mb-1">Thêm sản phẩm</h5>
                        </c:if>

                        <c:if test="${productEdit.id != null}">
                            <h5 class="mb-1">Sửa thông tin sản phẩm</h5>
                        </c:if>
                    </div>
                </div>
            </div>

            <div class="row">
                <c:if test="${productEdit.id == null}">
                    <h6 class="mb-0">Điền các thông tin cần thiết</h6>
                </c:if>
                <!-- Contact Information -->
                <div class="col-12 col-xl-4">
                    <div class="card card-plain h-100">
                        <div class="card-body">
                            <div class="form-group py-1">
                                <label for="name"><strong class="text-dark">Tên sản phẩm</strong></label>
                                <c:if test="${productEdit.id == null}">
                                    <form:input path="name" name="name" id="name"
                                                class="form-control px-2"
                                                style="border: 1px solid black"/>
                                </c:if>
                                <c:if test="${productEdit.id != null}">
                                    <form:input path="name" name="name" id="name"
                                                class="form-control px-2"
                                                style="border: 1px solid black" readonly="true"/>
                                </c:if>
                            </div>

                            <br>
                            <div class="form-group py-1">
                                <label for="categoryId"><strong class="text-dark">Danh mục sản phẩm</strong></label>
                                <form:select path="categoryId" id="categoryId" name="categoryId"
                                             class="form-select px-2"
                                             style="border: 1px solid black">
                                    <form:option value=""
                                                 label="------------------Chọn danh mục------------------"/>
                                    <form:options items="${categoryList}"/>
                                </form:select>
                            </div>

                            <div class="form-group py-1">
                                <label for="expiration"><strong class="text-dark">Thời gian sử dụng (ngày)</strong></label>
                                <form:input path="expiration" name="expiration" id="expiration"
                                            class="form-control px-2"
                                            style="border: 1px solid black"/>
                            </div>

                            <c:if test="${productEdit.id != null}">
                                <br>
                                <div class="form-group py-1">
                                    <label for="quantity"><strong class="text-dark">Số lượng còn</strong></label>
                                    <form:input path="quantity" name="quantity" id="quantity"
                                                class="form-control px-2"
                                                style="border: 1px solid black" readonly="true"/>
                                </div>
                            </c:if>

                            <br>
                            <div class="form-group py-1">
                                <label for="price"><strong class="text-dark">Giá bán</strong>&nbsp;(VND)</label>
                                <form:input path="price" name="price" id="price" type="number"
                                            class="form-control px-2"
                                            style="border: 1px solid black"/>
                            </div>

                            <c:if test="${productEdit.id != null}">
                                <div class="form-group py-1">
                                    <label for="price"><strong class="text-dark">Giảm giá (%)</strong>&nbsp;</label>
                                    <form:input path="discount" name="discount" id="discount" type="discount"
                                                class="form-control px-2"
                                                style="border: 1px solid black"/>
                                </div>
                            </c:if>

                            <br>
                            <c:if test="${productEdit.id != null}">
                                <label for="hot"><strong class="text-dark">Sản phẩm bán chạy</strong></label>
                                <form:select path="hot" id="hot" name="hot"
                                             class="form-select px-2"
                                             style="border: 1px solid black">
                                    <form:options items="${hotType}"/>
                                </form:select>
                            </c:if>
                        </div>
                    </div>
                </div>

                <div class="col-12 col-xl-8">
                    <div class="card card-plain h-100">
                        <div class="card-body">
                            <div class="form-group py-1">
                                <label><strong class="text-dark">Ảnh đại diện</strong>&nbsp;(tên ảnh không có dấu hoặc
                                    khoảng trắng, ví dụ: a-b-c.png)</label>
                                <br>
                                <input class="col-md-3 no-padding-right" type="file" id="uploadImage"/>
                                <div class="col-sm-9">
                                    <c:if test="${not empty productEdit.image}">
                                        <c:set var="imagePath" value="/repository${productEdit.image}"/>
                                        <img src="${imagePath}" id="viewImage" width="100%" height="100%"
                                             style="margin-top: 50px" alt="Không tìm thấy ảnh">
                                    </c:if>

                                    <!--Hiện ảnh đại diện mặc định-->
                                    <c:if test="${empty productEdit.image}">
                                        <img src="/admin/image/default.png" id="viewImage" width="100%" height="100%"
                                             alt="Chưa có ảnh">
                                    </c:if>
                                </div>
                            </div>
                            <br>
                            <div class="form-group py-1">
                                <label for="description"><strong class="text-dark">Mô tả</strong></label>
                                <form:textarea path="description" name="description" id="description" type="description"
                                               class="form-control px-2"
                                               rows="8"
                                               style="border: 1px solid black"/>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-12 col-xl-5"></div>
                    <div class="col-12 col-xl-4 align-items-xxl-end">
                        <c:if test="${empty productEdit.id}">
                            <button type="button"
                                    class="btn btn-facebook px-4 py-2 ms-3 align-items-xxl-end"
                                    id="btnEdit">
                                Tạo
                            </button>
                        </c:if>

                        &nbsp;
                        <c:if test="${not empty productEdit.id}">
                            <button type="button"
                                    class="btn btn-facebook px-4 py-2 ms-3 align-items-xxl-end"
                                    id="btnEdit">Cập nhật
                            </button>
                        </c:if>

                        <button type="button" class="btn bg-gradient-faded-dark px-3 py-2 ms-3 align-items-xxl-end">
                            <a class="text-white" href="/admin/product-list">Quay lại</a>
                        </button>
                    </div>
                </div>
            </div>
        </form:form>
    </div>
</div>
<br>
<br>
<br>
<!-- Feedback -->
<c:if test="${productEdit.id != null}">
    <div class="container-fluid px-1 px-md-4">
        <div class="card card-body mt-n6">
            <div class="row gx-4 mb-2">
                <div class="col-auto my-auto">
                    <div class="h-100 align-items-center">
                        <h5 class="mb-1">Đánh giá sản phẩm</h5>
                        <h6>${numberOfFeedback} lượt đánh giá</h6>
                    </div>
                </div>
            </div>

            <div class="card-body px-0 pb-2">
                <div class="table-responsive p-0">
                    <display:table name="allFeedback.listResult" cellspacing="0"
                                   cellpadding="0"
                                   requestURI="${formURI}" partialList="true"
                                   sort="external"
                                   size="${allFeedback.totalItems}" defaultsort="2"
                                   defaultorder="ascending"
                                   id="tableList" pagesize="${allFeedback.maxPageItems}"
                                   export="false"
                                   class="table align-items-center table-striped table-bordered table-hover mb-0"
                                   style="margin: 0 1.5em;">
                        <display:column
                                headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8"
                                title="Email">
                            <div class="align-middle text-center">
                                <span class="text-secondary text-md font-weight-bold">${tableList.userDTO.email}</span>
                            </div>
                        </display:column>

                        <display:column
                                headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8"
                                title="Họ tên">
                            <div class="align-middle text-center">
                                <span class="text-secondary text-md font-weight-bold">${tableList.userDTO.fullName}</span>
                            </div>
                        </display:column>

                        <display:column
                                headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8"
                                title="Điểm đánh giá">
                            <div class="align-middle text-center">
                                <c:set var="rating" value="${tableList.rating}"/>
                                <a href="#" class="mr-2 text-dark" style="font-size: 18px">${rating}</a>

                                <c:forEach var="i" begin="1" end="5">
                                    <c:choose>
                                        <c:when test="${i <= rating}">
                                            <a href="#">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="20"
                                                     height="20"
                                                     fill="currentColor"
                                                     class="bi bi-star star active" viewBox="0 0 16 16">
                                                    <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
                                                </svg>
                                            </a>
                                        </c:when>

                                        <c:otherwise>
                                            <a href="#">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="20"
                                                     height="20"
                                                     fill="currentColor"
                                                     class="bi bi-star star" viewBox="0 0 16 16">
                                                    <path d="M2.866 14.85c-.078.444.36.791.746.593l4.39-2.256 4.389 2.256c.386.198.824-.149.746-.592l-.83-4.73 3.522-3.356c.33-.314.16-.888-.282-.95l-4.898-.696L8.465.792a.513.513 0 0 0-.927 0L5.354 5.12l-4.898.696c-.441.062-.612.636-.283.95l3.523 3.356-.83 4.73zm4.905-2.767-3.686 1.894.694-3.957a.56.56 0 0 0-.163-.505L1.71 6.745l4.052-.576a.53.53 0 0 0 .393-.288L8 2.223l1.847 3.658a.53.53 0 0 0 .393.288l4.052.575-2.906 2.77a.56.56 0 0 0-.163.506l.694 3.957-3.686-1.894a.5.5 0 0 0-.461 0z"/>
                                                </svg>
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </div>
                        </display:column>

                        <display:column
                                headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8"
                                title="Nội dung">
                            <div class="align-middle text-center">
                                    <span class="text-secondary text-md font-weight-bold">
                                            ${tableList.content}
                                    </span>
                            </div>
                        </display:column>

                        <display:column
                                headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8"
                                title="Ngày tạo">
                            <div class="align-middle text-center">
                                <span class="text-secondary text-md font-weight-bold">
                                    <fmt:formatDate value="${tableList.createdAt}" pattern="HH:mm:ss, dd/MM/yyyy"/>
                                </span>
                            </div>
                        </display:column>

                        <display:setProperty name="paging.banner.one_item_found"
                                             value="<br/><div class='ms-3 col-sm-6 align-left'><div class='infos'>Tìm thấy <b>1</b> đánh giá.</div></div>"/>
                        <display:setProperty name="paging.banner.all_items_found"
                                             value="<br/><div class='ms-3 col-sm-6 align-left'><div class='infos'>Tìm thấy <b>{0}</b> đánh giá.</div></div>"/>

                        <display:setProperty name="basic.msg.empty_list"
                                             value="Không tìm thấy kết quả"/>
                        <display:setProperty name="paging.banner.no_items_found"
                                             value="<br/><div class='ms-3 col-sm-6 align-left'><div class='infos'>Không tìm thấy đánh giá nào.</div></div>"/>
                        <display:setProperty name="paging.banner.some_items_found"
                                             value="<br/><div class='ms-3 col-sm-6 align-left'><div class='info-horizontal'>Tìm thấy <b>{0}</b> đánh giá, hiển thị từ {2} đến {3}.</div></div>"/>
                    </display:table>

                </div>
            </div>
        </div>
    </div>
</c:if>


<!-- TinyMCE library (text editor to create blog or news) -->
<script src="../other/tinymce/tinymce.min.js"></script>
<script src="../other/tinymce/tinymceConfig.js"></script>
<script>
    /*
        ----------- Image uploading -----------
         */

    let imageBase64 = '';
    let imageName = '';

    $('#uploadImage').change(function (event) {
        let reader = new FileReader();
        let file = $(this)[0].files[0];
        reader.onload = function (e) {
            imageBase64 = e.target.result;
            imageName = file.name; // Image's name without spaces or special character. Example: a-b-c
        };
        reader.readAsDataURL(file);
        openImage(this, "viewImage");
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

    // Update Product's information
    $(document).ready(function () {
        $('#btnEdit').click(function () {
            $('#form-edit').submit();
        });
        setTimeout(function () {
            $('#alertResult').hide();
        }, 2000);
    });
    $(function () {
        $("form[name='form-edit']").validate({
            rules: {
                name: {
                    required: true
                },
                categoryId: {
                    required: true
                },
                expiration:{
                    required: true,
                    min: 1
                },
                price: {
                    required: true,
                    min: 1000
                },
                discount: {
                    min: 0,
                    max: 100
                }
            },
            messages: {
                name: "<span style='color: red'>Không bỏ trống tên sản phẩm !</span>",
                categoryId: "<span style='color: red'>Phải chọn danh mục !</span>",
                expiration:{
                    required: "<span style='color: red'>Phải nhập thời gian sử dụng !</span>",
                    min: "<span style='color: red'>Thời gian sử dụng phải lớn hơn 0 !</span>"
                },
                price: {
                    required: "<span style='color: red'>Phải nhập giá bán !</span>",
                    min: "<span style='color: red'>Giá bán phải lớn hơn hoặc bằng 1.000 VND !</span>"
                },
                discount: {
                    min: "<span style='color: red'>Lượng giảm giá phải nằm trong khoảng 0-100% !</span>",
                    max: "<span style='color: red'>Lượng giảm giá phải nằm trong khoảng 0-100% !</span>"
                }
            },
            submitHandler: function (form) {
                var formData = $('#form-edit').serializeArray();
                var dataArray = {};

                $.each(formData, function (i, v) {
                    dataArray["" + v.name + ""] = v.value.trim();
                });

                dataArray["description"] = tinymce.get('description').getContent();

                // save image's information
                if ('' !== imageBase64) {
                    dataArray['imageBase64'] = imageBase64;
                    dataArray['imageName'] = imageName;
                }

                let action = "";
                if (dataArray["id"] === "") action = "thêm sản phẩm mới?";
                else action = "sửa thông tin sản phẩm?";

                console.log(dataArray)

                if (confirm("Bạn chắc chắn muốn " + action)) {
                    editProduct(dataArray);
                }
            }
        });
    });

    function editProduct(json) {
        $.ajax({
            url: "${editURL}",
            method: "POST",
            data: JSON.stringify(json),
            contentType: "application/json; charset=UTF-8",
            dataType: "JSON",
            success: function (result) {
                console.log(result);

                if (result.data === 'insert_success') {
                    window.location.href = "<c:url value='/admin/product-edit?message=insert_success'/>";
                } else if (result.data === 'update_success') {
                    window.location.href = "<c:url value='/admin/product-edit-${productEdit.id}?message=update_success'/>";
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