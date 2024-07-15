<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Sidebar</title>
   <style>
        body {
            display: flex;
            margin: 0;
            padding: 0;
        }

        .sidebar {
            width: 250px;
            background-color: #333;
            color: white;
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            overflow-y: auto;
            padding-top: 20px;
            display: flex;
            flex-direction: column; /* Sắp xếp các thành phần theo chiều dọc */
            justify-content: start; /* Căn giữa theo chiều dọc */
        }

        .sidebar-menu {
            list-style-type: none;
            padding: 0;
        }

        .sidebar-menu .has-submenu > .sub-menu-item {
            padding: 10px 15px;
            display: block;
            color: white;
            text-decoration: none;
            transition: background-color 0.3s;
        }

        .sidebar-menu .has-submenu > .sub-menu-item:hover {
            background-color: #575757;
        }

        .sidebar-menu .submenu {
            list-style-type: none;
            padding: 0;
            display: none;
        }

        .sidebar-menu .has-submenu:hover .submenu {
            display: block;
        }

        .sidebar-menu .list-group-item {
            padding: 10px 15px;
        }

        .sidebar-menu .list-group-item a {
            color: white;
            text-decoration: none;
            display: block;
            transition: background-color 0.3s;
        }

        .sidebar-menu .list-group-item a:hover {
            background-color: #575757;
        }

        .sidebar-menu .list-group-item.active {
            background-color: #575757;
        }

        .sidebar-menu .dropdown-indicator {
            float: right;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <ul class="sidebar-menu">
            <li class="has-submenu">
                <a href="newclub" class="sub-menu-item">Club Categories <span class="dropdown-indicator"></span></a>
                <ul class="submenu">
                    <c:forEach items="${listCategories}" var="C">
                        <li class="list-group-item ${tag == C.category_id ? 'active' : ''} flex-grow-1">
                            <a href="newclub?categoryId=${C.category_id}" class="d-block" style="color: black;">${C.name}</a>
                        </li>
                    </c:forEach>
                </ul>
            </li>
        </ul>
    </div>
</body>
</html>
