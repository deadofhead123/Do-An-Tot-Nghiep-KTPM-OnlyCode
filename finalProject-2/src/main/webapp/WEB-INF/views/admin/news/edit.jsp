<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>
<c:url var="editNewURL" value="/api/admin/news"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Tùy chỉnh tin tức</title>
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
        <form:form method="get" id="form-edit" name="form-edit" modelAttribute="newsEdit" enctype="multipart/form-data">
            <form:input path="id" type="hidden" id="id" name="id"/>
            <div class="row gx-4 mb-2">
                <div class="col-auto my-auto">
                    <div class="h-100 align-items-center">
                        <c:if test="${newsEdit.id == null}">
                            <h4 class="mb-1">Thêm tin tức</h4>
                        </c:if>

                        <c:if test="${newsEdit.id != null}">
                            <h4 class="mb-1">Sửa chi tiết tin tức</h4>
                        </c:if>
                    </div>
                </div>
            </div>

            <div class="row">
                <c:if test="${newsEdit.id == null}">
                    <h6 class="mb-0">Điền các thông tin cần thiết</h6>
                </c:if>
                <!-- Contact Information -->
                <div class="col-12 col-xl-4">
                    <div class="card card-plain h-100">
                        <div class="card-body">
                            <div class="form-group py-1">
                                <label for="type"><strong class="text-dark">Loại tin tức</strong></label>
                                <form:select path="type" id="type" name="type" class="form-select px-2"
                                             style="border: 1px solid black">
                                    <form:option value="" label="------------------------------Chọn loại------------------------------"/>
                                    <form:options items="${typeList}"/>
                                </form:select>
                            </div>

                            <div class="form-group py-1">
                                <label for="name"><strong class="text-dark">Tên tin tức</strong></label>
                                <form:input path="name" name="name" id="name"
                                            class="form-control px-2"
                                            style="border: 1px solid black"/>
                            </div>

                            <div class="form-group py-1">
                                <label for="description"><strong class="text-dark">Mô tả tin tức</strong></label>
                                <form:input path="description" name="description" id="description"
                                            class="form-control px-2"
                                            style="border: 1px solid black"/>
                            </div>

                            <c:if test="${newsEdit.id != null}">
                                <div class="form-group py-1">
                                    <label for="hot"><strong class="text-dark">Tin tức nổi bật</strong></label>
                                    <form:select path="hot" id="hot" name="hot" class="form-select px-2"
                                                 style="border: 1px solid black">
                                        <form:options items="${hotType}"/>
                                    </form:select>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>

                <div class="col-12 col-xl-5">
                    <div class="card card-plain h-100">
                        <div class="card-body">
                            <div class="form-group py-1">
                                <label><strong class="text-dark">Ảnh đại diện</strong>&nbsp;(tên ảnh không có dấu hoặc
                                    khoảng trắng, ví dụ: a-b-c.png)</label>
                                <br>
                                <input class="col-md-3 no-padding-right" type="file" id="uploadImage"/>
                                <div class="col-sm-9">
                                    <!--Cũng giống cái nút Thêm và sửa thông tin, khi building chưa được tạo thì ko có ảnh, và nếu được tạo rồi thì có ảnh-->
                                    <!--Hiện ảnh đại diện từ tòa nhà đã tồn tại-->
                                    <c:if test="${not empty newsEdit.image}">
                                        <c:set var="imagePath" value="/repository${newsEdit.image}"/>
                                        <img src="${imagePath}" id="viewImage" width="100%" height="100%"
                                             style="margin-top: 50px" alt="Không tìm thấy ảnh">
                                    </c:if>

                                    <!--Hiện ảnh đại diện mặc định-->
                                    <c:if test="${empty newsEdit.image}">
                                        <img src="/admin/image/default.png" id="viewImage" width="100%" height="100%"
                                             alt="Chưa có ảnh">
                                    </c:if>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>

                <c:if test="${newsEdit.id != null}">
                    <div class="col-12 col-xl-3">
                        <div class="card card-plain h-100">
                            <div class="card-body">
                                <div class="form-group py-1">
                                    <label for="view"><strong class="text-dark">Lượt xem</strong></label>
                                    <form:input path="view" name="view" id="view"
                                                class="form-control px-2"
                                                style="border: 1px solid black" readonly="true"/>
                                </div>

                            </div>
                        </div>
                    </div>
                </c:if>

                <div class="form-group py-1">
                    <label for="content"><strong class="text-dark">Nội dung</strong></label>
                    <form:textarea path="content" name="content" id="content"
                                   class="form-control px-2" style="border: 1px solid black"
                                   rows="5"/>
                </div>

                <div class="row mt-3">
                    <div class="col-12 col-xl-5"></div>
                    <div class="col-12 col-xl-4 align-items-xxl-end">
                        <c:if test="${empty newsEdit.id}">
                            <button type="button"
                                    class="btn btn-facebook px-4 py-2 ms-3 align-items-xxl-end"
                                    id="btnEditNew">
                                Tạo
                            </button>
                        </c:if>

                        &nbsp;
                        <c:if test="${not empty newsEdit.id}">
                            <button type="button"
                                    class="btn btn-facebook px-4 py-2 ms-3 align-items-xxl-end"
                                    id="btnEditNew">Cập nhật
                            </button>
                        </c:if>

                        <button type="button" class="btn bg-gradient-faded-dark px-3 py-2 ms-3 align-items-xxl-end">
                            <a class="text-white" href="/admin/news-list">Quay lại</a>
                        </button>
                    </div>
                </div>
            </div>
        </form:form>
    </div>

</div>

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

    // Update News's information
    $(document).ready(function () {
        $('#btnEditNew').click(function () {
            $('#form-edit').submit();
        });
        setTimeout(function () {
            $('#alertResult').hide();
        }, 2000);
    });

    $(function () {
        $("form[name='form-edit']").validate({
            rules: {
                name: "required",
                description: "required",
                type: "required"
            },
            messages: {
                name: "<span style='color: red'>Không bỏ trống tên!</span>",
                description: "<span style='color: red'>Không bỏ trống mô tả!</span>",
                type: "<span style='color: red'>Không bỏ trống loại tin tức!</span>"
            },
            submitHandler: function (form) {
                var formData = $('#form-edit').serializeArray();
                var dataArray = {};

                $.each(formData, function (i, v) {
                    dataArray["" + v.name + ""] = v.value.trim();
                });

                dataArray["content"] = tinymce.get('content').getContent();

                // save image's information
                if ('' !== imageBase64) {
                    dataArray['imageBase64'] = imageBase64;
                    dataArray['imageName'] = imageName;
                }

                let action = "";
                if (dataArray["id"] === "") action = "thêm tin tức mới?";
                else action = "sửa chi tiết tin tức?";

                console.log(dataArray)

                if (dataArray["content"] === '') {
                    alert('Bạn phải điền nội dung của tin tức!');
                }else {
                    if (confirm("Bạn chắc chắn muốn " + action)) {
                        editNews(dataArray);
                    }
                }
            }
        });
    });

    function editNews(json) {
        $.ajax({
            url: "${editNewURL}",
            method: "POST",
            data: JSON.stringify(json),
            contentType: "application/json; charset=UTF-8",
            dataType: "JSON",
            success: function (result) {
                console.log(result);

                if (result.data === 'insert_success') {
                    window.location.href = "<c:url value='/admin/news-edit?message=insert_success'/>";
                } else if (result.data === 'update_success') {
                    window.location.href = "<c:url value='/admin/news-edit-${id}?message=update_success'/>";
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