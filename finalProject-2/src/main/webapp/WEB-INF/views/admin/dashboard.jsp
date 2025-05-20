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
                            <h4 class="mb-0">${importToday}</h4>
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
                    <div class="justify-content-xxl-end">
                        <label class="text-dark" style="font-size: 16px;">Hiển thị: </label>
                        <select id="monthShowType" class="text-dark">
                            <option value="1">Doanh thu</option>
                            <option value="2">Lợi nhuận</option>
                            <option value="3">Thu, chi</option>
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
                            <canvas id="chart-line-revenueByMonth" class="chart-canvas" height="350"></canvas>
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

                    <div class="mt-2 mb-3">
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
                    <div class="justify-content-xxl-end">
                        <label class="text-dark" style="font-size: 16px;">Hiển thị: </label>
                        <select id="yearShowType" class="text-dark">
                            <option value="1">Doanh thu</option>
                            <option value="2">Lợi nhuận</option>
                            <option value="3">Thu, chi</option>
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
                            <canvas id="chart-line-revenueByYear" class="chart-canvas" height="350"></canvas>
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

    <div class="row mb-4">
        <div class="col-lg-8 col-md-6 mb-md-0 mb-4">
            <div class="card">
                <div class="card-header pb-0">
                    <div class="row">
                        <div class="col-lg-6 col-7">
                            <h6>Projects</h6>
                            <p class="text-sm mb-0">
                                <i class="fa fa-check text-info" aria-hidden="true"></i>
                                <span class="font-weight-bold ms-1">30 done</span> this month
                            </p>
                        </div>
                        <div class="col-lg-6 col-5 my-auto text-end">
                            <div class="dropdown float-lg-end pe-4">
                                <a class="cursor-pointer" id="dropdownTable" data-bs-toggle="dropdown"
                                   aria-expanded="false">
                                    <i class="fa fa-ellipsis-v text-secondary"></i>
                                </a>
                                <ul class="dropdown-menu px-2 py-3 ms-sm-n4 ms-n5" aria-labelledby="dropdownTable">
                                    <li><a class="dropdown-item border-radius-md" href="javascript:;">Action</a></li>
                                    <li><a class="dropdown-item border-radius-md" href="javascript:;">Another action</a>
                                    </li>
                                    <li><a class="dropdown-item border-radius-md" href="javascript:;">Something else
                                        here</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-body px-0 pb-2">
                    <div class="table-responsive">
                        <table class="table align-items-center mb-0">
                            <thead>
                            <tr>
                                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                    Companies
                                </th>
                                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">
                                    Members
                                </th>
                                <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                    Budget
                                </th>
                                <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                    Completion
                                </th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>
                                    <div class="d-flex px-2 py-1">
                                        <div>
                                            <img src="../admin/img/small-logos/logo-xd.svg"
                                                 class="avatar avatar-sm me-3" alt="xd">
                                        </div>
                                        <div class="d-flex flex-column justify-content-center">
                                            <h6 class="mb-0 text-sm">Material XD Version</h6>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <div class="avatar-group mt-2">
                                        <a href="javascript:;" class="avatar avatar-xs rounded-circle"
                                           data-bs-toggle="tooltip" data-bs-placement="bottom" title="Ryan Tompson">
                                            <img src="../admin/img/team-1.jpg" alt="team1">
                                        </a>
                                        <a href="javascript:;" class="avatar avatar-xs rounded-circle"
                                           data-bs-toggle="tooltip" data-bs-placement="bottom" title="Romina Hadid">
                                            <img src="../admin/img/team-2.jpg" alt="team2">
                                        </a>
                                        <a href="javascript:;" class="avatar avatar-xs rounded-circle"
                                           data-bs-toggle="tooltip" data-bs-placement="bottom" title="Alexander Smith">
                                            <img src="../admin/img/team-3.jpg" alt="team3">
                                        </a>
                                        <a href="javascript:;" class="avatar avatar-xs rounded-circle"
                                           data-bs-toggle="tooltip" data-bs-placement="bottom" title="Jessica Doe">
                                            <img src="../admin/img/team-4.jpg" alt="team4">
                                        </a>
                                    </div>
                                </td>
                                <td class="align-middle text-center text-sm">
                                    <span class="text-xs font-weight-bold"> $14,000 </span>
                                </td>
                                <td class="align-middle">
                                    <div class="progress-wrapper w-75 mx-auto">
                                        <div class="progress-info">
                                            <div class="progress-percentage">
                                                <span class="text-xs font-weight-bold">60%</span>
                                            </div>
                                        </div>
                                        <div class="progress">
                                            <div class="progress-bar bg-gradient-info w-60" role="progressbar"
                                                 aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"></div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="d-flex px-2 py-1">
                                        <div>
                                            <img src="../admin/img/small-logos/logo-atlassian.svg"
                                                 class="avatar avatar-sm me-3" alt="atlassian">
                                        </div>
                                        <div class="d-flex flex-column justify-content-center">
                                            <h6 class="mb-0 text-sm">Add Progress Track</h6>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <div class="avatar-group mt-2">
                                        <a href="javascript:;" class="avatar avatar-xs rounded-circle"
                                           data-bs-toggle="tooltip" data-bs-placement="bottom" title="Romina Hadid">
                                            <img src="../admin/img/team-2.jpg" alt="team5">
                                        </a>
                                        <a href="javascript:;" class="avatar avatar-xs rounded-circle"
                                           data-bs-toggle="tooltip" data-bs-placement="bottom" title="Jessica Doe">
                                            <img src="../admin/img/team-4.jpg" alt="team6">
                                        </a>
                                    </div>
                                </td>
                                <td class="align-middle text-center text-sm">
                                    <span class="text-xs font-weight-bold"> $3,000 </span>
                                </td>
                                <td class="align-middle">
                                    <div class="progress-wrapper w-75 mx-auto">
                                        <div class="progress-info">
                                            <div class="progress-percentage">
                                                <span class="text-xs font-weight-bold">10%</span>
                                            </div>
                                        </div>
                                        <div class="progress">
                                            <div class="progress-bar bg-gradient-info w-10" role="progressbar"
                                                 aria-valuenow="10" aria-valuemin="0" aria-valuemax="100"></div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="d-flex px-2 py-1">
                                        <div>
                                            <img src="../admin/img/small-logos/logo-slack.svg"
                                                 class="avatar avatar-sm me-3" alt="team7">
                                        </div>
                                        <div class="d-flex flex-column justify-content-center">
                                            <h6 class="mb-0 text-sm">Fix Platform Errors</h6>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <div class="avatar-group mt-2">
                                        <a href="javascript:;" class="avatar avatar-xs rounded-circle"
                                           data-bs-toggle="tooltip" data-bs-placement="bottom" title="Romina Hadid">
                                            <img src="../admin/img/team-3.jpg" alt="team8">
                                        </a>
                                        <a href="javascript:;" class="avatar avatar-xs rounded-circle"
                                           data-bs-toggle="tooltip" data-bs-placement="bottom" title="Jessica Doe">
                                            <img src="../admin/img/team-1.jpg" alt="team9">
                                        </a>
                                    </div>
                                </td>
                                <td class="align-middle text-center text-sm">
                                    <span class="text-xs font-weight-bold"> Not set </span>
                                </td>
                                <td class="align-middle">
                                    <div class="progress-wrapper w-75 mx-auto">
                                        <div class="progress-info">
                                            <div class="progress-percentage">
                                                <span class="text-xs font-weight-bold">100%</span>
                                            </div>
                                        </div>
                                        <div class="progress">
                                            <div class="progress-bar bg-gradient-success w-100" role="progressbar"
                                                 aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="d-flex px-2 py-1">
                                        <div>
                                            <img src="../admin/img/small-logos/logo-spotify.svg"
                                                 class="avatar avatar-sm me-3" alt="spotify">
                                        </div>
                                        <div class="d-flex flex-column justify-content-center">
                                            <h6 class="mb-0 text-sm">Launch our Mobile App</h6>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <div class="avatar-group mt-2">
                                        <a href="javascript:;" class="avatar avatar-xs rounded-circle"
                                           data-bs-toggle="tooltip" data-bs-placement="bottom" title="Ryan Tompson">
                                            <img src="../admin/img/team-4.jpg" alt="user1">
                                        </a>
                                        <a href="javascript:;" class="avatar avatar-xs rounded-circle"
                                           data-bs-toggle="tooltip" data-bs-placement="bottom" title="Romina Hadid">
                                            <img src="../admin/img/team-3.jpg" alt="user2">
                                        </a>
                                        <a href="javascript:;" class="avatar avatar-xs rounded-circle"
                                           data-bs-toggle="tooltip" data-bs-placement="bottom" title="Alexander Smith">
                                            <img src="../admin/img/team-4.jpg" alt="user3">
                                        </a>
                                        <a href="javascript:;" class="avatar avatar-xs rounded-circle"
                                           data-bs-toggle="tooltip" data-bs-placement="bottom" title="Jessica Doe">
                                            <img src="../admin/img/team-1.jpg" alt="user4">
                                        </a>
                                    </div>
                                </td>
                                <td class="align-middle text-center text-sm">
                                    <span class="text-xs font-weight-bold"> $20,500 </span>
                                </td>
                                <td class="align-middle">
                                    <div class="progress-wrapper w-75 mx-auto">
                                        <div class="progress-info">
                                            <div class="progress-percentage">
                                                <span class="text-xs font-weight-bold">100%</span>
                                            </div>
                                        </div>
                                        <div class="progress">
                                            <div class="progress-bar bg-gradient-success w-100" role="progressbar"
                                                 aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="d-flex px-2 py-1">
                                        <div>
                                            <img src="../admin/img/small-logos/logo-jira.svg"
                                                 class="avatar avatar-sm me-3" alt="jira">
                                        </div>
                                        <div class="d-flex flex-column justify-content-center">
                                            <h6 class="mb-0 text-sm">Add the New Pricing Page</h6>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <div class="avatar-group mt-2">
                                        <a href="javascript:;" class="avatar avatar-xs rounded-circle"
                                           data-bs-toggle="tooltip" data-bs-placement="bottom" title="Ryan Tompson">
                                            <img src="../admin/img/team-4.jpg" alt="user5">
                                        </a>
                                    </div>
                                </td>
                                <td class="align-middle text-center text-sm">
                                    <span class="text-xs font-weight-bold"> $500 </span>
                                </td>
                                <td class="align-middle">
                                    <div class="progress-wrapper w-75 mx-auto">
                                        <div class="progress-info">
                                            <div class="progress-percentage">
                                                <span class="text-xs font-weight-bold">25%</span>
                                            </div>
                                        </div>
                                        <div class="progress">
                                            <div class="progress-bar bg-gradient-info w-25" role="progressbar"
                                                 aria-valuenow="25" aria-valuemin="0" aria-valuemax="25"></div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="d-flex px-2 py-1">
                                        <div>
                                            <img src="../admin/img/small-logos/logo-invision.svg"
                                                 class="avatar avatar-sm me-3" alt="invision">
                                        </div>
                                        <div class="d-flex flex-column justify-content-center">
                                            <h6 class="mb-0 text-sm">Redesign New Online Shop</h6>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <div class="avatar-group mt-2">
                                        <a href="javascript:;" class="avatar avatar-xs rounded-circle"
                                           data-bs-toggle="tooltip" data-bs-placement="bottom" title="Ryan Tompson">
                                            <img src="../admin/img/team-1.jpg" alt="user6">
                                        </a>
                                        <a href="javascript:;" class="avatar avatar-xs rounded-circle"
                                           data-bs-toggle="tooltip" data-bs-placement="bottom" title="Jessica Doe">
                                            <img src="../admin/img/team-4.jpg" alt="user7">
                                        </a>
                                    </div>
                                </td>
                                <td class="align-middle text-center text-sm">
                                    <span class="text-xs font-weight-bold"> $2,000 </span>
                                </td>
                                <td class="align-middle">
                                    <div class="progress-wrapper w-75 mx-auto">
                                        <div class="progress-info">
                                            <div class="progress-percentage">
                                                <span class="text-xs font-weight-bold">40%</span>
                                            </div>
                                        </div>
                                        <div class="progress">
                                            <div class="progress-bar bg-gradient-info w-40" role="progressbar"
                                                 aria-valuenow="40" aria-valuemin="0" aria-valuemax="40"></div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-4 col-md-6">
            <div class="card h-100">
                <div class="card-header pb-0">
                    <h6>Orders overview</h6>
                    <p class="text-sm">
                        <i class="fa fa-arrow-up text-success" aria-hidden="true"></i>
                        <span class="font-weight-bold">24%</span> this month
                    </p>
                </div>
                <div class="card-body p-3">
                    <div class="timeline timeline-one-side">
                        <div class="timeline-block mb-3">
                  <span class="timeline-step">
                    <i class="material-symbols-rounded text-success text-gradient">notifications</i>
                  </span>
                            <div class="timeline-content">
                                <h6 class="text-dark text-sm font-weight-bold mb-0">$2400, Design changes</h6>
                                <p class="text-secondary font-weight-bold text-xs mt-1 mb-0">22 DEC 7:20 PM</p>
                            </div>
                        </div>
                        <div class="timeline-block mb-3">
                  <span class="timeline-step">
                    <i class="material-symbols-rounded text-danger text-gradient">code</i>
                  </span>
                            <div class="timeline-content">
                                <h6 class="text-dark text-sm font-weight-bold mb-0">New order #1832412</h6>
                                <p class="text-secondary font-weight-bold text-xs mt-1 mb-0">21 DEC 11 PM</p>
                            </div>
                        </div>
                        <div class="timeline-block mb-3">
                  <span class="timeline-step">
                    <i class="material-symbols-rounded text-info text-gradient">shopping_cart</i>
                  </span>
                            <div class="timeline-content">
                                <h6 class="text-dark text-sm font-weight-bold mb-0">Server payments for April</h6>
                                <p class="text-secondary font-weight-bold text-xs mt-1 mb-0">21 DEC 9:34 PM</p>
                            </div>
                        </div>
                        <div class="timeline-block mb-3">
                  <span class="timeline-step">
                    <i class="material-symbols-rounded text-warning text-gradient">credit_card</i>
                  </span>
                            <div class="timeline-content">
                                <h6 class="text-dark text-sm font-weight-bold mb-0">New card added for order
                                    #4395133</h6>
                                <p class="text-secondary font-weight-bold text-xs mt-1 mb-0">20 DEC 2:20 AM</p>
                            </div>
                        </div>
                        <div class="timeline-block mb-3">
                  <span class="timeline-step">
                    <i class="material-symbols-rounded text-primary text-gradient">key</i>
                  </span>
                            <div class="timeline-content">
                                <h6 class="text-dark text-sm font-weight-bold mb-0">Unlock packages for development</h6>
                                <p class="text-secondary font-weight-bold text-xs mt-1 mb-0">18 DEC 4:54 AM</p>
                            </div>
                        </div>
                        <div class="timeline-block">
                  <span class="timeline-step">
                    <i class="material-symbols-rounded text-dark text-gradient">payments</i>
                  </span>
                            <div class="timeline-content">
                                <h6 class="text-dark text-sm font-weight-bold mb-0">New order #9583120</h6>
                                <p class="text-secondary font-weight-bold text-xs mt-1 mb-0">17 DEC</p>
                            </div>
                        </div>
                    </div>
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

        monthAndYearToday += "-" + today.getDate();


        getMoneyStatisticByMonth(monthAndYearToday);
        getOrderStatusQuantities();

        $('#yearPicker').val((new Date()).getFullYear());
        getRevenueByYear(monthAndYearToday)
    });

    //-------------------- Order status quantities chart (Pie chart)
    $('#orderStatusShowType').change(function(){
        getOrderStatusQuantities();
    });

    function getOrderStatusQuantities() {
        let orderStatus = [];
        let orderStatusQuantity = [];
        let orderStatusColor = [];

        let option = parseInt($('#orderStatusShowType').val());
        let monthAndYearTodaySplit = monthAndYearToday.split("-");
        let requestURL = "${orderAPI}" + "/statusQuantityByTime";

        if(option === 1){ // Today
            requestURL += "?date=" + monthAndYearToday;
        }
        else if(option === 2){ // This month
            requestURL += "?date=" + (monthAndYearTodaySplit[0] + "-" + monthAndYearTodaySplit[1]);
        }
        else if(option === 3){ // This year
            requestURL += "?date=" + (monthAndYearTodaySplit[0]);
        }

        $.ajax({
            url: requestURL,
            method: "GET",
            contentType: "application/json; charset=UTF-8",
            dataType: "JSON",
            success: function(result){
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
            error: function(result){
                let message = result.responseJSON.message;

                $.each(result.responseJSON.details, function (idx, it) {
                    message += it + '\n';
                });

                alert(message);
            }
        });
    }

    function drawOrderStatusChart(orderStatus, orderStatusQuantity, orderStatusColor) {
        try{
            let existing_chart = Chart.getChart('chart-pie-orderStatus');
            existing_chart.destroy();
        }
        catch{
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
                            font:{
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

        $.ajax({
            url: "${orderAPI}" + "/totalByMonth?date=" + monthAndYearToday,
            method: "GET",
            contentType: "application/json; charset=UTF-8",
            dataType: "JSON",
            success: function (result) {
                let option = parseInt($('#monthShowType').val());

                if (option === 1) { // Revenue
                    $.each(result.data, function (idx, it) {
                        moneyStatisticDays.push(it.date.toLocaleString());
                        revenueValues.push(it.revenue);
                    });
                } else if (option === 2) { // Profit
                    $.each(result.data, function (idx, it) {
                        moneyStatisticDays.push(it.date.toLocaleString());
                        revenueValues.push(it.revenue - it.importTotal);
                    });
                } else { // compare of income and import total
                    $.each(result.data, function (idx, it) {
                        moneyStatisticDays.push(it.date.toLocaleString());
                        revenueValues.push(it.revenue);
                        importTotalValues.push(it.importTotal);
                    });
                }

                drawChartLine_MoneyStatisticByMonth(moneyStatisticDays, revenueValues, importTotalValues);
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

    function drawChartLine_MoneyStatisticByMonth(moneyStatisticDays, revenueValues, importTotalValues) {
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
        let noteOfChart, htmlCode;

        if (option === 3) {
            chartDatasets = [
                {
                    type: "bar",
                    label: "Thu",
                    tension: 0.4,
                    borderWidth: 0,
                    borderRadius: 4,
                    borderSkipped: false,
                    backgroundColor: "#43A047",
                    data: revenueValues, // data from database
                    barThickness: 'flex',
                },
                {
                    label: "Chi",
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
                        if (yValue < 0) {
                            label = "Thua lỗ: " + (-yValue).toLocaleString() + " đ";
                        } else {
                            label += yValue.toLocaleString() + " đ";
                        }
                    }

                    return label;
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

            noteOfChart = "&nbsp;&nbsp;Thu = tiền bán hàng thu được<br> " +
                "&nbsp;&nbsp;Chi = tiền nhập hàng";
            htmlCode = "&nbsp;&nbsp;<strong>Tổng thu: </strong>" + sumOfRevenue.toLocaleString() + " đ<br>" +
                "&nbsp;&nbsp;<strong>Tổng chi: </strong>" + sumOfImport.toLocaleString() + " đ\n";

            document.getElementById('sumOfChart').innerHTML = htmlCode;
        }
        else {
            let sumOfMoney = 0;
            $.each(revenueValues, function (idx, it) {
                sumOfMoney += it;
            });

            if (option === 1) {
                statisticLabel = "Doanh thu";
                noteOfChart = "Doanh thu = tiền bán hàng thu được";
                htmlCode = "&nbsp;&nbsp;<strong>Tổng doanh thu: </strong>" + sumOfMoney.toLocaleString() + " đ\n";
            } else {
                statisticLabel = "Lợi nhuận";
                noteOfChart = "Lợi nhuận = tiền bán hàng thu được - tiền nhập hàng";
                if (sumOfMoney < 0) {
                    htmlCode = "&nbsp;&nbsp;<strong class='text-danger'>Thua lỗ: </strong>" + (-sumOfMoney).toLocaleString() + " đ\n";
                } else {
                    htmlCode = "&nbsp;&nbsp;<strong>Tổng lợi nhuận: </strong>" + sumOfMoney.toLocaleString() + " đ\n";
                }
            }

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
                labelColor: function(context) {     // All the time data array is not empty so "context.parsed.y" cannot be null, don't have to check
                    if(context.parsed.y < 0){
                        return {
                            backgroundColor: 'rgb(255, 0, 0)',
                            borderWidth: 0,
                            borderRadius: 4,
                        };
                    }

                    return{
                        backgroundColor: '#43A047',
                        borderWidth: 0,
                        borderRadius: 4,
                    };
                },
            }
        }

        // Show notes near the bound of chart
        document.getElementById('noteOfChart').innerHTML = noteOfChart;
        document.getElementById('sumOfChart').innerHTML = htmlCode;


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
        getRevenueByYear(this.value + "-" + splitMonAndYearToday[1] + "-" + splitMonAndYearToday[2]);
    })

    $('#yearShowType').change(function () {
        let splitMonAndYearToday = monthAndYearToday.split("-");
        getRevenueByYear($('#yearPicker').val() + "-" + splitMonAndYearToday[1] + "-" + splitMonAndYearToday[2]);
    });

    function getRevenueByYear(monthAndYearToday) {
        let moneyStatisticMonths = [];
        let revenueValues = [];
        let importTotalValues = [];

        $.ajax({
            url: "${orderAPI}" + "/totalByYear?date=" + monthAndYearToday,
            method: "GET",
            contentType: "application/json; charset=UTF-8",
            dataType: "JSON",
            success: function (result) {
                let option = parseInt($('#yearShowType').val());

                if (option === 1) { // Revenue
                    $.each(result.data, function (idx, it) {
                        moneyStatisticMonths.push(it.date.toLocaleString());
                        revenueValues.push(it.revenue);
                    });
                } else if (option === 2) { // Profit
                    $.each(result.data, function (idx, it) {
                        moneyStatisticMonths.push(it.date.toLocaleString());
                        revenueValues.push(it.revenue - it.importTotal);
                    });
                } else { // compare of income and import total
                    $.each(result.data, function (idx, it) {
                        moneyStatisticMonths.push(it.date.toLocaleString());
                        revenueValues.push(it.revenue);
                        importTotalValues.push(it.importTotal);
                    });
                }

                drawChartLine_MoneyStatisticByYear(moneyStatisticMonths, revenueValues, importTotalValues);
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

    function drawChartLine_MoneyStatisticByYear(moneyStatisticMonths, revenueValues, importTotalValues) {
        // Destroy existing chart
        try {
            const existed_chart = Chart.getChart('chart-line-revenueByYear');
            existed_chart.destroy();
        } catch {
            console.log("#chart-line-revenueByYear doesn't exist");
        }

        // Prepare data
        let chart_line_revenueByYear = document.getElementById("chart-line-revenueByYear").getContext("2d");
        let option = parseInt($('#yearShowType').val());
        let statisticLabel, chartTitle, chartLegend, chartTooltipCallbacks;
        let chartDatasets;
        let noteOfChart, htmlCode;

        if (option === 3) {
            chartDatasets = [
                {
                    label: "Thu",
                    tension: 0.4,
                    borderWidth: 0,
                    borderRadius: 4,
                    borderSkipped: false,
                    backgroundColor: "#43A047",
                    data: revenueValues, // data from database
                    barThickness: 'flex',
                },
                {
                    type: "line",
                    label: "Chi",
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
                title: function (context) {
                    return "Tháng " + (context[0].dataIndex + 1);
                },
                label: function (context) {
                    let label = context.dataset.label || '';

                    if (label !== null) {
                        label += ": ";
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
                labelColor: function(context) {
                    if(context.parsed.y < 0){
                        return {
                            backgroundColor: 'rgb(255, 0, 0)',
                            borderWidth: 0,
                            borderRadius: 4,
                        };
                    }

                    return{
                        backgroundColor: '#43A047',
                        borderWidth: 0,
                        borderRadius: 4,
                    };
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

            noteOfChart = "&nbsp;&nbsp;Thu = tiền bán hàng thu được<br> " +
                "&nbsp;&nbsp;Chi = tiền nhập hàng";
            htmlCode = "&nbsp;&nbsp;<strong>Tổng thu: </strong>" + sumOfRevenue.toLocaleString() + " đ<br>" +
                "&nbsp;&nbsp;<strong>Tổng chi: </strong>" + sumOfImport.toLocaleString() + " đ\n";

            document.getElementById('sumOfChart').innerHTML = htmlCode;
        }
        else {
            let sumOfMoney = 0;
            $.each(revenueValues, function (idx, it) {
                sumOfMoney += it;
            });

            if (option === 1) {
                statisticLabel = "Doanh thu";
                noteOfChart = "Doanh thu = tiền bán hàng thu được";
                htmlCode = "&nbsp;&nbsp;<strong>Tổng doanh thu: </strong>" + sumOfMoney.toLocaleString() + " đ\n";
            } else {
                statisticLabel = "Lợi nhuận";
                noteOfChart = "Lợi nhuận = tiền bán hàng thu được - tiền nhập hàng";
                if (sumOfMoney < 0) {
                    htmlCode = "&nbsp;&nbsp;<strong class='text-danger'>Thua lỗ: </strong>" + (-sumOfMoney).toLocaleString() + " đ\n";
                } else {
                    htmlCode = "&nbsp;&nbsp;<strong>Tổng lợi nhuận: </strong>" + sumOfMoney.toLocaleString() + " đ\n";
                }
            }

            chartDatasets = [{
                label: statisticLabel,
                tension: 0.4,
                borderWidth: 0,
                borderRadius: 4,
                borderSkipped: false,
                backgroundColor: "#43A047",
                data: revenueValues,
                barThickness: 'flex',
            }];

            chartLegend = {
                display: false
            };

            chartTitle = {
                display: false
            };

            chartTooltipCallbacks = {
                title: function (context) {
                    return "Tháng " + (context[0].dataIndex + 1);
                },
                label: function (context) {
                    let label = context.dataset.label || '';

                    if (label !== null) {
                        label += ": ";
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
            }
        }

        // Show notes near the bound of chart
        document.getElementById('noteOfChartYear').innerHTML = noteOfChart;
        document.getElementById('sumOfChartYear').innerHTML = htmlCode;


        // Draw new chart
        new Chart(chart_line_revenueByYear, {
            type: "bar",
            data: {
                labels: moneyStatisticMonths, // data from database
                datasets: chartDatasets,
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: chartLegend,
                    tooltip: {       // Config tooltip's font-size
                        titleFont: {
                            size: fontSizeOfChart
                        },
                        bodyFont: {
                            size: fontSizeOfChart
                        },
                        callbacks: chartTooltipCallbacks,
                        title: chartTitle
                    },
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

</script>
</body>

</html>