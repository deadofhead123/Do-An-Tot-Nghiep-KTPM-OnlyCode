<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>
<c:url var="productInventoryListURL" value="/admin/productInventory-list"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Sản phẩm con</title>
</head>

<body class="g-sidenav-show bg-gray-100">

<div class="container-fluid px-2 px-md-6">
    <div class="page-header min-height-300 border-radius-xl mt-4"
         style="background-image: url('/web-user/images/bg_1.jpg');">
        <span class="mask bg-gradient-dark  opacity-1"></span>
    </div>

    <div class="card card-body mx-2 mx-md-2 mt-n6">
        <form:form method="get" id="form-edit" name="form-edit" modelAttribute="productInventoryEdit"
                   enctype="multipart/form-data">
            <form:input path="id" type="hidden" id="id" name="id"/>
            <div class="row gx-4 mb-2">
                <div class="col-auto my-auto">
                    <div class="h-100 align-items-center">
                        <h5 class="mb-1">Chi tiết sản phẩm con</h5>
                    </div>
                </div>
            </div>

            <div class="row">
                <!-- Contact Information -->
                <div class="col-12 col-xl-4">
                    <div class="card card-plain h-100">
                        <div class="card-body">
                            <div class="form-group py-1">
                                <label for="name"><strong class="text-dark">Tên sản phẩm</strong></label>
                                <form:input path="name" name="name" id="name"
                                            class="form-control px-2"
                                            style="border: 1px solid black" readonly="true"/>
                            </div>

                            <div class="form-group py-1">
                                <label for="expiration"><strong class="text-dark">Thời gian hết hạn</strong></label>
                                <form:input path="expiredAt" name="expiration" id="expiration"
                                            class="form-control px-2"
                                            style="border: 1px solid black" readonly="true"/>
                            </div>

                            <br>
                            <div class="form-group py-1">
                                <label for="supplierId"><strong class="text-dark">Mã nhà cung cấp</strong>&nbsp</label>
                                <form:input path="supplierId" name="supplierId" id="supplierId" type="number"
                                            class="form-control px-2"
                                            style="border: 1px solid black" readonly="true"/>
                            </div>
                            <div class="form-group py-1">
                                <label for="priceInImport"><strong class="text-dark">Giá
                                    nhập</strong>&nbsp;(VND)</label>
                                <form:input path="priceInImport" name="priceInImport" id="priceInImport" type="number"
                                            class="form-control px-2"
                                            style="border: 1px solid black" readonly="true"/>
                            </div>

                            <br>
                            <c:if test="${not empty productInventoryEdit.orderId}">
                                <div class="form-group py-1">
                                    <label for="orderId"><strong class="text-success">Được sử dụng trong đơn hàng</strong></label>
                                    <form:input path="orderId" name="orderId" id="orderId" type="number"
                                                class="form-control px-2"
                                                style="border: 1px solid black" readonly="true"/>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>

                <div class="col-12 col-xl-4">
                    <div class="card card-plain h-100">
                        <div class="card-body">
                            <div class="form-group py-1">
                                <label><strong class="text-dark">Tình trạng</strong></label>
                                <c:set var="status" value=""/>
                                <c:forEach var="statusSingle" items="${productInventoryStatus}">
                                    <c:if test="${statusSingle.key == productInventoryEdit.status}">
                                        <c:set var="status" value="${statusSingle.value}"/>
                                    </c:if>
                                </c:forEach>
                                <input name="status" id="status" type="text"
                                       value="${status}"
                                       class="form-control px-2"
                                       style="border: 1px solid black" readonly/>
                            </div>

                            <div class="form-group py-1">
                                <label for="note"><strong class="text-dark">Ghi chú</strong></label>
                                <form:textarea path="note" name="note" id="note"
                                               class="form-control px-2"
                                               style="border: 1px solid black"
                                               rows="4" readonly="true"/>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-12 col-xl-4">
                    <div class="card card-plain h-100">
                        <div class="card-body">
                            <div class="form-group py-1">
                                <label><strong class="text-dark">Ảnh đại diện</strong></label>
                                <br>
                                <div class="col-sm-9">
                                    <c:if test="${not empty productInventoryEdit.productDTO.image}">
                                        <img src="/repository${productInventoryEdit.productDTO.image}" id="viewImage"
                                             width="100%" height="100%"
                                             style="margin-top: 50px" alt="Không tìm thấy ảnh">
                                    </c:if>

                                    <!--Hiện ảnh đại diện mặc định-->
                                    <c:if test="${empty productInventoryEdit.productDTO.image}">
                                        <img src="/admin/image/default.png" id="viewImage" width="100%" height="100%"
                                             alt="Chưa có ảnh">
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row pt-xxl-3">
                    <div class="col-12 col-xl-5"></div>
                    <div class="col-12 col-xl-4 align-items-xxl-end">

                        <button type="button" class="btn bg-gradient-faded-dark px-3 py-2 ms-3 align-items-xxl-end">
                            <a class="text-white" href="${productInventoryListURL}">Quay lại</a>
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

</script>
</body>

</html>