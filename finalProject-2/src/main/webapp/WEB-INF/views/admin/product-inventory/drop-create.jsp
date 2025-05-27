<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>
<c:url var="productInventoryAPI" value="/api/admin/productInventories"/>
<c:url var="productInventoryListURL" value="/admin/productInventory-list"/>
<c:url var="dropCreateURL" value="/admin/productInventory-drop"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Bỏ hàng</title>
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
        <div class="row gx-4 mb-2">
            <div class="col-auto my-auto">
                <div class="h-100 align-items-center">
                    <h4 class="mb-1">Tạo lần bỏ hàng</h4>
                </div>
            </div>
        </div>

        <!-- Products available -->
        <div class="row">
            <!-- Products -->
            <div class="row pt-xxl-3">
                <div class="col-12 col-xl-4 align-items-xxl-end">
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-12 col-xl-12">

                <div class="row">
                    <div class="row pt-xxl-3">
                        <h5 class="mb-0">Danh sách sản phẩm con hiện có</h5>
                        <p class="text-dark">- Chọn sản phẩm cần bỏ (hết hạn, thối, dập nát...) để bỏ.</p>
                        <div class="col-12 col-xl-4 align-items-xxl-end">
                            <div class="card card-plain h-100">
                                <div class="card-body">
                                    <div class="form-group py-1 align-content-xxl-center">
                                        <input type="text" id="productId"
                                               style="border: 1px solid black; width: 300px; height: 35px"
                                               class="rounded"
                                               placeholder="Nhập mã sản phẩm con...">
                                        <div id="autocomplete-results" class="autocomplete-results"></div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-12 col-xl-4"></div>

                        <div class="col-12 col-xl-4 justify-content-xxl-end align-content-xxl-end">
                            <label for="showType"><strong class="text-dark">Hiển thị:</strong></label>
                            <select id="showType">
                                <option value="0">Tất cả</option>
                                <option value="1">Đã chọn</option>
                                <option value="2">Đã hết hạn sử dụng</option>
                                <option value="3">Đã ngừng bán</option>
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
                                        <th>
                                            <fieldset class='input-group justify-content-xxl-center'><input id="checkAllAvailable" type="checkbox">
                                            </fieldset>
                                        </th>
                                        <th>Mã sản phẩm con</th>
                                        <th>Ảnh đại diện</th>
                                        <th>Tên sản phẩm con</th>
                                        <th>Giá nhập</th>
                                        <th>Thao tác</th>
                                    </tr>
                                    </thead>

                                    <tbody id="products-available-body">
                                    <c:forEach var="productAvailableSingle" items="${productInventoryAvailableList}">
                                        <tr id="productAvailableSingle-infor">
                                            <!-- Id -->
                                            <td class="align-content-xxl-center">
                                                <fieldset class='input-group'>
                                                    <input type="checkbox" id="productAvailableSingle-id"
                                                           value="${productAvailableSingle.id}"/>
                                                </fieldset>
                                            </td>

                                            <td class="text-dark align-content-xxl-center"
                                                style="color: black">${productAvailableSingle.id}</td>

                                            <!-- Image -->
                                            <td valign="center">
                                                <c:if test="${not empty productAvailableSingle.productDTO.image}">
                                                    <c:set var="imagePath"
                                                           value="/repository${productAvailableSingle.productDTO.image}"/>
                                                    <img src="${imagePath}" id="viewImage" width="100" height="100"
                                                         style="margin-top: 5px; margin-bottom: 5px"
                                                         alt="Không tìm thấy ảnh">
                                                </c:if>

                                                <c:if test="${empty productAvailableSingle.productDTO.image}">
                                                    <img src="/admin/image/default.png" id="viewImage" width="100"
                                                         height="100"
                                                         alt="Chưa có ảnh">
                                                </c:if>
                                            </td>

                                            <!-- Name -->
                                            <td class="text-dark align-content-xxl-center"
                                                style="color: black">${productAvailableSingle.name}</td>

                                            <!-- Price in import -->
                                            <td class="text-dark align-content-xxl-center">
                                                <fmt:formatNumber value='${productAvailableSingle.priceInImport}'
                                                                  pattern='#,###'/>₫
                                            </td>

                                            <!-- Button to add single -->
                                            <td class="text-dark align-content-xxl-center justify-content-xxl-center">
                                                <button type="button" onclick="addSingle(${productAvailableSingle.id})"
                                                        class="badge badge-circle bg-gradient-info"
                                                        title="Thêm sản phẩm con vào danh sách bỏ">
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
                                    id="btnAddProduct" title="Thêm các sản phẩm con được chọn">
                                Thêm
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <!-- Products -->
            <div class="row pt-xxl-3">
                <div class="col-12 col-xl-12 align-items-xxl-end">
                    <h5 class="mb-0">Danh sách sản phẩm con bỏ đi</h5>
                    <p class="text-dark">Chú ý:</p>
                    <p class="text-dark">- Cần ghi rõ lý do bỏ sản phẩm con.</p>
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
        </div>

        <div class="row">
            <div class="col-12 col-xl-12">
                <div class="table-container">
                    <table id="product-table">
                        <thead>
                        <tr>
                            <th style="background-color: red"><fieldset class='input-group'><input id="checkAllDrop" type="checkbox"></fieldset></th>
                            <th style="background-color: red">Mã sản phẩm con</th>
                            <th style="background-color: red">Ảnh đại diện</th>
                            <th style="background-color: red">Tên sản phẩm con</th>
                            <th style="background-color: red">Lý do bỏ</th>
                            <th style="background-color: red">Thao tác</th>
                        </tr>
                        </thead>

                        <tbody>
                        <c:forEach var="productDrop" items="${sessionScope.productDropList}">
                            <tr class="text-center" id="product-infor">
                                <!-- Id -->
                                <td class="align-content-xxl-center">
                                    <fieldset class='input-group'><input type="checkbox" id="product-id"
                                                                         value="${productDrop.id}"/></fieldset>
                                </td>

                                <!-- Id -->
                                <td class="text-dark align-content-xxl-center"
                                    style="color: black">${productDrop.id}</td>

                                <td valign="center">
                                    <c:if test="${not empty productDrop.image}">
                                        <c:set var="imagePath" value="/repository${productDrop.image}"/>
                                        <img src="${imagePath}" id="viewImage" width="100" height="100"
                                             style="margin-top: 5px; margin-bottom: 5px" alt="Không tìm thấy ảnh">
                                    </c:if>

                                    <c:if test="${empty productDrop.image}">
                                        <img src="/admin/image/default.png" id="viewImage" width="100" height="100"
                                             alt="Chưa có ảnh">
                                    </c:if>
                                </td>

                                <!-- Name -->
                                <td class="text-dark align-content-xxl-center"
                                    style="color: black">${productDrop.name}</td>

                                <!-- Reason to drop -->
                                <td class="text-dark align-content-xxl-center">
                                        <textarea id="description" style="width: 200px" rows="3">
                                                ${productDrop.note}
                                        </textarea>
                                </td>

                                <!-- Delete button -->
                                <td class="align-content-xxl-center justify-content-xxl-center">
                                    <button type="button" onclick="deleteSingle(${productDrop.id})"
                                            class="btn btn-danger" title="Xóa sản phẩm con khỏi danh sách bỏ">x
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Total quantity of drop -->
            <div class="row pt-xxl-3 pb-xxl-2">
                <div class="col-12 col-xl-12 text-end">
                    <strong class="text-dark">Tổng số sản phẩm bỏ:</strong>
                    <span id="dropTotal" class="text-dark">
                    <script>
                        document.write(document.querySelectorAll('#product-infor').length);
                    </script>
                </span>
                </div>
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
                    <a class="text-white" href="${productInventoryListURL}">Quay lại</a>
                </button>
            </div>
        </div>
    </div>

