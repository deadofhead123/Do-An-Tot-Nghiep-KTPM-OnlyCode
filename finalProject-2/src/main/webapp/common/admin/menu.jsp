<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 3/1/2025
  Time: 7:28 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.javaweb.security.utils.SecurityUtils" %>
<%@include file="/common/taglib.jsp" %>
<aside class="sidenav navbar navbar-vertical navbar-expand-xs border-radius-lg fixed-start ms-2  bg-white my-2"
       id="sidenav-main">
    <div class="sidenav-header">
        <%--        <i class="fas fa-times p-3 cursor-pointer text-dark opacity-5 position-absolute end-0 top-0 d-none d-xl-none" aria-hidden="true" id="iconSidenav"></i>--%>
        <a class="navbar-brand px-6 py-3 m-0" href="/home">
            <span class="ms-2 text-sm text-dark text-bold">VEGEFOOD</span>
        </a>
    </div>
    <hr class="horizontal dark mt-0 mb-2">
    <div class="collapse navbar-collapse w-auto" id="sidenav-collapse-main">
        <ul class="navbar-nav">
            <!-- Check if this button is clicked -->
            <c:set var="currentURL" value="${pageContext.request.requestURL}"/>
            <c:set var="roleName" value="<%=SecurityUtils.getAuthorities().get(0)%>"/>

            <!-- Dashboard -->
            <li class="nav-item">
                <c:if test="${fn:contains(currentURL, '/admin/dashboard')}">

                    <a class="nav-link active bg-gradient-success text-white" href="/admin/dashboard">
                        <img width="20" height="20" src="https://img.icons8.com/ios/50/laptop-metrics--v1.png"
                             alt="laptop-metrics--v1"/>
                        <span class="nav-link-text ms-1" style="font-size: 14px;">Thống kê</span>
                    </a>
                </c:if>

                <c:if test="${!fn:contains(currentURL, '/admin/dashboard')}">
                    <a class="nav-link text-dark" href="/admin/dashboard">
                        <img width="20" height="20" src="https://img.icons8.com/ios/50/laptop-metrics--v1.png"
                             alt="laptop-metrics--v1"/>
                        <span class="nav-link-text ms-1" style="font-size: 14px;">Thống kê</span>
                    </a>
                </c:if>
            </li>


            <!-- User -->
            <li class="nav-item">
                <c:if test="${fn:contains(currentURL, '/admin/user')}">
                    <a class="nav-link text-dark bg-gradient-success text-white" href="/admin/user-list">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor"
                             class="bi bi-people" viewBox="0 0 16 16">
                            <path d="M15 14s1 0 1-1-1-4-5-4-5 3-5 4 1 1 1 1zm-7.978-1L7 12.996c.001-.264.167-1.03.76-1.72C8.312 10.629 9.282 10 11 10c1.717 0 2.687.63 3.24 1.276.593.69.758 1.457.76 1.72l-.008.002-.014.002zM11 7a2 2 0 1 0 0-4 2 2 0 0 0 0 4m3-2a3 3 0 1 1-6 0 3 3 0 0 1 6 0M6.936 9.28a6 6 0 0 0-1.23-.247A7 7 0 0 0 5 9c-4 0-5 3-5 4q0 1 1 1h4.216A2.24 2.24 0 0 1 5 13c0-1.01.377-2.042 1.09-2.904.243-.294.526-.569.846-.816M4.92 10A5.5 5.5 0 0 0 4 13H1c0-.26.164-1.03.76-1.724.545-.636 1.492-1.256 3.16-1.275ZM1.5 5.5a3 3 0 1 1 6 0 3 3 0 0 1-6 0m3-2a2 2 0 1 0 0 4 2 2 0 0 0 0-4"/>
                        </svg>
                        <span class="nav-link-text ms-1" style="font-size: 14px;">Người dùng</span>
                    </a>
                </c:if>

                <c:if test="${!fn:contains(currentURL, '/admin/user')}">
                    <a class="nav-link text-dark" href="/admin/user-list">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor"
                             class="bi bi-people" viewBox="0 0 16 16">
                            <path d="M15 14s1 0 1-1-1-4-5-4-5 3-5 4 1 1 1 1zm-7.978-1L7 12.996c.001-.264.167-1.03.76-1.72C8.312 10.629 9.282 10 11 10c1.717 0 2.687.63 3.24 1.276.593.69.758 1.457.76 1.72l-.008.002-.014.002zM11 7a2 2 0 1 0 0-4 2 2 0 0 0 0 4m3-2a3 3 0 1 1-6 0 3 3 0 0 1 6 0M6.936 9.28a6 6 0 0 0-1.23-.247A7 7 0 0 0 5 9c-4 0-5 3-5 4q0 1 1 1h4.216A2.24 2.24 0 0 1 5 13c0-1.01.377-2.042 1.09-2.904.243-.294.526-.569.846-.816M4.92 10A5.5 5.5 0 0 0 4 13H1c0-.26.164-1.03.76-1.724.545-.636 1.492-1.256 3.16-1.275ZM1.5 5.5a3 3 0 1 1 6 0 3 3 0 0 1-6 0m3-2a2 2 0 1 0 0 4 2 2 0 0 0 0-4"/>
                        </svg>
                        <span class="nav-link-text ms-1" style="font-size: 14px;">Người dùng</span>
                    </a>
                </c:if>
            </li>


            <!-- Contact -->
            <li class="nav-item">
                <c:if test="${fn:contains(currentURL, '/admin/contact')}">
                    <a class="nav-link text-dark bg-gradient-success text-white" href="/admin/contact-list">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor"
                             class="bi bi-telephone" viewBox="0 0 16 16">
                            <path d="M3.654 1.328a.678.678 0 0 0-1.015-.063L1.605 2.3c-.483.484-.661 1.169-.45 1.77a17.6 17.6 0 0 0 4.168 6.608 17.6 17.6 0 0 0 6.608 4.168c.601.211 1.286.033 1.77-.45l1.034-1.034a.678.678 0 0 0-.063-1.015l-2.307-1.794a.68.68 0 0 0-.58-.122l-2.19.547a1.75 1.75 0 0 1-1.657-.459L5.482 8.062a1.75 1.75 0 0 1-.46-1.657l.548-2.19a.68.68 0 0 0-.122-.58zM1.884.511a1.745 1.745 0 0 1 2.612.163L6.29 2.98c.329.423.445.974.315 1.494l-.547 2.19a.68.68 0 0 0 .178.643l2.457 2.457a.68.68 0 0 0 .644.178l2.189-.547a1.75 1.75 0 0 1 1.494.315l2.306 1.794c.829.645.905 1.87.163 2.611l-1.034 1.034c-.74.74-1.846 1.065-2.877.702a18.6 18.6 0 0 1-7.01-4.42 18.6 18.6 0 0 1-4.42-7.009c-.362-1.03-.037-2.137.703-2.877z"/>
                        </svg>
                        <span class="nav-link-text ms-1" style="font-size: 14px;">Liên hệ</span>
                    </a>

                </c:if>

                <c:if test="${!fn:contains(currentURL, '/admin/contact')}">
                    <a class="nav-link text-dark" href="/admin/contact-list">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor"
                             class="bi bi-telephone" viewBox="0 0 16 16">
                            <path d="M3.654 1.328a.678.678 0 0 0-1.015-.063L1.605 2.3c-.483.484-.661 1.169-.45 1.77a17.6 17.6 0 0 0 4.168 6.608 17.6 17.6 0 0 0 6.608 4.168c.601.211 1.286.033 1.77-.45l1.034-1.034a.678.678 0 0 0-.063-1.015l-2.307-1.794a.68.68 0 0 0-.58-.122l-2.19.547a1.75 1.75 0 0 1-1.657-.459L5.482 8.062a1.75 1.75 0 0 1-.46-1.657l.548-2.19a.68.68 0 0 0-.122-.58zM1.884.511a1.745 1.745 0 0 1 2.612.163L6.29 2.98c.329.423.445.974.315 1.494l-.547 2.19a.68.68 0 0 0 .178.643l2.457 2.457a.68.68 0 0 0 .644.178l2.189-.547a1.75 1.75 0 0 1 1.494.315l2.306 1.794c.829.645.905 1.87.163 2.611l-1.034 1.034c-.74.74-1.846 1.065-2.877.702a18.6 18.6 0 0 1-7.01-4.42 18.6 18.6 0 0 1-4.42-7.009c-.362-1.03-.037-2.137.703-2.877z"/>
                        </svg>
                        <span class="nav-link-text ms-1" style="font-size: 14px;">Liên hệ</span>
                    </a>
                </c:if>
            </li>


            <!-- Categories -->
            <c:if test="${fn:contains(currentURL, '/admin/category')}">
                <li class="nav-item dropdown">
                    <a class="nav-link bg-gradient-success text-white" href="#" id="dropdownMenu2"
                       data-bs-toggle="dropdown"
                       aria-expanded="true">
                        <img width="20" height="20" src="https://img.icons8.com/wired/64/categorize.png"
                             alt="categorize"/>
                        <span class="nav-link-text ms-1" style="font-size: 14px;">Danh mục sản phẩm</span>
                    </a>

                    <ul class="dropdown px-2 py-3 me-sm-n4" aria-labelledby="dropdownMenu2">
                        <li class="mb-2">
                            <!-- Insert category -->
                            <c:if test="${fn:contains(currentURL, '/admin/category-edit')}">
                                <a class="nav-link text-white bg-gradient-success" href="/admin/category-edit">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-plus-lg" viewBox="0 0 16 16">
                                      <path fill-rule="evenodd" d="M8 2a.5.5 0 0 1 .5.5v5h5a.5.5 0 0 1 0 1h-5v5a.5.5 0 0 1-1 0v-5h-5a.5.5 0 0 1 0-1h5v-5A.5.5 0 0 1 8 2"/>
                                    </svg>
                                    <span class="nav-link-text ms-1" style="font-size: 14px;">Thêm danh mục</span>
                                </a>
                            </c:if>

                            <c:if test="${!fn:contains(currentURL, '/admin/category-edit')}">
                                <a class="nav-link text-dark" href="/admin/category-edit">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-plus-lg" viewBox="0 0 16 16">
                                      <path fill-rule="evenodd" d="M8 2a.5.5 0 0 1 .5.5v5h5a.5.5 0 0 1 0 1h-5v5a.5.5 0 0 1-1 0v-5h-5a.5.5 0 0 1 0-1h5v-5A.5.5 0 0 1 8 2"/>
                                    </svg>
                                    <span class="nav-link-text ms-1" style="font-size: 14px;">Thêm danh mục</span>
                                </a>
                            </c:if>

                            <!-- Parent category -->
                            <c:if test="${fn:contains(currentURL, '/admin/category-parent-list')}">
                                <a class="nav-link text-white bg-gradient-success" href="/admin/category-parent-list">
                                    <img width="20" height="20" src="https://img.icons8.com/wired/64/categorize.png"
                                         alt="categorize"/>
                                    <span class="nav-link-text ms-1" style="font-size: 14px;">Danh mục cha</span>
                                </a>
                            </c:if>

                            <c:if test="${!fn:contains(currentURL, '/admin/category-parent-list')}">
                                <a class="nav-link text-dark" href="/admin/category-parent-list">
                                    <img width="20" height="20" src="https://img.icons8.com/wired/64/categorize.png"
                                         alt="categorize"/>
                                    <span class="nav-link-text ms-1" style="font-size: 14px;">Danh mục cha</span>
                                </a>
                            </c:if>

                            <!-- Child category -->
                            <c:if test="${fn:contains(currentURL, '/admin/category-child-list')}">
                                <a class="nav-link text-white bg-gradient-success" href="/admin/category-child-list">
                                    <img width="16" height="16" src="https://img.icons8.com/wired/64/categorize.png"
                                         alt="categorize"/>
                                    <span class="nav-link-text ms-1" style="font-size: 14px;">Danh mục con</span>
                                </a>
                            </c:if>

                            <c:if test="${!fn:contains(currentURL, '/admin/category-child-list')}">
                                <a class="nav-link text-dark" href="/admin/category-child-list">
                                    <img width="16" height="16" src="https://img.icons8.com/wired/64/categorize.png"
                                         alt="categorize"/>
                                    <span class="nav-link-text ms-1" style="font-size: 14px;">Danh mục con</span>
                                </a>
                            </c:if>
                        </li>
                    </ul>
                </li>
            </c:if>

            <c:if test="${!fn:contains(currentURL, '/admin/category')}">
                <li class="nav-item dropdown">
                    <a class="nav-link text-dark" href="#" id="dropdownMenu2" data-bs-toggle="dropdown"
                       aria-expanded="true">
                        <img width="20" height="20" src="https://img.icons8.com/wired/64/categorize.png"
                             alt="categorize"/>
                        <span class="nav-link-text ms-1" style="font-size: 14px;">Danh mục sản phẩm</span>
                    </a>

                    <ul class="dropdown-menu dropdown-menu-animation px-2 py-3 me-sm-n4"
                        aria-labelledby="dropdownMenu2">
                        <li class="mb-2">
                            <!-- Insert category -->
                            <a class="nav-link text-dark" href="/admin/category-edit">
                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-plus-lg" viewBox="0 0 16 16">
                                      <path fill-rule="evenodd" d="M8 2a.5.5 0 0 1 .5.5v5h5a.5.5 0 0 1 0 1h-5v5a.5.5 0 0 1-1 0v-5h-5a.5.5 0 0 1 0-1h5v-5A.5.5 0 0 1 8 2"/>
                                    </svg>
                                <span class="nav-link-text ms-1" style="font-size: 14px;">Thêm danh mục</span>
                            </a>

                            <!-- Parent category -->
                            <a class="nav-link text-dark" href="/admin/category-parent-list">
                                <img width="20" height="20" src="https://img.icons8.com/wired/64/categorize.png"
                                     alt="categorize"/>
                                <span class="nav-link-text ms-1" style="font-size: 14px;">Danh mục cha</span>
                            </a>

                            <!-- Child category -->
                            <a class="nav-link text-dark" href="/admin/category-child-list">
                                <img width="16" height="16" src="https://img.icons8.com/wired/64/categorize.png"
                                     alt="categorize"/>
                                <span class="nav-link-text ms-1" style="font-size: 14px;">Danh mục con</span>
                            </a>
                        </li>
                    </ul>
                </li>
            </c:if>


            <!-- Products -->
            <c:if test="${fn:contains(currentURL, '/admin/product') || fn:contains(currentURL, '/admin/import') || fn:contains(currentURL, '/admin/drop')}">
                <li class="nav-item dropdown">
                    <a class="nav-link bg-gradient-success text-white" href="#" id="dropdownMenu3"
                       data-bs-toggle="dropdown"
                       aria-expanded="true">
                        <img width="20" height="20" src="https://img.icons8.com/ios-glyphs/30/product.png" alt="product"/>
                        <span class="nav-link-text ms-1" style="font-size: 14px;">Sản phẩm</span>
                    </a>

                    <ul class="dropdown px-2 py-3 me-sm-n4" aria-labelledby="dropdownMenu3">
                        <li class="mb-2">
                            <!-- Product list -->
                            <c:if test="${!fn:contains(currentURL, '/admin/product-')}">
                                <a class="nav-link text-dark" href="/admin/product-list">
                                    <img width="20" height="20" src="https://img.icons8.com/forma-thin/24/product.png"
                                         alt="product"/>
                                    <span class="nav-link-text ms-1" style="font-size: 14px;">Danh sách sản phẩm</span>
                                </a>
                            </c:if>

                            <c:if test="${fn:contains(currentURL, '/admin/product-')}">
                                <a class="nav-link text-white bg-gradient-success" href="/admin/product-list">
                                    <img width="20" height="20" src="https://img.icons8.com/forma-thin/24/product.png"
                                         alt="product"/>
                                    <span class="nav-link-text ms-1" style="font-size: 14px;">Danh sách sản phẩm</span>
                                </a>
                            </c:if>


                            <!-- Product inventory -->
                            <c:if test="${!fn:contains(currentURL, '/admin/productInventory')}">
                                <a class="nav-link text-dark" href="/admin/productInventory-list">
                                    <img width="20" height="20" src="https://img.icons8.com/ios/50/warehouse-1.png"
                                         alt="warehouse-1"/>
                                    <span class="nav-link-text ms-1" style="font-size: 14px;">Kho hàng</span>
                                </a>
                            </c:if>

                            <c:if test="${fn:contains(currentURL, '/admin/productInventory')}">
                                <a class="nav-link text-white bg-gradient-success" href="/admin/productInventory-list">
                                    <img width="20" height="20" src="https://img.icons8.com/ios/50/warehouse-1.png"
                                         alt="warehouse-1"/>
                                    <span class="nav-link-text ms-1" style="font-size: 14px;">Kho hàng</span>
                                </a>
                            </c:if>


                            <!-- Import product -->
                            <c:if test="${fn:contains(currentURL, '/admin/import')}">
                                <a class="nav-link text-dark bg-gradient-success text-white" href="/admin/import-list">
                                    <img width="20" height="20" src="https://img.icons8.com/ios/50/import.png"
                                         alt="import"/>
                                    <span class="nav-link-text ms-1" style="font-size: 14px;">Nhập hàng</span>
                                </a>
                            </c:if>

                            <c:if test="${!fn:contains(currentURL, '/admin/import')}">
                                <a class="nav-link text-dark" href="/admin/import-list">
                                    <img width="20" height="20" src="https://img.icons8.com/ios/50/import.png"
                                         alt="import"/>
                                    <span class="nav-link-text ms-1" style="font-size: 14px;">Nhập hàng</span>
                                </a>
                            </c:if>
                        </li>
                    </ul>
                </li>
            </c:if>

            <c:if test="${!fn:contains(currentURL, '/admin/product') && !fn:contains(currentURL, '/admin/import') && !fn:contains(currentURL, '/admin/drop')}">
                <li class="nav-item dropdown">
                    <a class="nav-link text-dark" href="#" id="dropdownMenu3" data-bs-toggle="dropdown"
                       aria-expanded="true">
                        <img width="20" height="20" src="https://img.icons8.com/ios-glyphs/30/product.png" alt="product"/>
                        <span class="nav-link-text ms-1" style="font-size: 14px;">Sản phẩm</span>
                    </a>

                    <ul class="dropdown-menu dropdown-menu-animation px-2 py-3 me-sm-n4"
                        aria-labelledby="dropdownMenu3">
                        <li class="mb-2">
                            <!-- Product list -->
                            <a class="nav-link text-dark" href="/admin/product-list">
                                <img width="20" height="20" src="https://img.icons8.com/forma-thin/24/product.png"
                                     alt="product"/>
                                <span class="nav-link-text ms-1" style="font-size: 14px;">Danh sách sản phẩm</span>
                            </a>

                            <!-- Product inventory -->
                            <a class="nav-link text-dark" href="/admin/productInventory-list">
                                <img width="20" height="20" src="https://img.icons8.com/ios/50/warehouse-1.png"
                                     alt="warehouse-1"/>
                                <span class="nav-link-text ms-1" style="font-size: 14px;">Kho hàng</span>
                            </a>

                            <!-- Import product -->
                            <a class="nav-link text-dark" href="/admin/import-list">
                                <img width="20" height="20" src="https://img.icons8.com/ios/50/import.png"
                                     alt="import"/>
                                <span class="nav-link-text ms-1" style="font-size: 14px;">Nhập hàng</span>
                            </a>
                        </li>
                    </ul>
                </li>
            </c:if>


            <!-- Order -->
            <li class="nav-item">
                <c:if test="${fn:contains(currentURL, '/admin/order')}">
                    <a class="nav-link text-dark bg-gradient-success text-white" href="/admin/order-list">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" class="bi bi-file-earmark-ruled"
                             viewBox="0 0 16 16">
                            <path d="M14 14V4.5L9.5 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2M9.5 3A1.5 1.5 0 0 0 11 4.5h2V9H3V2a1 1 0 0 1 1-1h5.5zM3 12v-2h2v2zm0 1h2v2H4a1 1 0 0 1-1-1zm3 2v-2h7v1a1 1 0 0 1-1 1zm7-3H6v-2h7z"/>
                        </svg>
                        <span class="nav-link-text ms-1" style="font-size: 14px;">Đơn hàng</span>
                    </a>
                </c:if>

                <c:if test="${!fn:contains(currentURL, '/admin/order')}">
                    <a class="nav-link text-dark" href="/admin/order-list">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" class="bi bi-file-earmark-ruled"
                             viewBox="0 0 16 16">
                            <path d="M14 14V4.5L9.5 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2M9.5 3A1.5 1.5 0 0 0 11 4.5h2V9H3V2a1 1 0 0 1 1-1h5.5zM3 12v-2h2v2zm0 1h2v2H4a1 1 0 0 1-1-1zm3 2v-2h7v1a1 1 0 0 1-1 1zm7-3H6v-2h7z"/>
                        </svg>
                        <span class="nav-link-text ms-1" style="font-size: 14px;">Đơn hàng</span>
                    </a>
                </c:if>
            </li>

            <!-- News -->
            <li class="nav-item">
                <c:if test="${fn:contains(currentURL, '/admin/new')}">
                    <a class="nav-link text-dark bg-gradient-success text-white" href="/admin/news-list">
                        <img width="20" height="20"
                             src="https://img.icons8.com/external-xnimrodx-lineal-xnimrodx/64/external-blog-contact-us-xnimrodx-lineal-xnimrodx.png"
                             alt="external-blog-contact-us-xnimrodx-lineal-xnimrodx"/>
                        <span class="nav-link-text ms-1" style="font-size: 14px;">Tin tức</span>
                    </a>
                </c:if>

                <c:if test="${!fn:contains(currentURL, '/admin/new')}">
                    <a class="nav-link text-dark" href="/admin/news-list">
                        <img width="20" height="20"
                             src="https://img.icons8.com/external-xnimrodx-lineal-xnimrodx/64/external-blog-contact-us-xnimrodx-lineal-xnimrodx.png"
                             alt="external-blog-contact-us-xnimrodx-lineal-xnimrodx"/>
                        <span class="nav-link-text ms-1" style="font-size: 14px;">Tin tức</span>
                    </a>
                </c:if>
            </li>
        </ul>
    </div>
</aside>

