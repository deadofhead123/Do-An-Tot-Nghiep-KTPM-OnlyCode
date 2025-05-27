<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 3/14/2025
  Time: 1:58 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav class="sidebar" id="sidebar">
    <div class="sidebar__container">
        <div class="sidebar__content">
            <div>
                <div class="sidebar__list">
                    <a href="/my-account" class="sidebar__link ftco-animate">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" class="bi bi-person-circle"
                             viewBox="0 0 16 16">
                            <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
                            <path fill-rule="evenodd"
                                  d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1"/>
                        </svg>
                        <span>Trang tài khoản</span>
                    </a>

                    <a href="/change-password" class="sidebar__link ftco-animate">
                        <img width="16" height="16" src="https://img.icons8.com/doodle/48/password.png" alt="password"/>
                        <span>Đổi mật khẩu</span>
                    </a>

                    <a href="/my-orders" class="sidebar__link ftco-animate">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" class="bi bi-file-earmark-ruled"
                             viewBox="0 0 16 16">
                            <path d="M14 14V4.5L9.5 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2M9.5 3A1.5 1.5 0 0 0 11 4.5h2V9H3V2a1 1 0 0 1 1-1h5.5zM3 12v-2h2v2zm0 1h2v2H4a1 1 0 0 1-1-1zm3 2v-2h7v1a1 1 0 0 1-1 1zm7-3H6v-2h7z"/>
                        </svg>
                        <span>Đơn hàng</span>
                    </a>

                    <a href="/my-product-bought" class="sidebar__link ftco-animate">
                        <img width="16" height="16" src="https://img.icons8.com/forma-thin/24/product.png"
                             alt="product"/>
                        <span>Sản phẩm đã mua</span>
                    </a>
                </div>
            </div>
        </div>

    </div>
</nav>
