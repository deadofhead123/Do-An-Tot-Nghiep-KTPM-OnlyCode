<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>
<c:url var="productAPI" value="/api/admin/products"/>
<c:url var="importAPI" value="/api/admin/imports"/>
<c:url var="importAddURL" value="/admin/import-create"/>
<c:url var="importListURL" value="/admin/import-list"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Nhập hàng</title>

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
        <form:form method="get" id="form-create" name="form-create" modelAttribute="supplierEdit"
                   enctype="multipart/form-data">
            <div class="row gx-4 mb-2">
                <div class="col-auto my-auto">
                    <div class="h-100 align-items-center">
                        <h4 class="mb-1">Tạo lần nhập hàng</h4>
                    </div>
                </div>
            </div>

            <div class="row">
                <h5 class="mb-0">Thông tin nhà cung cấp</h5>
                <div class="text-dark">
                    <p>Chú ý:</p>
                    <p>- Bạn nên nhập sản phẩm trước khi nhập thông tin nhà cung cấp</p>
                    <p>- Nếu tự nhập thì không cần thay đổi thông tin điền sẵn </p>
                </div>
            </div>

            <div class="row">
                <!-- Supplier's information -->
                <div class="col-12 col-xl-4">
                    <div class="card card-plain h-100">
                        <div class="card-body">
                            <div class="form-group py-2">
                                <label for="name"><strong class="text-dark" style="font-size: 15px;">Tên nhà cung cấp</strong></label>
                                <form:input path="name" name="name" id="name"
                                            class="form-control px-2"
                                            style="border: 1px solid black; color: black; font-size: 17px;"/>
                            </div>

                            <div class="form-group py-2">
                                <label for="address"><strong class="text-dark" style="font-size: 15px;">Địa chỉ</strong></label>
                                <form:input path="address" name="address" id="address"
                                            class="form-control px-2"
                                            style="border: 1px solid black; color: black; font-size: 17px;"/>
                            </div>

                            <div class="form-group py-2">
                                <label for="email"><strong class="text-dark" style="font-size: 15px;">Email</strong></label>
                                <form:input path="email" name="email" id="email"
                                            class="form-control px-2"
                                            style="border: 1px solid black; color: black; font-size: 17px;"/>
                            </div>

                            <div class="form-group py-2">
                                <label for="phoneNumber"><strong class="text-dark" style="font-size: 15px;">Số điện thoại</strong></label>
                                <form:input path="phoneNumber" name="phoneNumber" id="phoneNumber"
                                            class="form-control px-2"
                                            style="border: 1px solid black; color: black; font-size: 17px;"/>
                            </div>

                        </div>
                    </div>
                </div>

                <div class="col-12 col-xl-4">
                    <div class="card card-plain h-100">
                        <div class="card-body text-dark">
                            <div class="form-group py-2">
                                <label for="note"><strong class="text-dark" style="font-size: 15px;">Ghi chú</strong></label>
                                <form:textarea path="note" name="note" id="note"
                                               class="form-control px-2"
                                               rows="5"
                                               style="border: 1px solid black; color: black; font-size: 17px;"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Products available -->
            <div class="row">
                <div class="row pt-xxl-3">
                    <div class="col-12 col-xl-4 align-items-xxl-end">
                        <h5 class="mb-0">Danh sách sản phẩm hiện có</h5>
                        <div class="card card-plain h-100">
                            <div class="card-body">
                                <div class="form-group py-1 align-content-xxl-center">
                                    <input type="text" id="productName"
                                           style="border: 1px solid black; width: 300px; height: 35px" class="rounded"
                                           placeholder="Tìm sản phẩm...">
                                    <div id="autocomplete-results" class="autocomplete-results"></div>

                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-12 col-xl-4"></div>

                    <div class="col-12 col-xl-4 justify-content-xxl-end align-content-xxl-end">
                        <label for="showType"><strong class="text-dark" style="font-size: 15px;">Hiển thị:</strong></label>
                        <select id="showType">
                            <option value="0">Tất cả</option>
                            <option value="1">Đã chọn</option>
                            <option value="2">Sắp hết hàng</option>
                        </select>
                    </div>
                </div>

                <br>
                <div class="row">
                    <div class="col-12 col-xl-12">
                        <div class="table-container">
                            <table id="products-available">
                                <thead>
                                <tr>
                                    <th><input type="checkbox" id="checkAllAvailable"/></th>
                                    <th>Ảnh đại diện</th>
                                    <th>Tên sản phẩm</th>
                                    <th>Số lượng hiện tại</th>
                                    <th>Giá bán</th>
                                    <th>Thao tác</th>
                                </tr>
                                </thead>

                                <tbody id="products-available-body">
                                <c:forEach var="productAvailableSingle" items="${productAvailableList}">
                                    <tr id="productAvailableSingle-infor">
                                        <!-- Id -->
                                        <td class="align-content-xxl-center">
                                            <fieldset class='input-group'>
                                                <input type="checkbox" id="productAvailableSingle-id"
                                                       value="${productAvailableSingle.id}"/>
                                            </fieldset>
                                        </td>

                                        <!-- Image -->
                                        <td valign="center">
                                            <c:if test="${not empty productAvailableSingle.image}">
                                                <c:set var="imagePath"
                                                       value="/repository${productAvailableSingle.image}"/>
                                                <img src="${imagePath}" id="viewImage" width="100" height="100"
                                                     style="margin-top: 5px; margin-bottom: 5px"
                                                     alt="Không tìm thấy ảnh">
                                            </c:if>

                                            <c:if test="${empty productAvailableSingle.image}">
                                                <img src="/admin/image/default.png" id="viewImage" width="100"
                                                     height="100"
                                                     alt="Chưa có ảnh">
                                            </c:if>
                                        </td>

                                        <!-- Name -->
                                        <td class="text-dark align-content-xxl-center"
                                            style="color: black">${productAvailableSingle.name}</td>

                                        <!-- Quantity -->
                                        <td class="text-dark align-content-xxl-center">
                                                ${productAvailableSingle.quantity}
                                        </td>

                                        <!-- Price in purchase -->
                                        <td class="text-dark align-content-xxl-center">
                                            <fmt:formatNumber value='${productAvailableSingle.price}' pattern='#,###'/>₫
                                        </td>

                                        <!-- Button to add single -->
                                        <td class="text-dark align-content-xxl-center justify-content-xxl-center">
                                            <button type="button" onclick="addSingle(${productAvailableSingle.id})"
                                                    class="badge badge-circle bg-gradient-info"
                                                    title="Thêm sản phẩm vào danh sách nhập">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                     fill="currentColor" class="bi bi-plus-lg" viewBox="0 0 16 16">
                                                    <path fill-rule="evenodd"
                                                          d="M8 2a.5.5 0 0 1 .5.5v5h5a.5.5 0 0 1 0 1h-5v5a.5.5 0 0 1-1 0v-5h-5a.5.5 0 0 1 0-1h5v-5A.5.5 0 0 1 8 2"/>
                                                </svg>
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-12 col-xl-12" align="right">
                        <button type="button" class="btn btn-facebook bg-gradient-info px-4 py-2 ms-3 mt-2"
                                id="btnAddProduct" title="Thêm các sản phẩm được chọn">
                            Thêm
                        </button>
                    </div>
                </div>
            </div>
            <br>
            <!-- Products import -->
            <div class="row">
                <div class="row pt-xxl-3">
                    <div class="col-12 col-xl-4 align-items-xxl-end">
                        <h5 class="mb-0">Danh sách sản phẩm nhập</h5>
                        <div class="text-dark">
                            <p>Chú ý:</p>
                            <p>- Số lượng nhập của mỗi sản phẩm phải lớn hơn 1</p>
                            <p>- Giá nhập của mỗi sản phẩm phải lớn hơn 1000đ </p>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-12 col-xl-12" align="right">
                        <button type="button"
                                class="btn btn-danger px-4 py-2 ms-3 align-items-xxl-end"
                                id="btnDeleteGroup"
                                title="Xóa các sản phẩm nhập đã chọn">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                 class="bi bi-x-lg" viewBox="0 0 16 16">
                                <path d="M2.146 2.854a.5.5 0 1 1 .708-.708L8 7.293l5.146-5.147a.5.5 0 0 1 .708.708L8.707 8l5.147 5.146a.5.5 0 0 1-.708.708L8 8.707l-5.146 5.147a.5.5 0 0 1-.708-.708L7.293 8z"/>
                            </svg>
                            Xóa hết
                        </button>
                    </div>
                </div>

                <div class="row">
                    <div class="col-12 col-xl-12">
                        <div class="table-container">
                            <table id="product-table">
                                <thead>
                                <tr class="text-center" style="background-color: blue;">
                                    <th><input type="checkbox" id="checkAllImport"/></th>
                                    <th style="color: white;">Ảnh đại diện</th>
                                    <th style="color: white;">Tên sản phẩm</th>
                                    <th style="color: white;">Số lượng nhập</th>
                                    <th style="color: white;">Giá bán</th>
                                    <th style="color: white;">Giá nhập</th>
                                    <th style="color: white;">Thành tiền</th>
                                    <th style="color: white;">Thao tác</th>
                                </tr>
                                </thead>

                                <tbody>
                                <c:forEach var="productImport" items="${sessionScope.productImportList}">
                                    <tr class="text-center" id="product-infor">
                                        <!-- Id -->
                                        <td class="align-content-xxl-center">
                                            <fieldset class='input-group'><input type="checkbox" id="product-id"
                                                                                 value="${productImport.id}"/>
                                            </fieldset>
                                        </td>

                                        <!-- Image -->
                                        <td valign="center">
                                            <c:if test="${not empty productImport.image}">
                                                <c:set var="imagePath" value="/repository${productImport.image}"/>
                                                <img src="${imagePath}" id="viewImage" width="100" height="100"
                                                     style="margin-top: 5px; margin-bottom: 5px"
                                                     alt="Không tìm thấy ảnh">
                                            </c:if>

                                            <c:if test="${empty productImport.image}">
                                                <img src="/admin/image/default.png" id="viewImage" width="100"
                                                     height="100"
                                                     alt="Chưa có ảnh">
                                            </c:if>
                                        </td>

                                        <!-- Name -->
                                        <td class="text-dark align-content-xxl-center"
                                            style="color: black">${productImport.name}</td>

                                        <!-- Quantity -->
                                        <td class="text-dark align-content-xxl-center">
                                            <input type="number" value="${productImport.quantity}" id="quantity"
                                                   style="width: 70px"/>
                                        </td>

                                        <!-- Price in purchase -->
                                        <td class="text-dark align-content-xxl-center">
                                            <fmt:formatNumber value='${productImport.priceInPurchase}' pattern='#,###'/>₫
                                        </td>

                                        <!-- Price import -->
                                        <td class="text-dark align-content-xxl-center">
                                            <input type="number" id="price" value="${productImport.price}"
                                                   style="width: 110px"/>₫
                                        </td>

                                        <!-- Sub total -->
                                        <td id="product-total" class="align-content-xxl-center" style="color: black"
                                            align="right">
                                            <fmt:formatNumber value="${productImport.quantity * productImport.price}"
                                                              pattern="#,###"/>₫
                                        </td>

                                        <!-- Delete button -->
                                        <td class="align-content-xxl-center">
                                            <button type="button" onclick="deleteSingle(${productImport.id})"
                                                    class="btn btn-danger" title="Xóa sản phẩm khỏi danh sách nhập">x
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- Total of import -->
                <div class="row pt-xxl-3 pb-xxl-2">
                    <div class="col-12 col-xl-12" align="right">
                        <strong class="text-dark">Tổng tiền nhập:</strong>
                        <span id="importTotal" class="text-dark" style="font-size: 18px;">
                            <script>
                                const priceImports = document.querySelectorAll('#product-infor');
                                let importTotal = 0;

                                priceImports.forEach(item => {
                                    let quantity = item.querySelector('#quantity').value;
                                    let price = item.querySelector('#price').value;
                                    importTotal += quantity * price;
                                });

                                document.write(importTotal.toLocaleString() + "₫");
                            </script>
                        </span>
                    </div>
                </div>

                <br>
                <div class="row">
                    <div class="col-12 col-xl-5"></div>
                    <div class="col-12 col-xl-4 align-items-xxl-end">
                        <button type="button"
                                class="btn btn-facebook px-4 py-2 ms-3 align-items-xxl-end"
                                id="btnCreate">
                            Tạo
                        </button>

                        <button type="button" class="btn bg-gradient-faded-dark px-3 py-2 ms-3 align-items-xxl-end">
                            <a class="text-white" href="${importListURL}">Quay lại</a>
                        </button>
                    </div>
                </div>
            </div>
        </form:form>
    </div>

