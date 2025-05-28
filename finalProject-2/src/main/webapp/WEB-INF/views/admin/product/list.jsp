<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>
<c:url var="formAPI" value="/api/admin/products"/>
<c:url var="formURI" value="/admin/product-list"/>
<c:url var="productEditURL" value="/admin/product-edit"/>

<!DOCTYPE html>
<html lang="en">

<head>
    <title>Sản phẩm</title>
</head>

<body class="g-sidenav-show  bg-gray-100">

<div class="container-fluid py-2">
    <!-- User list -->
    <div class="row">
        <div class="col-12">
            <div class="card my-4">
                <div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
                    <div class="bg-gradient-dark shadow-dark border-radius-lg pt-4 pb-3">
                        <h6 class="text-white text-capitalize ps-3">Danh sách sản phẩm</h6>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12 mx-3 my-3">
                        <!-- Search form -->
                        <form:form method="get" modelAttribute="productSearch" id="form-search">
                            <!-- Row 1 -->
                            <div class="input-group">
                                <div class="col-lg-2 px-3">
                                    <label for="name"><strong class="text-dark" style="font-size: 15px;">Tên sản phẩm</strong></label>
                                    <form:input path="name" type="text" name="name" id="name"
                                                class="form-control px-2"
                                                style="border: 1px solid black; font-size: 17px;"/>
                                </div>
                                <div class="col-lg-1 px-3"></div>
                                <div class="col-lg-2 px-3">
                                    <label for="type"><strong class="text-dark" style="font-size: 15px;">Danh mục</strong></label>
                                    <form:select path="categoryId" name="type" id="type" class="form-select px-2"
                                                 style="border: 1px solid black; font-size: 17px;">
                                        <form:option value="" label="--------Chọn danh mục----------"/>
                                        <form:options items="${categories}"/>
                                    </form:select>
                                </div>
                                <div class="col-lg-1 px-3"></div>
                                <div class="col-lg-2 px-3">
                                    <label for="hot"><strong class="text-dark" style="font-size: 15px;">Sản phẩm bán chạy</strong></label>
                                    <form:select path="hot" id="hot" name="hot"
                                                 class="form-select px-2"
                                                 style="border: 1px solid black; font-size: 17px;">
                                        <form:option value="" label="-----------Chọn kiểu--------------"/>
                                        <form:options items="${hotType}"/>
                                    </form:select>
                                </div>
                                <div class="col-lg-1 px-3"></div>
                                <div class="col-lg-2 px-3">
                                    <label for="isOutOfQuantity"><strong class="text-dark" style="font-size: 15px;">Tình trạng trong kho</strong></label>
                                    <form:select path="isOutOfQuantity" id="isOutOfQuantity" name="isOutOfQuantity"
                                                 class="form-select px-2"
                                                 style="border: 1px solid black; font-size: 17px;">
                                        <form:option value="" label="-------Chọn tình trạng--------------"/>
                                        <form:options items="${isOutOfQuantity}"/>
                                    </form:select>
                                </div>
                            </div>
                            <br>

                            <div class="input-group">
                                <div class="col-lg-2 px-3">
                                    <label for="priceFrom"><strong class="text-dark" style="font-size: 15px;">Giá từ</strong></label>
                                    <form:input path="priceFrom" type="text" name="priceFrom" id="priceFrom"
                                                class="form-control px-2"
                                                style="border: 1px solid black; font-size: 17px;"/>
                                </div>

                                <div class="col-lg-2 px-3">
                                    <label for="priceTo"><strong class="text-dark" style="font-size: 15px;">Giá đến</strong></label>
                                    <form:input path="priceTo" type="text" name="priceTo" id="priceTo"
                                                class="form-control px-2"
                                                style="border: 1px solid black; font-size: 17px;"/>
                                </div>
                                <div class="col-lg-2 px-3"></div>
                                <div class="col-lg-3 px-3">
                                        <label for="isDiscount"><strong class="text-dark" style="font-size: 15px;">Đang giảm giá</strong></label>
                                        <form:select path="isDiscount" id="isDiscount" name="isDiscount"
                                                 class="form-select px-2"
                                                 style="border: 1px solid black; font-size: 17px;">
                                        <form:option value="" label="--------------Chọn tình trạng--------------"/>
                                        <form:options items="${productDiscountStatus}"/>
                                    </form:select>
                                </div>
                            </div>
                        </form:form>

                        <div class="input-group py-3">
                            <div class="col-lg-3 px-4">
                                <button type="button" class="btn btn-primary" id="btnSeach">
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
                            <div class="col-lg-3 px-3">
                                <label for="discount"><strong class="text-dark">Giảm giá cho các sản phẩm được chọn
                                    (0-100%)</strong></label>
                                <input type="number" name="discount" id="discount"
                                       class="rounded px-2"
                                       style="border: 1px solid black" value="0"/>
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
                                        title="Thêm sản phẩm">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                         fill="currentColor" class="bi bi-plus-circle" viewBox="0 0 16 16">
                                        <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
                                        <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4"/>
                                    </svg>
                                    <a href="${productEditURL}" class="text-white">Thêm mới</a>
                                </button>
                                &nbsp; &nbsp;
                                <button type="reset" class="btn btn-danger" onclick="btnDeleteGroup()"
                                        title="Xóa những sản phẩm được chọn">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                         fill="currentColor" class="bi bi-lock-fill" viewBox="0 0 16 16">
                                        <path d="M8 1a2 2 0 0 1 2 2v4H6V3a2 2 0 0 1 2-2m3 6V3a3 3 0 0 0-6 0v4a2 2 0 0 0-2 2v5a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2"/>
                                    </svg>
                                    Xóa hết
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <c:choose>
                        <c:when test="${productSearchResponse.totalItems % productSearchResponse.maxPageItems != 0}">
                            <c:set var="finalPage"
                                   value="${productSearchResponse.totalItems / productSearchResponse.maxPageItems + 1}"/>
                        </c:when>
                        <c:otherwise>
                            <c:set var="finalPage"
                                   value="${productSearchResponse.totalItems / productSearchResponse.maxPageItems}"/>
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

                        <display:table name="productSearchResponse.listResult" cellspacing="0"
                                       cellpadding="0"
                                       requestURI="${formURI}" partialList="false"
                                       sort="external"
                                       size="${productSearchResponse.totalItems}" defaultsort="2"
                                       defaultorder="ascending"
                                       id="tableList" pagesize="${productSearchResponse.maxPageItems}"
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

                                    <c:if test="${empty tableList.image}">
                                        <img src="/admin/image/default.png" id="viewImage" width="100" height="100"
                                             alt="Chưa có ảnh">
                                    </c:if>
                                </div>
                            </display:column>

                            <display:column
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8"
                                    sortable="true" sortName="name"
                                    title="Tên sản phẩm">
                                <div class="align-middle text-center">
                                    <span class="text-secondary text-md font-weight-bold">${tableList.name}</span>
                                </div>
                            </display:column>

                            <display:column
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8"
                                    sortable="true" sortName="quantity"
                                    title="Số lượng còn">
                                <div class="align-middle text-center">
                                    <span class="text-secondary text-md font-weight-bold">${tableList.quantity}</span>
                                </div>
                            </display:column>

                            <display:column
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8"
                                    sortable="true" sortName="price"
                                    title="Giá bán">
                                <div class="align-middle text-center">
                                    <span class="text-secondary text-md font-weight-bold">
                                        <fmt:formatNumber value="${tableList.price}" pattern="#,###"/>₫
                                    </span>
                                </div>
                            </display:column>

                            <display:column
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8"
                                    sortable="true" sortName="sold"
                                    title="Số lượng đã bán">
                                <div class="align-middle text-center">
                                    <span class="text-secondary text-md font-weight-bold">${tableList.sold}</span>
                                </div>
                            </display:column>

                            <display:column
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8"
                                    sortable="true" sortName="createdAt"
                                    title="Thời gian tạo">
                                <div class="align-middle text-center">
                                    <span class="text-secondary text-md font-weight-bold"><fmt:formatDate value="${tableList.createdAt}" pattern="HH:mm:ss, dd/MM/yyyy"/></span>
                                </div>
                            </display:column>

                            <display:column
                                    headerClass="text-center text-uppercase text-secondary text-lg font-weight-bolder opacity-8"
                                    sortable="true" sortName="modifiedAt"
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
                                        <a href="/admin/product-edit-${tableList.id}"
                                           class="text-secondary font-weight-bold text-md text-white"
                                           title="Xem, cập nhật thông tin chi tiết của sản phẩm">
                                            Cập nhật
                                        </a>
                                    </button>

                                    <button class="badge badge-circle bg-gradient-warning"
                                            style="text-transform: capitalize"
                                            onclick="deleteSingle(${tableList.id})">
                                        <a href="javascript:;"
                                           class="text-secondary font-weight-bold text-md text-white"
                                           title="Xóa sản phẩm" id="btnDeleteProduct">
                                            Xóa
                                        </a>
                                    </button>
                                </div>
                            </display:column>
                            <display:setProperty name="paging.banner.one_item_found"
                                                 value="<br/><div class='ms-3 col-sm-6 align-left'><div class='infos'>Tìm thấy <b>1</b> sản phẩm.</div></div>"/>
                            <display:setProperty name="paging.banner.all_items_found"
                                                 value="<br/><div class='ms-3 col-sm-6 align-left'><div class='infos'>Tìm thấy <b>{0}</b> sản phẩm.</div></div>"/>

                            <display:setProperty name="basic.msg.empty_list"
                                                 value="Không tìm thấy kết quả"/>
                            <display:setProperty name="paging.banner.no_items_found"
                                                 value="<br/><div class='ms-3 col-sm-6 align-left'><div class='infos'>Không tìm thấy sản phẩm nào.</div></div>"/>
                            <display:setProperty name="paging.banner.some_items_found"
                                                 value="<br/><div class='ms-3 col-sm-6 align-left'><div class='info-horizontal'>Tìm thấy <b>{0}</b> sản phẩm, hiển thị từ {2} đến {3}.</div></div>"/>
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

    function openImage(input, imageView) {
        if (input.files && input.files[0]) {
            let reader = new FileReader();
            reader.onload = function (e) {
                $('#' + imageView).attr('src', reader.result);
            }
            reader.readAsDataURL(input.files[0]);
        }
    }

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
            currentURL += "?${tableId}=" + pageToDirect;
        }

        window.location.href = currentURL;
    });

    // Check or uncheck all
    $('#checkAll').change(function () {
        let userIds = document.querySelectorAll('#id');

        if (this.checked) {
            userIds.forEach(item => {
                item.setAttribute('checked', 'checked');
            });
        } else {
            userIds.forEach(item => {
                item.removeAttribute('checked');
            });
        }
    });

    //----------------------------- Apply discount
    $('#btnApplyDiscount').click(function () {
        let ids = $('#tableList').find('tbody input[type=checkbox]:checked').map(function () {
            return $(this).val();
        }).get();
        let discountValue = parseInt($('#discount').val().trim());

        if (ids.length === 0) {
            alert('Bạn chưa chọn sản phẩm nào để áp dụng giảm giá !');
        } else if (discountValue < 0 || discountValue > 100) {
            alert('Mức giảm giá phải nằm trong khoảng 0-100% !');
        } else if (confirm('Bạn chắc chắn muốn áp dụng giảm giá cho các sản phẩm đã chọn ?')) {
            $.ajax({
                url: '${formAPI}' + '/discount?ids=' + ids + "&discountValue=" + discountValue,
                method: "PATCH",
                contentType: "application/json; charset=UTF-8",
                dataType: "JSON",
                success: function (result) {
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
    });

    //----------------------------- Search
    $('#btnSeach').click(function () {
        $('#form-search').submit();
    });

    //----------------------------- Clear search form
    $('#btnDeleteParams').click(function () {
        window.location.href = "/admin/product-list";
    });

    //----------------------------- Delete single product
    function deleteSingle(id) {
        if (confirm("Bạn chắc chắn muốn XÓA SẢN PHẨM này?")) {
            deleteProducts([id]);
        }
    }

    //----------------------------- Delete all products selected
    function btnDeleteGroup() {
        let ids = $('#tableList').find('tbody input[type=checkbox]:checked').map(function () {
            return $(this).val();
        }).get();

        console.log(ids);

        if (ids.length === 0) {
            alert('Bạn chưa chọn sản phẩm nào!');
        } else {
            if (confirm('Bạn chắc chắn muốn XÓA NHỮNG SẢN PHẨM này?')) {
                deleteProducts(ids);
            }
        }
    }

    function deleteProducts(ids) {
        // Find last page
        let totalItems = ${productSearchResponse.totalItems};
        let maxPageItems = ${productSearchResponse.maxPageItems};
        let finalPage = Math.ceil(totalItems / maxPageItems);

        $.ajax({
            url: "${formAPI}/" + ids,
            method: "PATCH",
            contentType: "application/json; charset=UTF-8",
            dataType: "JSON",
            success: function (result) {
                // When deleting, back to previous page if this isn't page 1
                if (currentPageString !== "") {
                    // If current page is final; and you delete all record in this page, create an URL with previous page of this page
                    if (page !== 1 && page === finalPage && (ids.length) === (document.querySelectorAll('#id').length)) {
                        page--;
                        currentURL = currentURL.replace(currentPageString, "p=" + page); // replace old page string
                    }
                }

                alert(result.message);
                window.location.href = currentURL;
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