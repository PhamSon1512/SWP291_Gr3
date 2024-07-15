<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav id="sidebar" class="sidebar-wrapper">
    <div class="sidebar-content" data-simplebar style="height: calc(100% - 60px);">
        <ul class="sidebar-menu pt-3">
            <c:if test="${sessionScope.account.status == 1}">
                <li><a href="dashboard?action=home"><i class="uil uil-dashboard me-2 d-inline-block"></i>Dashboard</a></li>
                <li><a href="setting?action=all"><i class="uil uil-cog me-2 d-inline-block"></i>Setting</a></li>
                <li><a href="account?action=all"><i class="uil uil-user me-2 d-inline-block"></i>Account</a></li>
                <li><a href="doctormanage?action=all"><i class="uil uil-apps me-2 d-inline-block"></i>Blogs</a></li>
                <li><a href="newclub"><i class="uil uil-users-alt me-2 d-inline-block"></i>Clubs</a></li>
                <li><a href="servicemanage?action=all"><i class="uil uil-social-distancing me-2 d-inline-block"></i>Clubs Member</a></li>
                <li><a href="regisclub?action=all"><i class="uil uil-envelope me-2 d-inline-block"></i>Club Register</a></li>
                <li><a href="reservationmanage?action=all"><i class="uil uil-calendar-alt me-2 d-inline-block"></i>Event</a></li>
                <li><a href="contact.jsp"><i class="uil uil-calendar-alt me-2 d-inline-block"></i>Admin Contact</a></li>
                <li><a href="admin/post"><i class="uil uil-calendar-alt me-2 d-inline-block"></i>Post</a></li>
            </c:if>

            <c:if test="${sessionScope.account.status == 2}">
                <li><a href="dashboard?action=home"><i class="uil uil-dashboard me-2 d-inline-block"></i>Dashboard</a></li>
                <li><a href="setting?action=all"><i class="uil uil-cog me-2 d-inline-block"></i>Setting</a></li>
                <li><a href="doctormanage?action=all"><i class="uil uil-apps me-2 d-inline-block"></i>Blogs</a></li>
                <li class="sidebar-dropdown">
                    <a href="#">
                        <i class="uil uil-users-alt me-2 d-inline-block"></i>
                        <span>Clubs</span>
                        <i></i>
                    </a>
                    <div class="sidebar-submenu">
                        <ul>
                            <li><a href="team?club_id=${clubId}"><i class="uil uil-users-alt me-2"></i>Teams</a></li>
                           
                        <li><a href="memberdetail?club_id=${clubId}"><i class="uil uil-user me-2"></i>Members</a></li></ul>
                    </div>
                </li>
                <li><a href="ViewRegistrationsServlet"><i class="uil uil-envelope me-2 d-inline-block"></i>Register Club</a></li>
                <li><a href="reservationmanage?action=all"><i class="uil uil-calendar-alt me-2 d-inline-block"></i>Event</a></li>
                <li><a href="reservationmanage?action=all"><i class="uil uil-calendar-alt me-2 d-inline-block"></i>Task</a></li>
                <li><a href="post"><i class="uil uil-calendar-alt me-2 d-inline-block"></i>Post</a></li>
            </c:if>

            <c:if test="${sessionScope.user.role.role_id == 0}">
                <li><a href="appointmentmanage?action=all"><i class="uil uil-stethoscope me-2 d-inline-block"></i>Club</a></li>
                <li><a href="reservationmanage?action=all"><i class="uil uil-stethoscope me-2 d-inline-block"></i>Task</a></li>
                <li><a href="reservationmanage?action=all"><i class="uil uil-stethoscope me-2 d-inline-block"></i>Admin Contact</a></li>
                <li><a href="post.jsp"><i class="uil uil-calendar-alt me-2 d-inline-block"></i>Post</a></li>
            </c:if>
        </ul>
    </div>
</nav>

<style>
    /* Add CSS to hide nested lists */
    .sidebar-menu {
        padding: 0;
        margin: 0;
        list-style: none;
    }

    .sidebar-menu li {
        margin-bottom: 10px;
    }

    .sidebar-menu a {
        display: block;
        color: #fff;
        padding: 10px 15px;
        text-decoration: none;
        transition: 0.3s;
    }

    .sidebar-menu a:hover {
        background-color: rgba(255, 255, 255, 0.1);
    }

    .sidebar-dropdown > a {
        position: relative;
    }

    .menu-arrow {
        position: absolute;
        right: 15px;
        top: 50%;
        transform: translateY(-50%);
        transition: transform 0.3s;
    }

    .sidebar-submenu {
        display: none;
        background-color: rgba(255, 255, 255, 0.05);
        padding: 5px 0;
    }

    .sidebar-submenu ul {
        padding: 0;
        list-style: none;
    }

    .sidebar-submenu a {
        padding-left: 30px;
    }

    .sidebar-submenu a:hover {
        background-color: rgba(255, 255, 255, 0.1);
    }

    .sidebar-dropdown.active .sidebar-submenu {
        display: block;
    }

    .sidebar-dropdown.active .menu-arrow {
        transform: rotate(180deg);
    }
</style>

<script>
    // JavaScript to toggle the submenu visibility
    document.addEventListener('DOMContentLoaded', function () {
        var dropdowns = document.querySelectorAll('.sidebar-dropdown > a');
        dropdowns.forEach(function (dropdown) {
            dropdown.addEventListener('click', function (e) {
                e.preventDefault();
                var parent = this.parentElement;
                parent.classList.toggle('active');
                var submenu = parent.querySelector('.sidebar-submenu');
                if (submenu.style.display === "block") {
                    submenu.style.display = "none";
                } else {
                    submenu.style.display = "block";
                }
            });
        });
    });
</script>
