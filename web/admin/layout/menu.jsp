<%-- 
    Document   : menu
    Created on : Jan 14, 2022, 3:12:10 PM
    Author     : Khuong Hung
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav id="sidebar" class="sidebar-wrapper">
    <div class="sidebar-content" data-simplebar style="height: calc(100% - 60px);">

        <ul class="sidebar-menu pt-3">
            <c:if test="${sessionScope.account.status == 1}">
                <li><a href="dashboard?action=default"><i class="uil uil-dashboard me-2 d-inline-block"></i>Dashboard</a></li> <!-- statistic -->
                <li><a href="setting?action=all"><i class="uil uil-stethoscope me-2 d-inline-block"></i>Setting</a></li> <!-- change status setting -->
                <li><a href="account?action=all"><i class="uil uil-user me-2 d-inline-block"></i>Account</a></li> <!-- add new user -->
                <li><a href="doctormanage?action=all"><i class="uil uil-user me-2 d-inline-block"></i>Blogs</a></li> <!-- statistic -->
                <li><a href="patientmanage?action=all"><i class="uil uil-user me-2 d-inline-block"></i>Clubs</a></li> <!-- add new club -->
                <li><a href="servicemanage?action=all"><i class="uil uil-apps me-2 d-inline-block"></i>Clubs Member</a></li> <!-- admin: statistic, manager: can add and accept new user join club -->
                <li><a href="appointmentmanage?action=all"><i class="uil uil-stethoscope me-2 d-inline-block"></i>Register Club</a></li> <!-- manager: can add and accept new user join club -->
                <li><a href="reservationmanage?action=all"><i class="uil uil-stethoscope me-2 d-inline-block"></i>Event</a></li> <!-- admin: statistic; manager: can add and accept new event -->
                <li><a href="reservationmanage?action=all"><i class="uil uil-stethoscope me-2 d-inline-block"></i>Admin Contact</a></li>
                <!--<li><a href="blogmanage?action=all"><i class="uil uil-flip-h me-2 d-inline-block"></i>Quản lý blog</a></li>-->
                </c:if>

            <c:if test="${sessionScope.account.status == 2}">
                <li><a href="doctormanage?action=all"><i class="uil uil-user me-2 d-inline-block"></i>Quản lý Bác sĩ</a></li>
                <li><a href="patientmanage?action=all"><i class="uil uil-user me-2 d-inline-block"></i>Quản lý Bệnh nhân</a></li>
                <li><a href="servicemanage?action=all"><i class="uil uil-apps me-2 d-inline-block"></i>Quản lý Dịch vụ</a></li>
                <li><a href="blogmanage?action=all"><i class="uil uil-flip-h me-2 d-inline-block"></i>Quản lý blog</a></li>
                </c:if>

            <c:if test="${sessionScope.user.role.role_id == 3}">
                <li><a href="appointmentmanage?action=all"><i class="uil uil-stethoscope me-2 d-inline-block"></i>Quản lý lịch hẹn</a></li>
                <li><a href="reservationmanage?action=all"><i class="uil uil-stethoscope me-2 d-inline-block"></i>Quản lý đặt lịch dịch vụ</a></li>
                </c:if>
        </ul>
    </div>
</nav>
