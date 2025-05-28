<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 3/13/2025
  Time: 5:44 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>
<html>
<head>
    <title><dec:title/></title>

    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link href="https://fonts.googleapis.com/css?family=Poppins:200,300,400,500,600,700,800&display=swap"
          rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Lora:400,400i,700,700i&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Amatic+SC:400,700&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="<c:url value='web-user/css/open-iconic-bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='web-user/css/animate.css'/>">

    <link rel="stylesheet" href="<c:url value='web-user/css/owl.carousel.min.css'/> ">
    <link rel="stylesheet" href="<c:url value='web-user/css/owl.theme.default.min.css'/>">
    <link rel="stylesheet" href="<c:url value='web-user/css/magnific-popup.css'/>">

    <link rel="stylesheet" href="<c:url value='web-user/css/aos.css'/>">

    <link rel="stylesheet" href="<c:url value='web-user/css/ionicons.min.css'/>">

    <link rel="stylesheet" href="<c:url value='web-user/css/bootstrap-datepicker.css'/>">
    <link rel="stylesheet" href="<c:url value='web-user/css/jquery.timepicker.css'/>">

    <link rel="stylesheet" href="<c:url value='web-user/css/flaticon.css'/>">
    <link rel="stylesheet" href="<c:url value='web-user/css/icomoon.css'/>">
    <link rel="stylesheet" href="<c:url value='web-user/css/style.css'/>">

    <link rel="stylesheet" href="<c:url value='web-user/css/leftMenu-MyAccount.css'/>">
    <link rel="stylesheet" href="<c:url value='https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.2.0/remixicon.css'/>">

    <!-- For using jQuery, ajax -->
    <!--  jquery script  -->
    <script src="http://code.jquery.com/jquery-3.2.1.min.js"></script>

    <!--  validation script  -->
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.19.0/jquery.validate.min.js"></script>

    <!--  jsrender script  -->
    <script src="http://cdn.syncfusion.com/js/assets/external/jsrender.min.js"></script>

    <!-- Essential JS UI widget -->
    <script src="http://cdn.syncfusion.com/16.4.0.52/js/web/ej.web.all.min.js"></script>
</head>

<body>
<!-- Navbar -->
<%@include file="/common/web/header.jsp" %>

<div class="hero-wrap hero-bread" style="background-image: url('web-user/images/bg_1.jpg');">
    <div class="container">
        <div class="row no-gutters slider-text align-items-center justify-content-center">
            <div class="col-md-9 ftco-animate text-center">
                <p class="breadcrumbs"><span class="mr-2"><a href="/home">Trang chủ</a></span></p>
                <h1 class="mb-0 bread">Tài khoản</h1>
            </div>
        </div>
    </div>
</div>

<section class="ftco-section">
    <div class="body__below__header">
        <!-- Left side menu -->
        <%@include file="/common/web/my-account/left-side-menu.jsp" %>

        <div class="body__content ftco-animate">
            <!-- All features of user -->
            <dec:body/>
        </div>
    </div>
</section> <!-- .section -->

<!-- Footer -->
<%@include file="/common/web/footer.jsp" %>

<script src="web-user/js/jquery-migrate-3.0.1.min.js"></script>
<script src="web-user/js/popper.min.js"></script>
<script src="web-user/js/bootstrap.min.js"></script>
<script src="web-user/js/jquery.easing.1.3.js"></script>
<script src="web-user/js/jquery.waypoints.min.js"></script>
<script src="web-user/js/jquery.stellar.min.js"></script>
<script src="web-user/js/owl.carousel.min.js"></script>
<script src="web-user/js/jquery.magnific-popup.min.js"></script>
<script src="web-user/js/aos.js"></script>
<script src="web-user/js/jquery.animateNumber.min.js"></script>
<script src="web-user/js/bootstrap-datepicker.js"></script>
<script src="web-user/js/scrollax.min.js"></script>
<%--    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>--%>
<%--    <script src="js/google-map.js"></script>--%>
<script src="web-user/js/main.js"></script>

