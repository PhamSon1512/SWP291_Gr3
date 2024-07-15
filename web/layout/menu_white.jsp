<%-- 
    Document   : menu_white
    Created on : Feb 22, 2022, 4:57:52 PM
    Author     : Khuong Hung
--%>

<%@page import="model.Account, dal.AccountDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                        <button class="btn btn-primary flex-grow-1 me-1 p-1" onclick="window.location.href = 'user?action=login'">Login</button>
                        <button class="btn btn-primary flex-grow-1 ms-1 p-1" onclick="window.location.href = 'user?action=register'">Sign Up</button>
                    </div>
                    <%
                    }
                    %>

                    <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3" style="min-width: 200px;">
                        <%
                            if (account != null) {
                        %>
                        <a class="dropdown-item d-flex align-items-center text-" href="user?action=profile">
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
                        <a class="dropdown-item text-" href="user?action=profile"><span class="mb-0 d-inline-block me-1"><i class="uil uil-user align-middle h6"></i></span> My Account</a>
                        <a class="dropdown-item text-" onclick="redirectToChangePassword()" href="javascript:void(0)"><span class="mb-0 d-inline-block me-1"><i class="uil uil-lock-alt align-middle h6"></i></span> Change Password</a>
                        <a class="dropdown-item text-" href="user?action=logout"><span class="mb-0 d-inline-block me-1"><i class="uil uil-sign-out-alt align-middle h6"></i></span> Logout</a>
                                <%
                                    } else {
                                %>
                        <a class="dropdown-item text-" href="user?action=login"><span class="mb-0 d-inline-block me-1"><i class="uil uil-sign-in-alt align-middle h6"></i></span> Sign in</a>
                                <%
                                    }
                                %>
                    </div>
                </div>
            </li>
        </ul>

        <script>
            function redirectToChangePassword() {
                window.location.href = 'user?action=profile#changePasswordSection';
            }
        </script>            

        <script>
            window.onscroll = function () {
                var header = document.getElementById("topnav");
                if (window.pageYOffset > 0) {
                    header.style.display = "none";
                } else {
                    header.style.display = "block";
                }
            };
        </script>

</header>