</div>

<script>
    let dataOk = 1; // Check each product's quantity is larger than 0 to execute drop
    let productCheckedIds = [];

    $(document).ready(function () {
        // Hide alert on head of page
        setTimeout(function () {
            $('#alertResult').hide()
        }, 2000);

        addProductsAvailableEvent();
    });

    //---------- Product available
    // Check all or uncheck all
    $('#checkAllAvailable').change(function () {
        const productsAvailable = document.querySelectorAll('#productAvailableSingle-infor');

        if (this.checked) {
            productsAvailable.forEach(item => {
                let idCheckbox = item.querySelector('#productAvailableSingle-id')
                let idCheckboxValue = parseInt(idCheckbox.value);

                idCheckbox.setAttribute('checked', 'checked');

                let idx = productCheckedIds.indexOf(idCheckboxValue, 0);

                if(idx === -1) productCheckedIds.push(idCheckboxValue);
            });
            console.log('Sau khi checkAll thì danh sách id (checked) là: ');
            console.log(productCheckedIds);
        }
        else{
             productsAvailable.forEach(item => {
                let idCheckbox = item.querySelector('#productAvailableSingle-id')
                let idCheckboxValue = parseInt(idCheckbox.value);

                idCheckbox.removeAttribute('checked');

                let idx = productCheckedIds.indexOf(idCheckboxValue, 0);

                if(idx !== -1) productCheckedIds.splice(idx, 1);
            });
            console.log('Sau khi bỏ checkAll thì danh sách id (checked) là: ');
            console.log(productCheckedIds);
        }
    });

    // Filter product's search bar and table
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

    const showTypes = document.getElementById('showType');
    showTypes.addEventListener('change', function () {
        let requestURL = "${productInventoryAPI}" + "/search";
        let option = parseInt($('#showType').val());

        if (option === 1 && productCheckedIds.length > 0) requestURL += "?ids=" + productCheckedIds;
        else if (option === 2) requestURL += "?isExpired=true";
        else if(option === 3) requestURL += "?isLocked=true";

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

                    row += "<td class='text-dark align-content-xxl-center' style='color: black'>" + it.id + "</td>\n";

                    row += "<td valign='center'>\n";
                    if (it.productDTO.image != null) {
                        row += "<img src='/repository" + it.productDTO.image + "' id='viewImage' width='100' height='100' " +
                            "style='margin-top: 5px; margin-bottom: 5px' " +
                            "alt='Không tìm thấy ảnh'>\n";
                    } else {
                        row += "<img src='/admin/image/default.png' id='viewImage' width='100' " +
                            "height='100' " +
                            "alt='Chưa có ảnh'>";
                    }
                    row += "</td>\n";

                    row += "<td class='text-dark align-content-xxl-center' style='color: black'>" + it.productDTO.name + "</td>\n";
                    row += "<td class='text-dark align-content-xxl-center'>" + it.priceInImport.toLocaleString() + "₫</td>\n";
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

    // Choose product to drop
    const productId = document.getElementById("productId");
    productId.addEventListener('keyup', function () {
        let input = $('#productId').val().trim();
        let resultsContainer = document.getElementById("autocomplete-results");

        // Delete old result
        resultsContainer.innerHTML = '';

        if (input.length >= 1) {
            $.ajax({
                url: "${productInventoryAPI}" + "/search?id=" + parseInt(input),
                method: "GET",
                contentType: "application/json; charset=UTF-8",
                dataType: "JSON",
                success: function (result) {
                    let data = result.data;
                    let row = "";

                    if (data.length > 0) {
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

                            row += "<td class='text-dark align-content-xxl-center' style='color: black'>" + it.id + "</td>\n";

                            row += "<td valign='center'>\n";
                            if (it.productDTO.image != null) {
                                row += "<img src='/repository" + it.productDTO.image + "' id='viewImage' width='100' height='100' " +
                                    "style='margin-top: 5px; margin-bottom: 5px' " +
                                    "alt='Không tìm thấy ảnh'>\n";
                            } else {
                                row += "<img src='/admin/image/default.png' id='viewImage' width='100' " +
                                    "height='100' " +
                                    "alt='Chưa có ảnh'>";
                            }
                            row += "</td>\n";

                            row += "<td class='text-dark align-content-xxl-center' style='color: black'>" + it.productDTO.name + "</td>\n";
                            row += "<td class='text-dark align-content-xxl-center'>" + it.priceInImport.toLocaleString() + "₫</td>\n";
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
                        let resultsNotFound = document.createElement('div');
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
        var searchInput = document.getElementById('productId');
        var resultsContainer = document.getElementById('autocomplete-results');
        var targetElement = event.target; // element clicked

        if (targetElement !== searchInput && targetElement !== resultsContainer && !resultsContainer.contains(targetElement)) {
            resultsContainer.innerHTML = '';
        }
    });

    // Add single product to drop
    function addSingle(id) {
        productCheckedIds = [];
        productCheckedIds.push(id);
        addProductToDrop();
    }

    // Add products to drop
    $('#btnAddProduct').click(function () {
        if (productCheckedIds.length === 0) {
            alert("Bạn phải chọn sản phẩm để bỏ!");
        } else {
            addProductToDrop(1);
        }
    });

    function addProductToDrop() {
        $.ajax({
            url: "${productInventoryAPI}" + "/addToDropList/" + productCheckedIds,
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

    //---------- Drop
    // Check all or uncheck all
    $('#checkAllDrop').change(function () {
        const productsDrop = document.querySelectorAll('#product-infor');

        if (this.checked) {
            productsDrop.forEach(item => {
                item.querySelector('#product-id').setAttribute('checked', 'checked');
            });
        }
        else{
             productsDrop.forEach(item => {
                item.querySelector('#product-id').removeAttribute('checked');
            });
        }
    });

    // Change description
    const noteDrops = document.querySelectorAll('#note');
    noteDrops.forEach(quantity => {
        quantity.addEventListener('keyup', function () {
            const row = this.parentElement.parentElement; // quantity input -> <td> -> <tr>

            const idValue = row.querySelector('#product-id').value.trim();
            const description = this.value.trim();

            let json = {};
            json["id"] = idValue;
            json["note"] = description;

            console.log(json);

            $.ajax({
                url: "${productInventoryAPI}" + "/changeProductDrop",
                method: "PUT",
                data: JSON.stringify(json),
                contentType: "application/json; charset=UTF-8",
                dataType: "JSON",
                success: function (result) {

                },
                error: function (result) {
                    alert(result.responseJSON.message);
                }
            });
        });
    });

    function resetDropTotal() {
        document.getElementById('dropTotal').textContent = document.querySelectorAll('#product-infor').length;
    }

    // Delete product to drop
    function deleteSingle(productId) {
        if (confirm('Bạn chắc chắc muốn xóa sản phẩm này ?')) {
            deleteProductDrop(productId);
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
            deleteProductDrop(productIds);
        }
    });

    function deleteProductDrop(productIds) {
        $.ajax({
            url: "${productInventoryAPI}" + "/deleteProductDrop" + "/" + productIds,
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

    $('#btnCreate').click(function () {
        if (document.querySelectorAll('#product-infor').length < 1) {
            alert('Bạn phải chọn hàng bỏ !');
        } else {
            const productInfos = document.querySelectorAll('#product-infor');

            productInfos.forEach(item => {
                let noteElement = item.querySelector('#description');

                let noteWarning = item.querySelector('#noteWarning');
                if (noteWarning != null) noteWarning.remove();

                if (noteElement.value.trim().length < 1) {
                    dataOk = 0;
                    let newNoteWarning = document.createElement("div");
                    newNoteWarning.setAttribute('id', 'noteWarning');
                    newNoteWarning.setAttribute('style', 'color: red');
                    newNoteWarning.textContent = "Phải nhập lý do bỏ!";
                    noteElement.after(newNoteWarning);
                }
            });

            if (dataOk !== 1) {
                alert('Hãy kiểm tra dữ liệu của các sản phẩm bỏ !');
                dataOk = 1;
            } else if (confirm('Xác nhận các thông tin chính xác?')) {
                createDrop();
            }
        }
    });

    function createDrop() {
        $.ajax({
            url: "${productInventoryAPI}",
            method: "PUT",
            contentType: "application/json; charset=UTF-8",
            dataType: "JSON",
            success: function (result) {
                console.log(result.data);
                if (result.data === 'update_success') {
                    window.location.href = "<c:url value='${dropCreateURL}?message=update_success'/>";
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