</div>

<script>
    let dataOk = 1; // Check each product's quantity is larger than 0, and price is larger than 1000 to execute import
    let productCheckedIds = [];

    $(document).ready(function () {
        // Submit create form
        $('#btnCreate').click(function () {
            $('#form-create').submit();
        });

        // Hide alert on head of page
        setTimeout(function () {
            $('#alertResult').hide()
        }, 2000);

        addProductsAvailableEvent();
    });

    //---------- Product available
    // Check all products
    $('#checkAllAvailable').change(function () {
        let productsAvailable = document.querySelectorAll('#productAvailableSingle-infor');

        if (this.checked) {
            productsAvailable.forEach(item => {
                let idCheckbox = item.querySelector('#productAvailableSingle-id');
                let idCheckboxValue = parseInt(idCheckbox);

                idCheckbox.setAttribute('checked', 'checked');

                if (productCheckedIds.indexOf(idCheckboxValue, 0) === -1) productCheckedIds.push(parseInt(idCheckbox.value));
            });
            console.log('Danh sách id sản phẩm khả dụng sau khi được chọn hết: ')
            console.log(productCheckedIds);
        } else {
            productsAvailable.forEach(item => {
                let idCheckbox = item.querySelector('#productAvailableSingle-id');
                let idCheckboxValue = parseInt(idCheckbox);

                idCheckbox.removeAttribute('checked');

                let idx = productCheckedIds.indexOf(idCheckboxValue, 0);
                if (idx !== -1) productCheckedIds.splice(idx, 1);
            });
            console.log('Danh sách id sản phẩm khả dụng sau khi bỏ chọn hết: ')
            console.log(productCheckedIds);
        }
    });

    //  Filter product's search bar and table
    function addProductsAvailableEvent() {
        const productsAvailable = document.querySelectorAll('#productAvailableSingle-infor');
        productsAvailable.forEach(item => {
            let idCheckbox = item.querySelector('#productAvailableSingle-id');

            idCheckbox.addEventListener('change', function () {
                let idCheckboxValue = parseInt(idCheckbox.value);

                if (idCheckbox.checked) {
                    productCheckedIds.push(idCheckboxValue);
                } else {
                    let idx = productCheckedIds.indexOf(idCheckboxValue, 0);

                    if (idx !== -1) productCheckedIds.splice(idx, 1);
                }
                console.log(productCheckedIds);
            });
        });
    }

    const showType = document.getElementById('showType');
    showType.addEventListener('change', function () {
        let requestURL = "${productAPI}" + "/search";
        let option = parseInt(this.value);

        if (option === 1) {
            if (productCheckedIds.length > 0) requestURL += "?ids=" + productCheckedIds;
        }
        else if(option === 2){
            requestURL += "?isOutOfQuantity=true";
        }

        $.ajax({
            url: requestURL,
            method: "GET",
            contentType: "application/json; charset=UTF-8",
            dataType: "JSON",
            success: function (result) {
                let data = result.data;
                let row = "";

                // Show all product's name
                $.each(data, function (idx, it) {
                    // Fill products-available table
                    row += "<tr id='productAvailableSingle-infor'>\n" +
                        "<td class='align-content-xxl-center'>\n" +
                        "<fieldset class='input-group'>\n" +
                        "<input type='checkbox' id='productAvailableSingle-id' value='" + it.id + "' ";

                    if (productCheckedIds.indexOf(it.id, 0) !== -1) row += "checked";

                    row += "/>\n" +
                        "</fieldset>\n" +
                        "</td>\n";

                    row += "<td valign='center'>\n";
                    if (it.image != null) {
                        row += "<img src='/repository" + it.image + "' id='viewImage' width='100' height='100' " +
                            "style='margin-top: 5px; margin-bottom: 5px' " +
                            "alt='Không tìm thấy ảnh'>\n";
                    } else {
                        row += "<img src='/admin/image/default.png' id='viewImage' width='100' " +
                            "height='100' " +
                            "alt='Chưa có ảnh'>";
                    }
                    row += "</td>\n";

                    row += "<td class='text-dark align-content-xxl-center' style='color: black'>" + it.name + "</td>\n";
                    row += "<td class='text-dark align-content-xxl-center'>" + it.quantity + "</td>\n";
                    row += "<td class='text-dark align-content-xxl-center'>" + it.price.toLocaleString() + "₫</td>\n";
                    row += "<td class='text-dark align-content-xxl-center justify-content-xxl-center'>\n" +
                        "<button type='button' onClick='addSingle(" + it.id + ")' \n" +
                        "class='badge badge-circle bg-gradient-info' \n" +
                        "title='Thêm sản phẩm con'> \n" +
                        "<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' \n" +
                        "fill='currentColor' class='bi bi-plus-lg' viewBox='0 0 16 16'> \n" +
                        "<path fill-rule='evenodd' \n" +
                        "d='M8 2a.5.5 0 0 1 .5.5v5h5a.5.5 0 0 1 0 1h-5v5a.5.5 0 0 1-1 0v-5h-5a.5.5 0 0 1 0-1h5v-5A.5.5 0 0 1 8 2'/> \n" +
                        "</svg>\n" +
                        "</button>\n" +
                        "</td>\n";

                    row += "</tr>\n";
                });

                document.getElementById('products-available-body').innerHTML = row;
                addProductsAvailableEvent();
            },
            error: function (result) {
                console.log(result);
                alert(result.responseJSON.message);
            }
        });
    });

    //---------- Product import
    //---------- Choose product to import
    const productName = document.getElementById("productName");

    productName.addEventListener('keyup', function () {
        var input = document.getElementById("productName").value.trim();
        var resultsContainer = document.getElementById("autocomplete-results");

        // Delete old result
        resultsContainer.innerHTML = '';

        if (input.length >= 1) {
            $.ajax({
                url: "${productAPI}" + "/search?name=" + input,
                method: "GET",
                contentType: "application/json; charset=UTF-8",
                dataType: "JSON",
                success: function (result) {
                    var data = result.data;

                    if (data.length > 0) {
                        let row = "";

                        // Show all product's name
                        $.each(data, function (idx, it) {
                            // Fill search bar
                            let resultsItem = document.createElement("div");

                            resultsItem.textContent = it.name;

                            resultsItem.onclick = function () {
                                document.getElementById("productName").value = it.name;
                                resultsContainer.innerHTML = '';
                            }

                            resultsContainer.appendChild(resultsItem);

                            // Fill products-available table
                            row += "<tr id='productAvailableSingle-infor'>\n" +
                                "<td class='align-content-xxl-center'>\n" +
                                "<fieldset class='input-group'>\n" +
                                "<input type='checkbox' id='productAvailableSingle-id' value='" + it.id + "' ";

                            if (productCheckedIds.indexOf(it.id, 0) !== -1) row += "checked";

                            row += "/>\n" +
                                "</fieldset>\n" +
                                "</td>\n";

                            row += "<td valign='center'>\n";
                            if (it.image != null) {
                                row += "<img src='/repository" + it.image + "' id='viewImage' width='100' height='100' " +
                                    "style='margin-top: 5px; margin-bottom: 5px' " +
                                    "alt='Không tìm thấy ảnh'>\n";
                            } else {
                                row += "<img src='/admin/image/default.png' id='viewImage' width='100' " +
                                    "height='100' " +
                                    "alt='Chưa có ảnh'>";
                            }
                            row += "</td>\n";

                            row += "<td class='text-dark align-content-xxl-center' style='color: black'>" + it.name + "</td>\n";
                            row += "<td class='text-dark align-content-xxl-center'>" + it.quantity + "</td>\n";
                            row += "<td class='text-dark align-content-xxl-center'>" + it.price.toLocaleString() + "₫</td>\n";
                            row += "<td class='text-dark align-content-xxl-center justify-content-xxl-center'>\n" +
                                "<button type='button' onClick='addSingle(" + it.id + ")' \n" +
                                "class='badge badge-circle bg-gradient-info' \n" +
                                "title='Thêm sản phẩm con'> \n" +
                                "<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' \n" +
                                "fill='currentColor' class='bi bi-plus-lg' viewBox='0 0 16 16'> \n" +
                                "<path fill-rule='evenodd' \n" +
                                "d='M8 2a.5.5 0 0 1 .5.5v5h5a.5.5 0 0 1 0 1h-5v5a.5.5 0 0 1-1 0v-5h-5a.5.5 0 0 1 0-1h5v-5A.5.5 0 0 1 8 2'/> \n" +
                                "</svg>\n" +
                                "</button>\n" +
                                "</td>\n";

                            row += "</tr>\n";
                        });

                        document.getElementById('products-available-body').innerHTML = row;
                        addProductsAvailableEvent();
                    } else {
                        // Show notice
                        var resultsNotFound = document.createElement('div');
                        resultsNotFound.textContent = "Không tìm thấy sản phẩm nào";
                        resultsContainer.appendChild(resultsNotFound);
                    }
                },
                error: function (result) {
                    console.log(result);
                    alert(result.responseJSON.message);
                }
            });
        }
    });

    // Hide search result when click outside
    document.addEventListener('click', function (event) {
        var searchInput = document.getElementById('productName');
        var resultsContainer = document.getElementById('autocomplete-results');
        var targetElement = event.target; // element clicked

        if (targetElement !== searchInput && targetElement !== resultsContainer && !resultsContainer.contains(targetElement)) {
            resultsContainer.innerHTML = '';
        }
    });

    // Add single product to import
    function addSingle(id) {
        productCheckedIds = [];
        productCheckedIds.push(id);
        addProductToImport();
    }

    $('#btnAddProduct').click(function () {
        if (productCheckedIds.length === 0) {
            alert("Bạn phải chọn sản phẩm để nhập!");
        } else {
            addProductToImport();
        }
    });

    function addProductToImport() {
        $.ajax({
            url: "${importAPI}" + "/addToImportList/" + productCheckedIds,
            method: "POST",
            contentType: "application/json; charset=UTF-8",
            dataType: "JSON",
            success: function (result) {
                alert(result.message);
                location.reload();
            },
            error: function (result) {
                console.log(result);
                alert(result.responseJSON.message);
            }
        });
    }

    //----------- Change (product to import)'s information
    // Change quantity
    const quantityInputs = document.querySelectorAll('#quantity');
    quantityInputs.forEach(quantity => {
        quantity.addEventListener('keyup', function () {
            const row = this.parentElement.parentElement; // quantity input -> <td> -> <tr>

            const idValue = row.querySelector('#product-id').value.trim();
            const quantityValue = this.value.trim();
            const priceValue = row.querySelector('#price').value.trim();

            let json = {};
            json["id"] = idValue;
            json["quantity"] = quantityValue;

            console.log(json);

            $.ajax({
                url: "${importAPI}" + "/changeProductImport",
                method: "PUT",
                data: JSON.stringify(json),
                contentType: "application/json; charset=UTF-8",
                dataType: "JSON",
                success: function (result) {
                    // Reset product's total
                    let total = quantityValue * priceValue;
                    row.querySelector('#product-total').textContent = total.toLocaleString() + "₫";

                    // Reset import's total
                    resetImportTotal();
                },
                error: function (result) {
                    alert(result.responseJSON.message);
                }
            });
        });
    });

    // Change price
    const priceInputs = document.querySelectorAll('#price');
    priceInputs.forEach(price => {
        price.addEventListener('keyup', function () {
            const row = this.parentElement.parentElement; // price input -> <td> -> <tr>

            const idValue = row.querySelector('#product-id').value.trim();
            const quantityValue = row.querySelector('#quantity').value.trim();
            const priceValue = this.value.trim();

            let json = {};
            json["id"] = idValue;
            json["price"] = priceValue;

            console.log(json);

            $.ajax({
                url: "${importAPI}" + "/changeProductImport",
                method: "PUT",
                data: JSON.stringify(json),
                contentType: "application/json; charset=UTF-8",
                dataType: "JSON",
                success: function (result) {
                    // Reset product's total
                    let total = quantityValue * priceValue;
                    row.querySelector('#product-total').textContent = total.toLocaleString() + "₫";

                    // Reset import's total
                    resetImportTotal();
                },
                error: function (result) {
                    alert(result.responseJSON.message);
                }
            });
        });
    });

    function resetImportTotal() {
        const priceImports = document.querySelectorAll('#product-infor');
        let importTotal = 0;

        priceImports.forEach(item => {
            let quantity = item.querySelector('#quantity').value;
            let price = item.querySelector('#price').value;
            importTotal += quantity * price;
        });

        document.getElementById('importTotal').textContent = importTotal.toLocaleString() + "₫";
    }


    //---------- Delete product to import
    // Check or uncheck all
    $('#checkAllImport').change(function () {
        if (this.checked) {
            document.querySelectorAll('#product-id').forEach(item => {
                item.setAttribute('checked', 'checked');
            });
        } else {
            document.querySelectorAll('#product-id').forEach(item => {
                item.removeAttribute('checked');
            });
        }
    });

    // Delete product
    function deleteSingle(productId) {
        if (confirm('Bạn chắc chắc muốn xóa sản phẩm này ?')) {
            deleteProductImport(productId);
        }
    }

    $('#btnDeleteGroup').click(function () {
        let productIds = $('#product-table').find('tbody input[type=checkbox]:checked').map(function () {
            return $(this).val();
        }).get();

        console.log(productIds);

        if (productIds.length < 1) {
            alert('Bạn chưa chọn sản phẩm nào !');
        } else if (confirm('Bạn chắc chắn muốn xóa các sản phẩm được chọn?')) {
            deleteProductImport(productIds);
        }
    });

    function deleteProductImport(productIds) {
        $.ajax({
            url: "${importAPI}" + "/deleteProductImport" + "/" + productIds,
            method: "DELETE",
            contentType: "application/json; charset=UTF-8",
            dataType: "JSON",
            success: function (result) {
                alert(result.message);
                location.reload();
            },
            error: function (result) {
                alert(result.responseJSON.message);
            }
        });
    }

    $(function () {
        $("form[name='form-create']").validate({
            // name, address, email, phone, note
            rules: {
                name: "required",
                address: "required",
                email: "required",
                phoneNumber: {
                    required: true,
                    minlength: 10,
                    maxlength: 10
                },
                note: "required"
            },
            messages: {
                name: {
                    required: "<span style='color: red'>Phải nhập tên nhà cung cấp !</span>"
                },
                address: {
                    required: "<span style='color: red'>Phải nhập địa chỉ !</span>"
                },
                email: {
                    required: "<span style='color: red'>Phải nhập email !</span>"
                },
                phoneNumber: {
                    required: "<span style='color: red'>Phải nhập số điện thoại !</span>",
                    minlength: "<span style='color: red'>Số điện thoại phải có đủ 10 chữ số !</span>",
                    maxlength: "<span style='color: red'>Số điện thoại phải có đủ 10 chữ số !</span>"
                },
                note: {
                    required: "<span style='color: red'>Phải nhập ghi chú !</span>"
                }
            },
            submitHandler: function () {
                var json = {};
                var formData = $('#form-create').serializeArray();

                $.each(formData, function (idx, it) {
                    json["" + it.name + ""] = it.value.trim();
                });

                let numberOfProduct = document.querySelectorAll('#quantity');
                if (numberOfProduct.length < 1) {
                    alert('Bạn phải chọn hàng nhập !');
                }

                const productInfos = document.querySelectorAll('#product-infor');
                productInfos.forEach(item => {
                    let quantityElement = item.querySelector('#quantity');
                    let priceElement = item.querySelector('#price');

                    let quantity = parseInt(quantityElement.value);
                    let price = parseInt(priceElement.value);

                    let quantityWarning = item.querySelector('#quantityWarning');
                    let priceWarning = item.querySelector('#priceWarning');
                    if (quantityWarning != null) quantityWarning.remove();
                    if (priceWarning != null) priceWarning.remove();

                    if (quantity < 1) {
                        dataOk = 0;
                        let newQuantityWarning = document.createElement("div");
                        newQuantityWarning.setAttribute('id', 'quantityWarning');
                        newQuantityWarning.setAttribute('style', 'color: red');
                        newQuantityWarning.textContent = "Số lượng nhập phải lớn hơn 0!";
                        quantityElement.after(newQuantityWarning);
                    }
                    if (price < 1000) {
                        dataOk = 0;
                        let newPriceWarning = document.createElement("div");
                        newPriceWarning.setAttribute('id', 'priceWarning');
                        newPriceWarning.setAttribute('style', 'color: red');
                        newPriceWarning.textContent = "Giá nhập tối thiểu là 1000đ!";
                        priceElement.after(newPriceWarning);
                    }
                });

                if (dataOk !== 1) {
                    alert('Hãy kiểm tra dữ liệu của các sản phẩm nhập !');
                    dataOk = 1;
                } else if (confirm('Xác nhận các thông tin chính xác?')) {
                    createImport(json);
                }
            }
        });
    });

    function createImport(json) {
        $.ajax({
            url: "${importAPI}",
            method: "POST",
            data: JSON.stringify(json),
            contentType: "application/json; charset=UTF-8",
            dataType: "JSON",
            success: function (result) {
                console.log(result.data);
                if (result.data === 'insert_success') {
                    window.location.href = "<c:url value='/admin/import-create?message=insert_success'/>";
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