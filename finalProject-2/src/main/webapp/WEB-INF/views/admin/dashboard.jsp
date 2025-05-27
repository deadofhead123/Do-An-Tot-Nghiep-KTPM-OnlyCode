<!--
=========================================================
* Material Dashboard 3 - v3.2.0
=========================================================

* Product Page: https://www.creative-tim.com/product/material-dashboard
* Copyright 2024 Creative Tim (https://www.creative-tim.com)
* Licensed under MIT (https://www.creative-tim.com/license)
* Coded by Creative Tim

=========================================================

* The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.javaweb.util.OrderStatusCode" %>
<%@include file="/common/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Thống kê</title>

    <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="Stylesheet"
          type="text/css"/>
</head>

<body class="g-sidenav-show  bg-gray-100">
<div class="container-fluid py-2">
    <div class="row">
        <div class="ms-3">
            <h3 class="mb-0 h4 font-weight-bolder">Thống kê số liệu</h3>
            <p class="mb-4 text-dark">
                Kiểm tra số liệu theo tháng, năm; các mặt hàng bán chạy
            </p>
        </div>

        <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
            <div class="card">
                <div class="card-header p-3 ps-3">
                    <div class="d-flex justify-content-between">
                        <div class="text-dark">
                            <p class="text-sm mb-0 text-capitalize">Doanh thu hôm nay</p>
                            <h4 class="mb-0"><fmt:formatNumber value="${revenueToday}" pattern="#,###"/> đ</h4>
                        </div>
                        <div class="icon icon-md icon-shape bg-gradient-dark shadow-dark shadow text-center border-radius-lg">
                            <i class="material-symbols-rounded opacity-10">leaderboard</i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-sm-6">
            <div class="card">
                <div class="card-header p-3 ps-3">
                    <div class="d-flex justify-content-between">
                        <div class="text-dark">
                            <p class="text-sm mb-0 text-capitalize">Chi tiêu hôm nay</p>
                            <h4 class="mb-0"><fmt:formatNumber value="${importToday}" pattern="#,###"/> đ</h4>
                        </div>
                        <div class="icon icon-md icon-shape bg-gradient-dark shadow-dark shadow text-center border-radius-lg">
                            <i class="material-symbols-rounded opacity-10">warehouse</i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
            <div class="card">
                <div class="card-header p-3 ps-3">
                    <div class="d-flex justify-content-between">
                        <div class="text-dark">
                            <p class="text-sm mb-0 text-capitalize">Nguời dùng mới</p>
                            <h4 class="mb-0"><fmt:formatNumber value="${userQuantity}" pattern="#,###"/></h4>
                        </div>
                        <div class="icon icon-md icon-shape bg-gradient-dark shadow-dark shadow text-center border-radius-lg">
                            <i class="material-symbols-rounded opacity-10">person</i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
            <div class="card">
                <div class="card-header p-3 ps-3">
                    <div class="d-flex justify-content-between">
                        <div class="text-dark">
                            <p class="text-sm mb-0 text-capitalize">Lượt xem tin tức</p>
                            <h4 class="mb-0"><fmt:formatNumber value="${newsViews}" pattern="#,###"/></h4>
                        </div>
                        <div class="icon icon-md icon-shape bg-gradient-dark shadow-dark shadow text-center border-radius-lg">
                            <i class="material-symbols-rounded opacity-10">news</i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <!-- Revenue by month (bar + line chart) -->
        <div class="col-lg-12 col-md-6 mt-4 mb-4">
            <div class="card ">
                <div class="card-body">
                    <h5 class="mb-0 pb-1"> Số liệu theo tháng </h5>
                    <div class="justify-content-xxl-end ms-2">
                        <label class="text-dark" style="font-size: 16px;">Hiển thị: </label>
                        <select id="monthShowType" class="text-dark">
                            <option value="1">Doanh thu, chi tiêu</option>
                            <option value="2">Lợi nhuận</option>
                        </select>
                        &nbsp;&nbsp;&nbsp;
                        <span class="text-dark">Tháng: </span><input id="monthOfRevenue" type="month"
                                                                     class="mt-2 mb-3"/>
                    </div>
                    <br>
                    <div class="ms-3 pb-4" style="color: black">
                        <span style="color: blue">- Ghi chú:</span>
                        <p id="noteOfChart"></p>
                    </div>

                    <div class="pe-2">
                        <div class="chart">
                            <canvas id="chart-line-revenueByMonth" class="chart-canvas" height="600"></canvas>
                        </div>

                        <div id="sumOfChart" class="text-dark pt-4">

                        </div>
                    </div>
                    <hr class="dark horizontal">
                    <div class="d-flex ">
                        <i class="material-symbols-rounded text-sm my-auto me-1">schedule</i>
                        <p class="mb-0 text-sm text-dark"> Vừa cập nhật </p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Order status quantity, Revenue by year (bar + line chart) -->
    <div class="row">
        <!-- Order status (pie chart) -->
        <div class="col-lg-4 col-md-6 mt-4 mb-4">
            <div class="card">
                <div class="card-body">
                    <h5 class="mb-0 pb-1">Đơn hàng</h5>

                    <div class="justify-content-xxl-end ms-2 mt-4 mb-3">
                        <label style="font-size: 16px; color: black">Hiển thị: </label>
                        <select id="orderStatusShowType">
                            <option value="1">Hôm nay</option>
                            <option value="2">Tháng này</option>
                            <option value="3">Năm nay</option>
                            <option value="4">Tất cả</option>
                        </select>
                    </div>

                    <div class="pe-2">
                        <div class="chart">
                            <canvas id="chart-pie-orderStatus" class="chart-canvas" height="350"></canvas>
                        </div>
                    </div>

                    <div class="mt-3">
                        <p id="highestOrderStatusQuantityNote" class="text-dark"></p>
                    </div>

                    <hr class="dark horizontal">
                    <div class="d-flex ">
                        <i class="material-symbols-rounded text-sm my-auto me-1">schedule</i>
                        <p class="mb-0 text-sm text-dark">Vừa cập nhật</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Revenue by year (bar + line chart) -->
        <div class="col-lg-8 col-md-6 mt-4 mb-4">
            <div class="card ">
                <div class="card-body">
                    <h5 class="mb-0 pb-1"> Số liệu của năm </h5>
                    <%--                    <p class="text-sm "> (<span class="font-weight-bolder">+15%</span>) increase in today sales. </p>--%>
                    <br>
                    <div class="justify-content-xxl-end ms-2">
                        <label class="text-dark" style="font-size: 16px;">Hiển thị: </label>
                        <select id="yearShowType" class="text-dark">
                            <option value="1">Doanh thu, chi tiêu</option>
                            <option value="2">Lợi nhuận</option>
                        </select>
                        &nbsp;&nbsp;&nbsp;
                        <span class="text-dark">Năm: <input type="number" id="yearPicker" class="mb-1"/></span>
                    </div>
                    <br>
                    <div class="ms-3 pb-4" style="color: black">
                        <span style="color: blue">- Ghi chú:</span>
                        <p id="noteOfChartYear"></p>
                    </div>

                    <div class="pe-2">
                        <div class="chart">
                            <canvas id="chart-line-revenueByYear" class="chart-canvas" height="400"></canvas>
                        </div>

                        <div id="sumOfChartYear" class="text-dark pt-4">

                        </div>
                    </div>
                    <hr class="dark horizontal">
                    <div class="d-flex ">
                        <i class="material-symbols-rounded text-sm my-auto me-1">schedule</i>
                        <p class="mb-0 text-sm text-dark"> Vừa cập nhật </p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Products with highest quantity sold -->
    <div class="row mb-4">
        <div class="col-lg-6 col-md-6 mb-md-0 mb-4">
            <div class="card">
                <div class="card-header pb-0">
                    <div class="row">
                        <div class="col-lg-6 col-7">
                            <h5>Các sản phẩm bán chạy nhất tháng</h5>
                        </div>
                    </div>
                </div>

                <div class="ms-4 mt-3 mb-3">
                    <label class="text-dark" style="font-size: 16px;">Hiển thị: </label>
                    <input id="monthOfHotProduct" type="month"/>
                </div>

                <div class="card-body px-0 pb-2">
                    <div class="table-container">
                        <table id="hotProductTable" class="table align-items-center ms-1 me-1 text-dark">
                            <thead>
                            <tr>
                                <th class="text-center font-weight-bolder" style="font-size: 16px;">
                                    Ảnh đại diện
                                </th>
                                <th class="text-center font-weight-bolder ps-2" style="font-size: 16px;">
                                    Tên sản phẩm
                                </th>
                                <th class="text-center font-weight-bolder" style="font-size: 16px;">
                                    Số lượng bán
                                </th>
                                <th class="text-center font-weight-bolder" style="font-size: 16px;">
                                    Tổng tiền bán
                                </th>
                            </tr>
                            </thead>

                            <tbody id="hotProductTable-body">

                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="ms-4 mt-2 mb-2">
                    <p id="noteOfHotProduct" class="text-dark"></p>
                </div>
            </div>
        </div>

        <div class="col-lg-6 col-md-6 mb-md-0 mb-4">
            <div class="card">
                <div class="card-header pb-0">
                    <div class="row">
                        <div class="col-lg-6 col-7">
                            <h5>Các sản phẩm bán chậm của tháng</h5>
                        </div>
                    </div>
                </div>

                <div class="ms-4 mt-3 mb-3">
                    <label class="text-dark" style="font-size: 16px;">Hiển thị: </label>
                    <input id="monthOfExcessProduct" type="month"/>
                </div>

                <div class="card-body px-0 pb-2">
                    <div class="table-container">
                        <table id="excessProductTable" class="table align-items-center ms-1 me-1 text-dark">
                            <thead>
                            <tr>
                                <th class="text-center font-weight-bolder" style="font-size: 16px;">
                                    Ảnh đại diện
                                </th>
                                <th class="text-center font-weight-bolder ps-2" style="font-size: 16px;">
                                    Tên sản phẩm
                                </th>
                                <th class="text-center font-weight-bolder" style="font-size: 16px;">
                                    Số lượng bán
                                </th>
                                <th class="text-center font-weight-bolder" style="font-size: 16px;">
                                    Tổng tiền bán
                                </th>
                            </tr>
                            </thead>

                            <tbody id="excessProductTable-body">

                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="ms-4 mt-2 mb-2">
                    <p id="noteOfExcessProduct" class="text-dark"></p>
                </div>
            </div>
        </div>
    </div>

</div>

<div class="fixed-plugin">
    <a class="fixed-plugin-button text-dark position-fixed px-3 py-2">
        <i class="material-symbols-rounded py-2">settings</i>
    </a>
    <div class="card shadow-lg">
        <div class="card-header pb-0 pt-3">
            <div class="float-start">
                <h5 class="mt-3 mb-0">Material UI Configurator</h5>
                <p>See our dashboard options.</p>
            </div>
            <div class="float-end mt-4">
                <button class="btn btn-link text-dark p-0 fixed-plugin-close-button">
                    <i class="material-symbols-rounded">clear</i>
                </button>
            </div>
            <!-- End Toggle Button -->
        </div>
        <hr class="horizontal dark my-1">
        <div class="card-body pt-sm-3 pt-0">
            <!-- Sidebar Backgrounds -->
            <div>
                <h6 class="mb-0">Sidebar Colors</h6>
            </div>
            <a href="javascript:void(0)" class="switch-trigger background-color">
                <div class="badge-colors my-2 text-start">
                    <span class="badge filter bg-gradient-primary" data-color="primary"
                          onclick="sidebarColor(this)"></span>
                    <span class="badge filter bg-gradient-dark active" data-color="dark"
                          onclick="sidebarColor(this)"></span>
                    <span class="badge filter bg-gradient-info" data-color="info" onclick="sidebarColor(this)"></span>
                    <span class="badge filter bg-gradient-success" data-color="success"
                          onclick="sidebarColor(this)"></span>
                    <span class="badge filter bg-gradient-warning" data-color="warning"
                          onclick="sidebarColor(this)"></span>
                    <span class="badge filter bg-gradient-danger" data-color="danger"
                          onclick="sidebarColor(this)"></span>
                </div>
            </a>
            <!-- Sidenav Type -->
            <div class="mt-3">
                <h6 class="mb-0">Sidenav Type</h6>
                <p class="text-sm">Choose between different sidenav types.</p>
            </div>
            <div class="d-flex">
                <button class="btn bg-gradient-dark px-3 mb-2" data-class="bg-gradient-dark"
                        onclick="sidebarType(this)">Dark
                </button>
                <button class="btn bg-gradient-dark px-3 mb-2 ms-2" data-class="bg-transparent"
                        onclick="sidebarType(this)">Transparent
                </button>
                <button class="btn bg-gradient-dark px-3 mb-2  active ms-2" data-class="bg-white"
                        onclick="sidebarType(this)">White
                </button>
            </div>
            <p class="text-sm d-xl-none d-block mt-2">You can change the sidenav type just on desktop view.</p>
            <!-- Navbar Fixed -->
            <div class="mt-3 d-flex">
                <h6 class="mb-0">Navbar Fixed</h6>
                <div class="form-check form-switch ps-0 ms-auto my-auto">
                    <input class="form-check-input mt-1 ms-auto" type="checkbox" id="navbarFixed"
                           onclick="navbarFixed(this)">
                </div>
            </div>
            <hr class="horizontal dark my-3">
            <div class="mt-2 d-flex">
                <h6 class="mb-0">Light / Dark</h6>
                <div class="form-check form-switch ps-0 ms-auto my-auto">
                    <input class="form-check-input mt-1 ms-auto" type="checkbox" id="dark-version"
                           onclick="darkMode(this)">
                </div>
            </div>
            <hr class="horizontal dark my-sm-4">
            <a class="btn bg-gradient-info w-100" href="https://www.creative-tim.com/product/material-dashboard-pro">Free
                Download</a>
            <a class="btn btn-outline-dark w-100"
               href="https://www.creative-tim.com/learning-lab/bootstrap/overview/material-dashboard">View
                documentation</a>
            <div class="w-100 text-center">
                <a class="github-button" href="https://github.com/creativetimofficial/material-dashboard"
                   data-icon="octicon-star" data-size="large" data-show-count="true"
                   aria-label="Star creativetimofficial/material-dashboard on GitHub">Star</a>
                <h6 class="mt-3">Thank you for sharing!</h6>
                <a href="https://twitter.com/intent/tweet?text=Check%20Material%20UI%20Dashboard%20made%20by%20%40CreativeTim%20%23webdesign%20%23dashboard%20%23bootstrap5&amp;url=https%3A%2F%2Fwww.creative-tim.com%2Fproduct%2Fsoft-ui-dashboard"
                   class="btn btn-dark mb-0 me-2" target="_blank">
                    <i class="fab fa-twitter me-1" aria-hidden="true"></i> Tweet
                </a>
                <a href="https://www.facebook.com/sharer/sharer.php?u=https://www.creative-tim.com/product/material-dashboard"
                   class="btn btn-dark mb-0 me-2" target="_blank">
                    <i class="fab fa-facebook-square me-1" aria-hidden="true"></i> Share
                </a>
            </div>
        </div>
    </div>
</div>

<script src="../admin/js/plugins/chartjs.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6/jquery.min.js" type="text/javascript"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type="text/javascript"></script>
<script>
    <c:set var="orderAPI" value="/api/admin/orders"/>
    <c:set var="statisticAPI" value="/api/admin/statistic"/>

    let fontSizeOfChart;
    let monthAndYearToday;

    $(document).ready(function () {
        // Set Charts's font-size base on screen's ratio
        if (window.innerWidth >= 999) {
            fontSizeOfChart = 18;
        } else if (window.innerWidth >= 666 && window.innerWidth < 999) {
            fontSizeOfChart = 15;
        } else {
            fontSizeOfChart = 12;
        }

        // Fill month and year today
        let today = new Date();
        let monthToday = today.getMonth() + 1; // getMonth(): get month of a date (0 - 11; 0-January, 1-February...)
        monthToday = (monthToday < 10) ? ("0" + monthToday) : monthToday;

        monthAndYearToday = today.getFullYear().toString() + "-" + monthToday;
        $('#monthOfRevenue').val(monthAndYearToday);
        $('#monthOfHotProduct').val(monthAndYearToday);
        $('#monthOfExcessProduct').val(monthAndYearToday);

        monthAndYearToday += "-" + today.getDate();

        getHotProduct(monthAndYearToday);
        getExcessProduct(monthAndYearToday);

        getOrderStatusQuantities();

        getMoneyStatisticByMonth(monthAndYearToday);
        $('#yearPicker').val((new Date()).getFullYear());
        getMoneyStatisticByYear(monthAndYearToday)
    });

    //-------------------- Order status quantities chart (Pie chart)
    $('#orderStatusShowType').change(function () {
        getOrderStatusQuantities();

        let option = parseInt(this.value);
        let highestOrderStatusQuantityNoteHTML = "";
        if (option === 2) {
            highestOrderStatusQuantityNoteHTML += "- Ngày có nhiều đơn hàng nhất trong tháng này: ${highestQuantityOfMonthAndYear.get(0).date} &nbsp;(${highestQuantityOfMonthAndYear.get(0).quantity} đơn hàng)<br>";
        } else if (option === 3) {
            highestOrderStatusQuantityNoteHTML += "- Tháng có nhiều đơn hàng nhất trong năm nay: Tháng ${highestQuantityOfMonthAndYear.get(1).date} &nbsp;(${highestQuantityOfMonthAndYear.get(1).quantity} đơn hàng)";
        }

        document.getElementById('highestOrderStatusQuantityNote').innerHTML = highestOrderStatusQuantityNoteHTML;
    });

    function getOrderStatusQuantities() {
        let orderStatus = [];
        let orderStatusQuantity = [];
        let orderStatusColor = [];

        let option = parseInt($('#orderStatusShowType').val());
        let monthAndYearTodaySplit = monthAndYearToday.split("-");
        let requestURL = "${orderAPI}" + "/statusQuantityByTime";

        if (option === 1) { // Today
            requestURL += "?date=" + monthAndYearToday;
        } else if (option === 2) { // This month
            requestURL += "?date=" + (monthAndYearTodaySplit[0] + "-" + monthAndYearTodaySplit[1]);
        } else if (option === 3) { // This year
            requestURL += "?date=" + (monthAndYearTodaySplit[0]);
        }

        $.ajax({
            url: requestURL,
            method: "GET",
            contentType: "application/json; charset=UTF-8",
            dataType: "JSON",
            success: function (result) {
                $.each(result.data, function (idx, it) {
                    orderStatus.push(it.name);
                    orderStatusQuantity.push(parseInt(it.quantity));

                    if (it.status === '${OrderStatusCode.IN_PROGRESS.toString()}') orderStatusColor.push('rgb(137, 137, 137)');
                    else if (it.status === '${OrderStatusCode.DELIVERING.toString()}') orderStatusColor.push('rgb(255, 205, 86)');
                    else if (it.status === '${OrderStatusCode.CANCELED.toString()}') orderStatusColor.push('rgb(255, 0, 0)');
                    else orderStatusColor.push('rgb(60, 179, 113)');
                });

                drawOrderStatusChart(orderStatus, orderStatusQuantity, orderStatusColor);
            },
            error: function (result) {
                let message = result.responseJSON.message;

                $.each(result.responseJSON.details, function (idx, it) {
                    message += it + '\n';
                });

                alert(message);
            }
        });
    }

    function drawOrderStatusChart(orderStatus, orderStatusQuantity, orderStatusColor) {
        try {
            let existing_chart = Chart.getChart('chart-pie-orderStatus');
            existing_chart.destroy();
        } catch {
            console.log("#chart-pie-orderStatus doesn't exist, can't destroy!");
        }

        let ctx = document.getElementById("chart-pie-orderStatus").getContext("2d");
        new Chart(ctx, {
            type: 'pie',
            data: {
                labels: orderStatus,
                datasets: [{
                    label: 'Số lượng', // get from database
                    data: orderStatusQuantity, // get from database
                    backgroundColor: orderStatusColor,
                    hoverOffset: 4
                }],
            },
            options: {
                responsive: true,
                maintainAspectRatio: false, // false: Allow change size of chart
                plugins: {
                    legend: {       // Name of elements in chart (Ex: red rectangle - revenue, blue rectangle - profit)
                        position: 'top',
                        labels: {
                            font: {
                                size: fontSizeOfChart,
                            },
                        },
                    },
                    tooltip: {
                        titleFont: {
                            size: fontSizeOfChart,
                        },
                        bodyFont: {
                            size: fontSizeOfChart,
                        },
                    }
                },
            },
        });
    }


    //-------------------- Revenue by month chart (Line chart)
    function getMoneyStatisticByMonth(monthAndYearToday) {
        let moneyStatisticDays = [];
        let revenueValues = [];
        let importTotalValues = [];

        let monthToCompare = {};
        monthToCompare["revenueComparing"] = 0;
        monthToCompare["importTotalComparing"] = 0;

        let highestRevenueArr = [];
        let highestImportTotalArr = [];
        let highestMoney = {};
        highestMoney["revenue"] = -1;
        highestMoney["importTotal"] = -1;

        $.ajax({
            url: "${orderAPI}" + "/totalByMonth?date=" + monthAndYearToday,
            method: "GET",
            contentType: "application/json; charset=UTF-8",
            dataType: "JSON",
            success: function (result) {
                let option = parseInt($('#monthShowType').val());

                if (option === 1) { // compare of income and import total
                    $.each(result.data, function (idx, it) {
                        if (it.date != null) {
                            moneyStatisticDays.push(it.date.toLocaleString());

                            let revenue = parseInt(it.revenue), importTotal = parseInt(it.importTotal);

                            if (highestMoney["revenue"] < revenue) {
                                highestMoney["revenue"] = revenue;
                            }
                            if (highestMoney["importTotal"] < importTotal) {
                                highestMoney["importTotal"] = importTotal;
                            }

                            revenueValues.push(revenue);
                            monthToCompare["revenueComparing"] += revenue;

                            importTotalValues.push(importTotal);
                            monthToCompare["importTotalComparing"] += importTotal;
                        }
                    });

                    $.each(result.data, function (idx, it) {
                        let revenue = parseInt(it.revenue), importTotal = parseInt(it.importTotal);

                        if (it.date != null) {
                            if(revenue === highestMoney["revenue"]){
                                highestRevenueArr.push({
                                   revenue: highestMoney["revenue"],
                                   date: it.date
                                });
                            }

                            if(importTotal === highestMoney["importTotal"]){
                                highestImportTotalArr.push({
                                    importTotal: highestMoney["importTotal"],
                                    date: it.date
                                });
                            }
                        }
                    });

                    monthToCompare["revenue"] = parseInt(result.data[result.data.length - 1].revenue);
                    monthToCompare["importTotal"] = parseInt(result.data[result.data.length - 1].importTotal);
                } else { // Profit
                    let tmpRevenue, tmpImportTotal;

                    $.each(result.data, function (idx, it) {
                        tmpRevenue = parseInt(it.revenue);
                        tmpImportTotal = parseInt(it.importTotal);
                        let profit = tmpRevenue - tmpImportTotal;

                        if (it.date != null) {
                            moneyStatisticDays.push(it.date.toLocaleString());

                            if (highestMoney["revenue"] < profit) {
                                highestMoney["revenue"] = profit;
                            }

                            revenueValues.push(profit);
                            monthToCompare["revenueComparing"] += profit;
                        }
                    });

                    $.each(result.data, function (idx, it) {
                        let revenue = parseInt(it.revenue);

                        if (it.date != null) {
                            if(revenue === highestMoney["revenue"]){
                                highestRevenueArr.push({
                                    revenue: highestMoney["revenue"],
                                    date: it.date
                                });
                            }
                        }
                    });

                    monthToCompare["revenue"] = parseInt(tmpRevenue - tmpImportTotal);
                }

                drawChartLine_MoneyStatisticByMonth(moneyStatisticDays, revenueValues, importTotalValues, monthToCompare, highestRevenueArr, highestImportTotalArr);
            },
            error: function (result) {
                let message = result.responseJSON.message;

                $.each(result.responseJSON.details, function (idx, it) {
                    message += it + '\n';
                });

                alert(message);
            }
        });
    }

    function drawChartLine_MoneyStatisticByMonth(moneyStatisticDays, revenueValues, importTotalValues, monthToCompareObject, highestRevenueArr, highestImportTotalArr) {
        // Destroy existing chart
        try {
            const existed_chart = Chart.getChart('chart-line-revenueByMonth');
            existed_chart.destroy();
        } catch {
            console.log("#chart-line-revenueByMonth doesn't exist");
        }

        // Prepare data
        let chart_line_revenueByMonth = document.getElementById("chart-line-revenueByMonth").getContext("2d");
        let option = parseInt($('#monthShowType').val());
        let statisticLabel, chartTitle, chartLegend, chartTooltipCallbacks;
        let chartDatasets;
        let noteOfChart, sumOfChartHTMLCode;

        if (option === 1) { // Compare income, importTotal
            chartDatasets = [
                {
                    label: "Chi tiêu",
                    tension: 0,
                    borderWidth: 2,
                    pointRadius: 4,
                    pointBackgroundColor: "#FFA500",
                    pointBorderColor: "transparent",
                    borderColor: "#FFA500",
                    backgroundColor: "transparent",
                    fill: true,
                    data: importTotalValues, // data from database
                    maxBarThickness: 6,
                },
                {
                    type: "bar",
                    label: "Doanh thu",
                    tension: 0.4,
                    borderWidth: 0,
                    borderRadius: 4,
                    borderSkipped: false,
                    backgroundColor: "#43A047",
                    data: revenueValues, // data from database
                    barThickness: 'flex',
                },
            ];

            chartLegend = {
                position: 'top',
                labels: {
                    font: {
                        size: fontSizeOfChart,
                    },
                }
            };

            chartTitle = {
                display: true
            };

            chartTooltipCallbacks = {
                label: function (context) {
                    let label = context.dataset.label || '';

                    if (label) {
                        label += ': ';
                    }

                    let yValue = context.parsed.y;

                    if (yValue !== null) {
                        label += yValue.toLocaleString() + " đ";
                    }

                    return label;
                },
                title: function (context) {
                    let titleSplit = context[0].label.split("/");
                    return titleSplit[0] + " tháng " + titleSplit[1];
                },
            }

            let sumOfImport = 0;
            $.each(importTotalValues, function (idx, it) {
                sumOfImport += it;
            });

            let sumOfRevenue = 0;
            $.each(revenueValues, function (idx, it) {
                sumOfRevenue += it;
            });

            noteOfChart = "&nbsp;&nbsp;Doanh thu = tiền bán hàng thu được<br> " +
                "&nbsp;&nbsp;Chi tiêu = tiền nhập hàng";


            let percentOfRevenue = (monthToCompareObject.revenue === 0) ? 0 : (100 - parseInt(Math.round(monthToCompareObject.revenueComparing / monthToCompareObject.revenue * 100)));
            let percentOfImportTotal = (monthToCompareObject.importTotal === 0) ? 0 : (100 - parseInt(Math.round(monthToCompareObject.importTotalComparing / monthToCompareObject.importTotal * 100)));
            let monthAndYearTodaySplit = monthAndYearToday.split("-");

            sumOfChartHTMLCode = "&nbsp;&nbsp;<strong>Tổng doanh thu: </strong>" + sumOfRevenue.toLocaleString() + " đ";
            if ($('#monthOfRevenue').val() !== monthAndYearTodaySplit[0] + "-" + monthAndYearTodaySplit[1]) { // Random month, compare with current mon
                if (percentOfRevenue > 0) {
                    sumOfChartHTMLCode += "&nbsp;(<span style='color: red'>giảm</span>&nbsp;" + percentOfRevenue + "% so với tháng hiện tại)";
                } else {
                    sumOfChartHTMLCode += "&nbsp;(<span style='color: green'>tăng</span>&nbsp;" + (-percentOfRevenue) + "% so với tháng hiện tại)";
                }
                sumOfChartHTMLCode += "<br>";
                sumOfChartHTMLCode += "&nbsp;&nbsp;<strong>Tổng chi tiêu: </strong>" + sumOfImport.toLocaleString() + " đ\n";

                if (percentOfImportTotal > 0) {
                    sumOfChartHTMLCode += "&nbsp;(<span style='color: green'>giảm</span>&nbsp;" + percentOfImportTotal + "% so với tháng hiện tại)";
                } else {
                    sumOfChartHTMLCode += "&nbsp;(<span style='color: red'>tăng</span>&nbsp;" + (-percentOfImportTotal) + "% so với tháng hiện tại)";
                }
            } else { // Current month, compare with previous month
                if (percentOfRevenue > 0) {
                    sumOfChartHTMLCode += "&nbsp;(<span style='color: red'>giảm</span>&nbsp;" + percentOfRevenue + "% so với tháng trước)";
                } else {
                    sumOfChartHTMLCode += "&nbsp;(<span style='color: green'>tăng</span>&nbsp;" + (-percentOfRevenue) + "% so với tháng trước)";
                }
                sumOfChartHTMLCode += "<br>";
                sumOfChartHTMLCode += "&nbsp;&nbsp;<strong>Tổng chi tiêu: </strong>" + sumOfImport.toLocaleString() + " đ\n";

                if (percentOfImportTotal > 0) {
                    sumOfChartHTMLCode += "&nbsp;(<span style='color: green'>giảm</span>&nbsp;" + percentOfImportTotal + "% so với tháng trước)";
                } else {
                    sumOfChartHTMLCode += "&nbsp;(<span style='color: red'>tăng</span>&nbsp;" + (-percentOfImportTotal) + "% so với tháng trước)";
                }
            }

            sumOfChartHTMLCode += "<br><br>&nbsp;&nbsp;Ngày có <strong>doanh thu</strong> cao nhất: &nbsp;";
            for(let i = 0 ; i < highestRevenueArr.length ; i++){
                sumOfChartHTMLCode += highestRevenueArr[i].date;

                if(i !== highestRevenueArr.length - 1){
                    sumOfChartHTMLCode += ", ";
                }
            }
            sumOfChartHTMLCode += "&nbsp; (" + (highestRevenueArr[0].revenue).toLocaleString() + " đ).<br>";

            sumOfChartHTMLCode += "&nbsp;&nbsp;Ngày có <strong>chi tiêu</strong> cao nhất: &nbsp;";
            for(let i = 0 ; i < highestImportTotalArr.length ; i++){
                sumOfChartHTMLCode += highestImportTotalArr[i].date;

                if(i !== highestImportTotalArr.length - 1){
                    sumOfChartHTMLCode += ", ";
                }
            }
            sumOfChartHTMLCode += "&nbsp; (" + (highestImportTotalArr[0].importTotal).toLocaleString() + " đ).<br>";
        }
        else {
            let sumOfMoney = 0;
            $.each(revenueValues, function (idx, it) {
                sumOfMoney += it;
            });

            statisticLabel = "Lợi nhuận";
            noteOfChart = "Lợi nhuận = tiền bán hàng thu được - tiền nhập hàng";

            if (sumOfMoney < 0) {
                sumOfChartHTMLCode = "&nbsp;&nbsp;<strong class='text-danger'>Thua lỗ: </strong>" + (-sumOfMoney).toLocaleString() + " đ\n";
            } else {
                sumOfChartHTMLCode = "&nbsp;&nbsp;<strong>Tổng lợi nhuận: </strong>" + sumOfMoney.toLocaleString() + " đ\n";
            }
            sumOfChartHTMLCode += "<br><br>&nbsp;&nbsp;Ngày có <strong>lợi nhuận</strong> cao nhất: &nbsp;";
            for(let i = 0 ; i < highestRevenueArr.length ; i++){
                sumOfChartHTMLCode += highestRevenueArr[i].date;

                if(i !== highestRevenueArr.length - 1){
                    sumOfChartHTMLCode += ", ";
                }
            }
            sumOfChartHTMLCode += "&nbsp; (" + (highestRevenueArr[0].revenue).toLocaleString() + " đ).<br>";

            chartDatasets = [{
                label: statisticLabel,
                tension: 0,
                borderWidth: 2,
                pointRadius: 4,
                pointBackgroundColor: "#43A047",
                pointBorderColor: "transparent",
                borderColor: "#43A047",
                backgroundColor: "transparent",
                fill: true,
                data: revenueValues, // data from database
                maxBarThickness: 6,
            }];
            chartLegend = {
                display: false
            };
            chartTitle = {
                display: false
            };
            chartTooltipCallbacks = {
                label: function (context) {
                    let label = context.dataset.label || '';

                    if (label) {
                        label += ': ';
                    }

                    let yValue = context.parsed.y;

                    if (yValue !== null) {
                        if (yValue < 0) {
                            label = "Thua lỗ: " + (-yValue).toLocaleString() + " đ";
                        } else {
                            label += yValue.toLocaleString() + " đ";
                        }
                    }

                    return label;
                },
                labelColor: function (context) {     // All the time data array is not empty so "context.parsed.y" cannot be null, don't have to check
                    if (context.parsed.y < 0) {
                        return {
                            backgroundColor: 'rgb(255, 0, 0)',
                            borderWidth: 0,
                            borderRadius: 4,
                        };
                    }

                    return {
                        backgroundColor: '#43A047',
                        borderWidth: 0,
                        borderRadius: 4,
                    };
                },
                title: function (context) {
                    let titleSplit = context[0].label.split("/");
                    return titleSplit[0] + " tháng " + titleSplit[1];
                },
            }
        }

        // Show notes near the bound of chart
        document.getElementById('noteOfChart').innerHTML = noteOfChart;
        document.getElementById('sumOfChart').innerHTML = sumOfChartHTMLCode;

        // Draw chart
        new Chart(chart_line_revenueByMonth, {
            type: "line",
            data: {
                labels: moneyStatisticDays,
                datasets: chartDatasets,
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: chartLegend,
                    tooltip: {       // Config tooltip's font-size, and text show (Ex: 1.000.000 đ, $3.00...)
                        titleFont: {
                            size: fontSizeOfChart
                        },
                        bodyFont: {
                            size: fontSizeOfChart
                        },
                        callbacks: chartTooltipCallbacks,
                    },
                    title: chartTitle,
                },
                interaction: {
                    intersect: false,
                    mode: 'index',
                },
                scales: {
                    y: {
                        grid: {
                            drawBorder: false,
                            display: true,
                            drawOnChartArea: true,
                            drawTicks: false,
                            borderDash: [4, 4],
                            color: '#e5e5e5',
                        },
                        ticks: {
                            display: true,
                            color: '#black',
                            padding: 10,
                            font: {
                                size: fontSizeOfChart,
                                lineHeight: 2
                            },
                            callback: function (value, index, ticks) {
                                return Chart.Ticks.formatters.numeric.apply(this, [value, index, ticks]) + " đ";
                            }
                        },
                    },
                    x: {
                        grid: {
                            drawBorder: false,
                            display: false,
                            drawOnChartArea: false,
                            drawTicks: false,
                            borderDash: [5, 5]
                        },
                        ticks: {
                            display: true,
                            color: 'black',
                            padding: 10,
                            font: {
                                size: fontSizeOfChart,
                                lineHeight: 2
                            },
                        }
                    },
                },
            },
        });
    }

    $('#monthOfRevenue').change(function () {
        getMoneyStatisticByMonth(this.value + "-" + (new Date()).getDate());
    });

    $('#monthShowType').change(function () {
        getMoneyStatisticByMonth($('#monthOfRevenue').val() + "-" + (new Date()).getDate());
    });


    //-------------------- Revenue by year chart (Line chart)
    // $(function() {
    //     $('#datepicker').datepicker({
    //         changeYear: true,
    //         showButtonPanel: true,
    //         dateFormat: 'yy',
    //         currentText: 'Năm hiện tại',
    //         closeText : "Chọn",
    //         onClose: function(dateText, inst) {
    //             var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
    //             $(this).datepicker('setDate', new Date(year, 1));
    //
    //             let splitMonAndYearToday = monthAndYearToday.split("-");
    //             getRevenueByYear(this.value + "-" + splitMonAndYearToday[1] + "-" + splitMonAndYearToday[2] );
    //         }
    //     });
    //     $(".date-picker-year").focus(function () {
    //         $(".ui-datepicker-month").hide();
    //     });
    // });

    $('#yearPicker').change(function () {
        let splitMonAndYearToday = monthAndYearToday.split("-");
        getMoneyStatisticByYear(this.value + "-" + splitMonAndYearToday[1] + "-" + splitMonAndYearToday[2]);
    })

    $('#yearShowType').change(function () {
        let splitMonAndYearToday = monthAndYearToday.split("-");
        getMoneyStatisticByYear($('#yearPicker').val() + "-" + splitMonAndYearToday[1] + "-" + splitMonAndYearToday[2]);
    });

    function getMoneyStatisticByYear(monthAndYearToday) {
        let moneyStatisticMonths = [];
        let revenueValues = [];
        let importTotalValues = [];

        let yearToCompare = {};
        yearToCompare["revenueComparing"] = 0;
        yearToCompare["importTotalComparing"] = 0;

        let highestRevenueArr = [];
        let highestImportTotalArr = [];
        let highestMoney = {};
        highestMoney["revenue"] = -1;
        highestMoney["importTotal"] = -1;

        $.ajax({
            url: "${orderAPI}" + "/totalByYear?date=" + monthAndYearToday,
            method: "GET",
            contentType: "application/json; charset=UTF-8",
            dataType: "JSON",
            success: function (result) {
                let option = parseInt($('#yearShowType').val());

                if (option === 1) { // compare of income and import total
                    $.each(result.data, function (idx, it) {
                        if (it.date != null) {
                            moneyStatisticMonths.push(it.date.toLocaleString());

                            let revenue = parseInt(it.revenue), importTotal = parseInt(it.importTotal);

                            if (highestMoney["revenue"] < revenue) {
                                highestMoney["revenue"] = revenue;
                            }
                            if (highestMoney["importTotal"] < importTotal) {
                                highestMoney["importTotal"] = importTotal;
                            }

                            revenueValues.push(revenue);
                            yearToCompare["revenueComparing"] += revenue;

                            importTotalValues.push(importTotal);
                            yearToCompare["importTotalComparing"] += importTotal;
                        }
                    });

                    $.each(result.data, function (idx, it) {
                        if (it.date != null) {
                            let revenue = parseInt(it.revenue), importTotal = parseInt(it.importTotal);

                            if(revenue === highestMoney["revenue"]){
                                highestRevenueArr.push({
                                   revenue: highestMoney["revenue"],
                                   date: it.date
                                });
                            }
                            if(importTotal === highestMoney["importTotal"]){
                                highestImportTotalArr.push({
                                    importTotal: highestMoney["importTotal"],
                                    date: it.date
                                });
                            }
                        }
                    });

                    yearToCompare["revenue"] = parseInt(result.data[result.data.length - 1].revenue);
                    yearToCompare["importTotal"] = parseInt(result.data[result.data.length - 1].importTotal);
                } else { // Profit
                    let tmpRevenue, tmpImportTotal;

                    $.each(result.data, function (idx, it) {
                        tmpRevenue = parseInt(it.revenue);
                        tmpImportTotal = parseInt(it.importTotal);
                        let profit = tmpRevenue - tmpImportTotal;

                        if (it.date != null) {
                            moneyStatisticMonths.push(it.date.toLocaleString());

                            if (highestMoney["revenue"] < profit) {
                                highestMoney["revenue"] = profit;
                                highestMoney["revenueDate"] = it.date;
                            }

                            revenueValues.push(profit);
                            yearToCompare["revenueComparing"] += profit;
                        }
                    });

                    yearToCompare["revenue"] = parseInt(tmpRevenue - tmpImportTotal);
                }

                drawChartLine_MoneyStatisticByYear(moneyStatisticMonths, revenueValues, importTotalValues, yearToCompare, highestRevenueArr, highestImportTotalArr);
            },
            error: function (result) {
                let message = result.responseJSON.message;

                $.each(result.responseJSON.details, function (idx, it) {
                    message += it + '\n';
                });

                alert(message);
            }
        });
    }

    function drawChartLine_MoneyStatisticByYear(moneyStatisticMonths, revenueValues, importTotalValues, yearToCompareObject, highestRevenueArr, highestImportTotalArr) {
        // Destroy existing chart
        try {
            const existed_chart = Chart.getChart('chart-line-revenueByYear');
            existed_chart.destroy();
        } catch {
            console.log("#chart-line-revenueByYear doesn't exist");
        }

        let chart_line_revenueByYear = document.getElementById('chart-line-revenueByYear').getContext("2d");
        let option = parseInt($('#yearShowType').val());
        let statisticLabel, chartTitle, chartLegend, chartTooltipCallbacks;
        let chartDatasets;
        let noteOfChart, sumOfChartHTMLCode;

        if (option === 1) { // Compare income, importTotal
            chartDatasets = [
                {
                    label: "Chi tiêu",
                    tension: 0,
                    borderWidth: 2,
                    pointRadius: 4,
                    pointBackgroundColor: "#FFA500",
                    pointBorderColor: "transparent",
                    borderColor: "#FFA500",
                    backgroundColor: "transparent",
                    fill: true,
                    data: importTotalValues, // data from database
                    maxBarThickness: 6,
                },
                {
                    type: "bar",
                    label: "Doanh thu",
                    tension: 0.4,
                    borderWidth: 0,
                    borderRadius: 4,
                    borderSkipped: false,
                    backgroundColor: "#43A047",
                    data: revenueValues, // data from database
                    barThickness: 'flex',
                },
            ];

            chartLegend = {
                position: 'top',
                labels: {
                    font: {
                        size: fontSizeOfChart,
                    },
                }
            };

            chartTitle = {
                display: true
            };

            chartTooltipCallbacks = {
                label: function (context) {
                    let label = context.dataset.label || '';

                    if (label) {
                        label += ': ';
                    }

                    let yValue = context.parsed.y;

                    if (yValue !== null) {
                        label += yValue.toLocaleString() + " đ";
                    }

                    return label;
                },
                title: function (context) {
                    return "Tháng " + context[0].label;
                }
            }

            let sumOfImport = 0;
            $.each(importTotalValues, function (idx, it) {
                sumOfImport += it;
            });

            let sumOfRevenue = 0;
            $.each(revenueValues, function (idx, it) {
                sumOfRevenue += it;
            });

            noteOfChart = "&nbsp;&nbsp;Doanh thu = tiền bán hàng thu được<br> " +
                "&nbsp;&nbsp;Chi tiêu = tiền nhập hàng";

            let percentOfRevenue = (yearToCompareObject.revenue === 0) ? 0 : (100 - parseInt(Math.round(yearToCompareObject.revenueComparing / yearToCompareObject.revenue * 100)));
            let percentOfImportTotal = (yearToCompareObject.importTotal === 0) ? 0 : (100 - parseInt(Math.round(yearToCompareObject.importTotalComparing / yearToCompareObject.importTotal * 100)));
            let monthAndYearTodaySplit = monthAndYearToday.split("-");

            sumOfChartHTMLCode = "&nbsp;&nbsp;<strong>Tổng doanh thu: </strong>" + sumOfRevenue.toLocaleString() + " đ";
            if ($('#yearPicker').val() !== monthAndYearTodaySplit[0]) { // Random month, compare with current mon
                if (percentOfRevenue > 0) {
                    sumOfChartHTMLCode += "&nbsp;(<span style='color: red'>giảm</span>&nbsp;" + percentOfRevenue + "% so với năm hiện tại)";
                } else {
                    sumOfChartHTMLCode += "&nbsp;(<span style='color: green'>tăng</span>&nbsp;" + (-percentOfRevenue) + "% so với năm hiện tại)";
                }
                sumOfChartHTMLCode += "<br>";
                sumOfChartHTMLCode += "&nbsp;&nbsp;<strong>Tổng chi tiêu: </strong>" + sumOfImport.toLocaleString() + " đ\n";

                if (percentOfImportTotal > 0) {
                    sumOfChartHTMLCode += "&nbsp;(<span style='color: green'>giảm</span>&nbsp;" + percentOfImportTotal + "% so với năm hiện tại)";
                } else {
                    sumOfChartHTMLCode += "&nbsp;(<span style='color: red'>tăng</span>&nbsp;" + (-percentOfImportTotal) + "% so với năm hiện tại)";
                }
            } else { // Current month, compare with previous month
                if (percentOfRevenue > 0) {
                    sumOfChartHTMLCode += "&nbsp;(<span style='color: red'>giảm</span>&nbsp;" + percentOfRevenue + "% so với năm trước)";
                } else {
                    sumOfChartHTMLCode += "&nbsp;(<span style='color: green'>tăng</span>&nbsp;" + (-percentOfRevenue) + "% so với năm trước)";
                }
                sumOfChartHTMLCode += "<br>";
                sumOfChartHTMLCode += "&nbsp;&nbsp;<strong>Tổng chi tiêu: </strong>" + sumOfImport.toLocaleString() + " đ\n";

                if (percentOfImportTotal > 0) {
                    sumOfChartHTMLCode += "&nbsp;(<span style='color: green'>giảm</span>&nbsp;" + percentOfImportTotal + "% so với năm trước)";
                } else {
                    sumOfChartHTMLCode += "&nbsp;(<span style='color: red'>tăng</span>&nbsp;" + (-percentOfImportTotal) + "% so với năm trước)";
                }
            }

            sumOfChartHTMLCode += "<br><br>&nbsp;&nbsp;Tháng có <strong>doanh thu</strong> cao nhất: &nbsp;";
            for(let i = 0 ; i < highestRevenueArr.length ; i++){
                sumOfChartHTMLCode += "tháng&nbsp;" + highestRevenueArr[i].date;

                if(i !== highestRevenueArr.length - 1){
                    sumOfChartHTMLCode += ", ";
                }
            }
            sumOfChartHTMLCode += "&nbsp; (" + (highestRevenueArr[0].revenue).toLocaleString() + " đ).<br>";

            sumOfChartHTMLCode += "&nbsp;&nbsp;Tháng có <strong>chi tiêu</strong> cao nhất: &nbsp;";
            for(let i = 0 ; i < highestImportTotalArr.length ; i++){
                sumOfChartHTMLCode += "tháng&nbsp;" + highestImportTotalArr[i].date;

                if(i !== highestImportTotalArr.length - 1){
                    sumOfChartHTMLCode += ", ";
                }
            }

            sumOfChartHTMLCode += "&nbsp; (" + (highestImportTotalArr[0].importTotal).toLocaleString() + " đ).<br>";
        }
        else { // Profit
            let sumOfMoney = 0;
            $.each(revenueValues, function (idx, it) {
                sumOfMoney += it;
            });

            statisticLabel = "Lợi nhuận";
            noteOfChart = "Lợi nhuận = tiền bán hàng thu được - tiền nhập hàng";

            if (sumOfMoney < 0) {
                sumOfChartHTMLCode = "&nbsp;&nbsp;<strong class='text-danger'>Thua lỗ: </strong>" + (-sumOfMoney).toLocaleString() + " đ\n";
            } else {
                sumOfChartHTMLCode = "&nbsp;&nbsp;<strong>Tổng lợi nhuận: </strong>" + sumOfMoney.toLocaleString() + " đ\n";
            }

            sumOfChartHTMLCode += "<br><br>&nbsp;&nbsp;Tháng có <strong>lợi nhuận</strong> cao nhất: &nbsp;";
            for(let i = 0 ; i < highestImportTotalArr.length ; i++){
                sumOfChartHTMLCode += "tháng&nbsp;" + highestImportTotalArr[i].date;

                if(i !== highestImportTotalArr.length - 1){
                    sumOfChartHTMLCode += ", ";
                }
            }
            sumOfChartHTMLCode += "&nbsp; (" + (highestRevenueArr[0].revenue).toLocaleString() + " đ).<br>";

            chartDatasets = [{
                label: statisticLabel,
                tension: 0,
                borderWidth: 2,
                pointRadius: 4,
                pointBackgroundColor: "#43A047",
                pointBorderColor: "transparent",
                borderColor: "#43A047",
                backgroundColor: "transparent",
                fill: true,
                data: revenueValues, // data from database
                maxBarThickness: 6,
            }];
            chartLegend = {
                display: false
            };
            chartTitle = {
                display: false
            };
            chartTooltipCallbacks = {
                label: function (context) {
                    let label = context.dataset.label || '';

                    if (label) {
                        label += ': ';
                    }

                    let yValue = context.parsed.y;

                    if (yValue !== null) {
                        if (yValue < 0) {
                            label = "Thua lỗ: " + (-yValue).toLocaleString() + " đ";
                        } else {
                            label += yValue.toLocaleString() + " đ";
                        }
                    }

                    return label;
                },
                labelColor: function (context) {     // All the time data array is not empty so "context.parsed.y" cannot be null, don't have to check
                    if (context.parsed.y < 0) {
                        return {
                            backgroundColor: 'rgb(255, 0, 0)',
                            borderWidth: 0,
                            borderRadius: 4,
                        };
                    }

                    return {
                        backgroundColor: '#43A047',
                        borderWidth: 0,
                        borderRadius: 4,
                    };
                },
                title: function (context) {
                    return "Tháng " + context[0].label;
                },
            }
        }

        // Show notes near the bound of chart
        document.getElementById('noteOfChartYear').innerHTML = noteOfChart;
        document.getElementById('sumOfChartYear').innerHTML = sumOfChartHTMLCode;


        // Draw new chart
        new Chart(chart_line_revenueByYear, {
            type: "line",
            data: {
                labels: moneyStatisticMonths, // data from database
                datasets: chartDatasets,
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: chartLegend,
                    tooltip: {       // Config tooltip's font-size, and text show (Ex: 1.000.000 đ, $3.00...)
                        titleFont: {
                            size: fontSizeOfChart
                        },
                        bodyFont: {
                            size: fontSizeOfChart
                        },
                        callbacks: chartTooltipCallbacks,
                    },
                    title: chartTitle,
                },
                interaction: {
                    intersect: false,
                    mode: 'index',
                },
                scales: {
                    y: {
                        grid: {
                            drawBorder: false,
                            display: true,
                            drawOnChartArea: true,
                            drawTicks: false,
                            borderDash: [5, 5],
                            color: '#e5e5e5'
                        },
                        ticks: {
                            suggestedMin: 0,
                            suggestedMax: 500,
                            beginAtZero: true,
                            padding: 10,
                            font: {
                                size: fontSizeOfChart,
                                lineHeight: 2
                            },
                            color: "black",
                            callback: function (value, index, ticks) {
                                return Chart.Ticks.formatters.numeric.apply(this, [value, index, ticks]) + " đ";
                            }
                        },
                    },
                    x: {
                        grid: {
                            drawBorder: false,
                            display: false,
                            drawOnChartArea: false,
                            drawTicks: false,
                            borderDash: [5, 5]
                        },
                        ticks: {
                            display: true,
                            color: 'black',
                            padding: 10,
                            font: {
                                size: fontSizeOfChart,
                                lineHeight: 2
                            },
                            callback: function (value) {
                                return "Tháng " + (value + 1);
                            }
                        }
                    },
                },
            },
        });
    }


    // Find product with the highest quantity sold
    $('#monthOfHotProduct').change(function(){
        getHotProduct(this.value);
    });

    function getHotProduct(monthAndYearPicked){
        let monthAndYearSplit = monthAndYearPicked.split("-");

        $.ajax({
           url: "${statisticAPI}" + "/hotProduct?month=" + (monthAndYearSplit[0] + "-" + monthAndYearSplit[1]),
            method: "GET",
            contentType: "application/json; charset=UTF-8",
            dataType: "JSON",
            success: function (result) {
                let row = "";

                $.each(result.data, function(idx, it) {
                    row += "<tr>\n";

                    // Image
                    if(it.image != null){
                        row += "<td class='align-middle'> <img src='/repository" + it.image + "' id='viewImage' width='40' height='40' style='margin-top: 5px; margin-bottom: 5px' alt='Không tìm thấy ảnh'></td>\n";
                    }
                    else {
                        row += "<td class='align-middle'><img src='/admin/image/default.png' id='viewImage' width='40' height='40' alt='Chưa có ảnh'/></td>\n";
                    }

                    // Name
                    row += "<td class='align-middle text-center text-dark' style='font-size: 16px;'>" + it.name + "</td>\n";

                    // Quantity sold
                    row += "<td class='align-middle text-center text-dark' style='font-size: 16px;'>" + it.quantitySold + "</td>\n";

                    // Revenue
                    row += "<td class='align-middle text-center text-dark' style='font-size: 16px;'>" + (it.revenue).toLocaleString() + " đ</td>\n";

                    row += "</tr>\n";
                });

                $('#hotProductTable-body').html(row);
                $('#noteOfHotProduct').html("- Có " + result.data.length + " sản phẩm.");
            },
            error: function (result) {
                let message = result.responseJSON.message;

                $.each(result.responseJSON.details, function (idx, it) {
                    message += it + '\n';
                });

                alert(message);
            }

        });
    }


    // Find product with the lowest quantity sold
    $('#monthOfExcessProduct').change(function(){
        getExcessProduct(this.value);
    });

    function getExcessProduct(monthAndYearPicked){
        let monthAndYearSplit = monthAndYearPicked.split("-");

        $.ajax({
            url: "${statisticAPI}" + "/excessProduct?month=" + (monthAndYearSplit[0] + "-" + monthAndYearSplit[1]),
            method: "GET",
            contentType: "application/json; charset=UTF-8",
            dataType: "JSON",
            success: function (result) {
                let row = "";

                $.each(result.data, function(idx, it) {
                    row += "<tr>\n";

                    // Image
                    if(it.image != null){
                        row += "<td class='align-middle'> <img src='/repository" + it.image + "' id='viewImage' width='40' height='40' style='margin-top: 5px; margin-bottom: 5px' alt='Không tìm thấy ảnh'></td>\n";
                    }
                    else {
                        row += "<td class='align-middle'><img src='/admin/image/default.png' id='viewImage' width='40' height='40' alt='Chưa có ảnh'/></td>\n";
                    }

                    // Name
                    row += "<td class='align-middle text-center text-dark' style='font-size: 16px;'>" + it.name + "</td>\n";

                    // Quantity sold
                    row += "<td class='align-middle text-center text-dark' style='font-size: 16px;'>" + it.quantitySold + "</td>\n";

                    // Revenue
                    row += "<td class='align-middle text-center text-dark' style='font-size: 16px;'>" + (it.revenue).toLocaleString() + " đ</td>\n";

                    row += "</tr>\n";
                });

                $('#excessProductTable-body').html(row);
                $('#noteOfExcessProduct').html("- Có " + result.data.length + " sản phẩm.");
            },
            error: function (result) {
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