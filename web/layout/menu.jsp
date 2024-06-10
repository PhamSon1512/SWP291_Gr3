<%-- 
    Document   : menu
    Created on : May 26, 2024, 1:14:27 AM
    Author     : Pham Son
--%>

<%@page import="model.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <header id="topnav" class="navigation sticky">
        <div class="container">

            <div>
                <a class="logo" href="home">
                    <img src="assets/images/bg/fpt.png" height="50" class="l-light" alt="">
                    <img src="assets/images/bg/fpt.png" class="l-dark" height="50" alt="">
                </a>
            </div>

            <div class="menu-extras">
                <div class="menu-item">
                    <a class="navbar-toggle" id="isToggle" onclick="toggleMenu()">
                        <div class="lines">
                            <span></span>
                            <span></span>
                            <span></span>
                        </div>
                    </a>
                </div>
            </div>

            <ul class="dropdowns list-inline mb-0">
                <li class="list-inline-item mb-0 ms-1">
                    <div class="dropdown dropdown-primary">
                        <%
                        Account account = (Account) session.getAttribute("account");
                        String avatarUrl = "assets/images/avata.png"; // default avatar
                        if (account != null) {
                            String accountAvatar = account.getAvatar_url();
                            if (accountAvatar != null && !accountAvatar.isEmpty()) {
                                avatarUrl = accountAvatar;
                            }
                        %>
                        <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <img src="<%= avatarUrl %>" class="avatar avatar-md-sm rounded-circle shadow" alt="Avatar">
                        </button>
                        <%
                        } else {
                        %>
                        <div class="d-flex justify-content-between">
                            <button class="btn btn-primary flex-grow-1 me-1 p-1" onclick="window.location.href = 'checklogin'">Login</button>
                            <button class="btn btn-primary flex-grow-1 ms-1 p-1" onclick="window.location.href = 'register'">Sign Up</button>
                        </div>
                        <%
                        }
                        %>

                        <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3" style="min-width: 200px;">
                            <%
                                if (account != null) {
                            %>
                            <a class="dropdown-item d-flex align-items-center text-" href="updateprofile">
                                <img src="<%= avatarUrl %>" class="avatar avatar-md-sm rounded-circle shadow" alt="Avatar">
                                <div class="flex-1 ms-2">
                                    <span class="d-block mb-1"><%= account.getFullname() %></span>
                                </div>
                            </a>
                            <%
                                }
                            %>
                            <div class="dropdown-divider border-top"></div>
                            <%
                                if (account != null) {
                            %>
                            <a class="dropdown-item text-" href="updateprofile"><span class="mb-0 d-inline-block me-1"><i class="uil uil-user align-middle h6"></i></span> Tài khoản của tôi</a>
                            <a class="dropdown-item text-" onclick="redirectToChangePassword()" href="javascript:void(0)"><span class="mb-0 d-inline-block me-1"><i class="uil uil-lock-alt align-middle h6"></i></span> Thay đổi mật khẩu</a>
                            <a class="dropdown-item text-" href="logout"><span class="mb-0 d-inline-block me-1"><i class="uil uil-sign-out-alt align-middle h6"></i></span> Đăng xuất</a>
                                    <%
                                        } else {
                                    %>
                            <a class="dropdown-item text-" href="checklogin"><span class="mb-0 d-inline-block me-1"><i class="uil uil-sign-in-alt align-middle h6"></i></span> Đăng Nhập</a>
                                    <%
                                        }
                                    %>
                        </div>
                    </div>
                </li>
            </ul>

            <script>
                function redirectToChangePassword() {
                    window.location.href = 'updateprofile#changePasswordSection';
                }
            </script>

            <div id="navigation" style="margin-left: 300px">

                <ul class="navigation-menu nav-left nav-light"  >
                    <li class="has-submenu">
                        <a href="javascript:void(0)" class="sub-menu-item">Club <span class="dropdown-indicator"></span></a>
                        <ul class="submenu">
                            <li class="has-submenu parent-menu-item">
                            <li><a href="#" class="sub-menu-item">Music club</a></li>
                    </li>
                    <li><a href="#" class="sub-menu-item">Sport Club</a></li>
                    <li><a href="#" class="sub-menu-item">Bussiness club</a></li>
                    <li><a href="#" class="sub-menu-item">English Club</a></li>
                    <li><a href="#" class="sub-menu-item">Street Workout Club</a></li>
                    <li><a href="#" class="sub-menu-item">Hebe Club</a></li>
                    <li><a href="#" class="sub-menu-item"> Basketball Club</a></li>
                    <li><a href="#" class="sub-menu-item">Chess Club</a></li>
                    <li><a href="#" class="sub-menu-item">Gymnastic Club</a></li>
                    <li><a href=#" class="sub-menu-item"> Debate Club</a></li>
                </ul>
                </li>
                <li><a href="blog" class="sub-menu-item">Blog</a></li>

                <%
                       if (account != null) {
                %>
                <li><a href="registerclub" class="sub-menu-item">Register Club</a></li>
                    <%
                           } else {
                    %>
                <li><a href="checklogin" class="sub-menu-item">Register Club</a></li>
                    <% 
                        }
                    %>
                <li><a href="contact" class="sub-menu-item">About us</a></li>
                </ul>

            </div>
        </div>
    </header>
</html>

