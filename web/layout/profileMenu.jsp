<%-- 
    Document   : profileMenu
    Created on : May 30, 2024, 12:58:33 PM
    Author     : Pham Son
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<div class="col-xl-4 col-lg-4 col-md-5 col-12">
    <div class="rounded shadow overflow-hidden sticky-bar">
        <div class="text-center avatar-profile margin-nagative mt-n5 position-relative pb-4 border-bottom">
            <br><br><br><br>
            <c:choose>
                <c:when test="${empty sessionScope.account.avatar_url}">
                    <img src="assets/images/avata.png" class="rounded-circle shadow-md avatar avatar-medium" alt="${sessionScope.account.fullname}">
                </c:when>
                <c:otherwise>
                    <img src="${sessionScope.account.avatar_url}" class="rounded-circle shadow-md avatar avatar-medium" alt="${sessionScope.account.fullname}">
                </c:otherwise>
            </c:choose>

            <h5 class="mt-3 mb-1">${sessionScope.account.username}</h5>
            <p class="text-muted mb-0">${sessionScope.account.email}</p>
        </div>

        <ul class="list-unstyled sidebar-nav mb-0">
            <li class="navbar-item">
                <c:choose>
                    <c:when test="${sessionScope.account.status == 0}">
                        <a href="dashboard?action=user" class="navbar-link"><i class="ri-airplay-line align-middle navbar-icon"></i>User Dashboard</a>
                    </c:when>
                    <c:when test="${sessionScope.account.status == 1}">
                        <a href="dashboard?action=admin" class="navbar-link"><i class="ri-airplay-line align-middle navbar-icon"></i>Admin Dashboard</a>
                    </c:when>
                    <c:when test="${sessionScope.account.status== 2}">
                        <a href="dashboard?action=manager" class="navbar-link"><i class="ri-airplay-line align-middle navbar-icon"></i>Manager Dashboard</a>
                    </c:when>
                    <c:otherwise>
                        <% response.sendRedirect("../401.jsp"); %>
                    </c:otherwise>
                </c:choose>
            </li>   
        </ul>
    </div>
</div>