<script src="web-user/js/leftMenu-MyAccount.js"></script>

<script>
    <c:set var="categoryAPI" value="/api/categories"/>
    <c:set var="categoryId" value="categoryId"/>
    <c:set var="productAPI" value="/api/products"/>
    <c:set var="shopURL" value="/shop"/>
    <c:set var="productSingleURL" value="/product-single"/>

    $(document).ready(function () {
        findParentCategory();
        resultsContainer.style.display = 'none';

        $('#productName').val("${param.productName}");
    });

    //---------- Show product categories
    function findParentCategory() {
        $.ajax({
            url: "${categoryAPI}",
            method: "GET",
            contentType: "application/json; charset=UTF-8",
            dataType: "JSON",
            success: function (result) {
                let categories = result.data;
                let row = "";

                $.each(categories, function (idx, it) {
                    if (it.parentId == null) row += "<a class='dropdown-item' href='${shopURL}?${categoryId}=" + it.id + "'><strong>" + it.name + "</strong></a>\n";
                    else row += "<a class='dropdown-item' href='${shopURL}?${categoryId}=" + it.id + "'>" + it.name + "</a>\n";
                });

                document.getElementById('allCategory').innerHTML = row;
            },
            error: function (result) {
                alert(result.responseJSON.message);
            }
        });
    }

    //---------- Choose product's name to search
    const productName = document.getElementById("productName");
    let resultsContainer = document.getElementById("autocompleteProduct");

    productName.addEventListener('keyup', function (event) {
        event.preventDefault();

        if (event.key !== 'Enter') {
            let input = document.getElementById("productName").value.trim();

            // Delete old result
            resultsContainer.innerHTML = '';

            if (input.length >= 1) {
                $.ajax({
                    url: "${productAPI}" + "/search?name=" + input,
                    method: "GET",
                    contentType: "application/json; charset=UTF-8",
                    dataType: "JSON",
                    success: function (result) {
                        let data = result.data;

                        if (data.length > 0) {
                            // Show all product's name
                            $.each(data, function (idx, it) {
                                let resultsItem = document.createElement("div");

                                let row = "<div class='row autocompleteProductSub'>\n";
                                row += "<div class='col-lg-12'>\n"
                                row += "<div class='input-group'>\n"
                                row += "<div class='col-lg-3' align='center'><img src='/repository" + it.image + "' width='40' height='40' alt='Ảnh sản phẩm'></div>\n"
                                row += "<div class='col-lg-6'>" + it.name + "</div>\n";
                                row += "<div class='col-lg-3 text-danger'>" + (it.price - it.price * it.discount / 100).toLocaleString() + "₫" + "</div>\n";
                                row += "</div>\n";
                                row += "</div>\n";
                                row += "</div>\n";

                                resultsItem.innerHTML = row;

                                resultsItem.onclick = function () {
                                    document.getElementById("productName").value = it.name;
                                    window.location.href = "${productSingleURL}-" + it.id;
                                    resultsContainer.innerHTML = '';
                                }

                                resultsContainer.appendChild(resultsItem);
                            });

                            resultsContainer.style.display = 'block';
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
        } else {
            let productNameSearch = document.getElementById('productName').value.trim();

            window.location.href = '${shopURL}?productName=' + productNameSearch;
        }
    });

    // Hide search result when click outside
    document.addEventListener('click', function (event) {
        let searchInput = document.getElementById('productName');
        let targetElement = event.target; // element clicked

        if (targetElement !== searchInput && targetElement !== resultsContainer && !resultsContainer.contains(targetElement)) {
            resultsContainer.innerHTML = '';
            resultsContainer.style.display = 'none';
        }
    });

    $('#btnSearchProduct').click(function (event) {
        event.preventDefault();
        let productNameSearch = document.getElementById('productName').value.trim();

        window.location.href = '${shopURL}?productName=' + productNameSearch;
    });
</script>
</body>
</html>
