<%-- 
    Document   : member.jsp
    Created on : Jan 5, 2022, 6:15:49 PM
    Author     : Khuong Hung
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Member Page</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f0f0f0;
                color: #333;
                margin: 0;
                padding: 0;
            }
            .container {
                max-width: 1000px;
                margin: 20px auto;
                background-color: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            h1 {
                text-align: center;
                color: #333;
                margin-bottom: 20px;
            }
            .action-bar {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }
            .action-bar form {
                display: flex;
                align-items: center;
            }
            input[type="text"], input[type="email"] {
                padding: 10px;
                width: 80%;
                max-width: 400px;
                margin-right: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
            button {
                padding: 10px 20px;
                border: none;
                background-color: #333;
                color: #fff;
                cursor: pointer;
                border-radius: 4px;
            }
            button:hover {
                background-color: #555;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
            }
            table, th, td {
                border: 1px solid #ddd;
            }
            th, td {
                padding: 12px;
                text-align: left;
                vertical-align: middle;
            }
            th {
                background-color: #f2f2f2;
                font-weight: bold;
            }
            td img {
                border-radius: 50%;
                width: 50px;
                height: 50px;
                object-fit: cover;
            }
            .no-members {
                text-align: center;
                font-size: 18px;
                color: #666;
            }
            .modal {
                display: none;
                position: fixed;
                z-index: 1;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
overflow: auto;
                background-color: rgba(0,0,0,0.5);
                justify-content: center;
                align-items: center;
            }
            .modal-content {
                background-color: #fff;
                margin: auto;
                padding: 20px;
                border: 1px solid #888;
                width: 80%;
                max-width: 500px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
                text-align: center;
            }
            .close {
                color: #aaa;
                float: right;
                font-size: 28px;
                font-weight: bold;
            }
            .close:hover,
            .close:focus {
                color: black;
                text-decoration: none;
                cursor: pointer;
            }
            .alert {
                color: red;
                text-align: center;
                margin-top: 10px;
            }
            .back-button {
                background-color: #333;
                color: #fff;
                border: none;
                padding: 10px 20px;
                cursor: pointer;
                border-radius: 4px;
                display: flex;
                align-items: center;
                margin-bottom: 10px;
            }
            .back-button svg {
                fill: currentColor;
                margin-right: 5px;
            }
            .back-button:hover {
                background-color: #555;
            }
        </style>
        <script>
            function goBack() {
                window.history.back();
            }

            function toggleAddMemberForm() {
                var modal = document.getElementById("addMemberModal");
                var alertMessage = document.getElementById("alertMessage");
                if (modal.style.display === "none" || modal.style.display === "") {
                    modal.style.display = "flex";
                    alertMessage.innerHTML = "Adding a new member.";
                } else {
                    modal.style.display = "none";
                    alertMessage.innerHTML = "";
                }
            }

            function closeModal() {
                var modal = document.getElementById("addMemberModal");
                var alertMessage = document.getElementById("alertMessage");
                modal.style.display = "none";
                alertMessage.innerHTML = "";
            }
        </script>
    </head>
    <body>
        <div class="container">
            <button class="back-button" onclick="goBack()">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
                <path d="M20 11H7.414l3.293-3.293a1 1 0 0 0-1.414-1.414l-5 5a1 1 0 0 0 0 1.414l5 5a1 1 0 0 0 1.414-1.414L7.414 13H20a1 1 0 0 0 0-2z"/>
                </svg>
                Back
            </button>



            <div class="action-bar">
<button onclick="toggleAddMemberForm()">Add Member</button>
                <form action="searchMembers" method="get">
                    <input type="text" name="query" placeholder="Search members..." value="${param.query}">
                    <button type="submit">Search</button>
                </form>
            </div>

            <div id="alertMessage" class="alert"></div>

            <div id="addMemberModal" class="modal">
                <div class="modal-content">
                    <span class="close" onclick="closeModal()">&times;</span>
                    <h2>Add New Member</h2>
                    <form action="addMember" method="post">
                        <input type="text" name="fullName" placeholder="Full Name" required>
                        <input type="text" name="position" placeholder="Position" required>
                        <input type="email" name="email" placeholder="Email" required>
                        <input type="text" name="imageUrl" placeholder="Image URL" required>
                        <button type="submit">Add Member</button>
                    </form>
                </div>
            </div>

            <c:choose>
                <c:when test="${not empty clubMembers}">
                    <table>
                        <thead>
                            <tr>
                                <th>Serial No.</th>
                                <th>Image</th>
                                <th>Full Name</th>
                                <th>Position</th>
                                <th>Email</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="member" items="${clubMembers}" varStatus="status">
                                <tr>
                                    <td>${status.index + 1}</td>
                                    <td><img src="${member.imageUrl}" alt="Member Image"></td>
                                    <td>${member.fullName}</td>
                                    <td>${specialityMap[member.speciality_id]}</td>
                                    <td>${member.email}</td>
                                </tr>
                            </c:forEach>

                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <p class="no-members">No more members to display.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </body>
</html>