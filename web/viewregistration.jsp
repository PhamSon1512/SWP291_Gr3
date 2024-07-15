<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>View Registrations</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }
            .container {
                width: 80%;
                margin: 20px auto;
                background-color: #fff;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            h1 {
                text-align: center;
                margin-bottom: 20px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            th, td {
                border: 1px solid #ddd;
                padding: 10px;
                text-align: left;
            }
            th {
                background-color: #f2f2f2;
            }
            .button-container {
                display: flex;
                justify-content: space-between;
            }
            .button-container button {
                padding: 8px 16px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 14px;
                transition: background-color 0.3s ease;
            }
            .button-container .accept {
                background-color: #4CAF50;
                color: white;
            }
            .button-container .accept:hover {
                background-color: #45a049;
            }
            .button-container .reject {
                background-color: #f44336;
                color: white;
            }
            .button-container .reject:hover {
                background-color: #d32f2f;
            }
            .message {
                padding: 10px;
                margin: 10px 0;
                border-radius: 5px;
                text-align: center;
                font-size: 14px;
            }
            .message.success {
                background-color: #4CAF50;
                color: white;
            }
            .message.error {
                background-color: #f44336;
                color: white;
            }
            .back-btn {
                display: inline-block;
                padding: 8px 16px;
                background-color: #337ab7;
                color: white;
                text-decoration: none;
                border-radius: 4px;
                transition: background-color 0.3s ease;
            }
            .back-btn:hover {
                background-color: #23527c;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Your Registrations</h1>
            <a href="javascript:history.back()" class="back-btn">Back</a>

            <table>
                <thead>
                    <tr>
                        <th>Serial No.</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Purpose</th>
                        <th>Committees</th>
                        <th>Description</th>
                        <th>Status</th>
                        <th>Submitted On</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="registration" items="${registrations}" varStatus="loop">
                        <tr>
                            <td>${loop.index + 1}</td>
                            <td>${registration.name}</td>
                            <td>${registration.email}</td>
                            <td>${registration.purpose}</td>
                            <td>${registration.committees}</td>
                            <td>${registration.description}</td>
                            <td>${registration.status}</td>
                            <td>${registration.createdAt}</td>
                            <td>
                                <div class="button-container">
                                    <form method="post" action="accept">
                                        <input type="hidden" name="registrationId" value="${registration.id}" />
                                        <button type="submit" class="accept">Accept</button>
                                    </form>
                                    <form method="post" action="reject">
                                        <input type="hidden" name="registrationId" value="${registration.id}" />
                                        <button type="submit" class="reject">Reject</button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <c:if test="${not empty successMessage}">
                <div class="message success">${successMessage}</div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="message error">${errorMessage}</div>
            </c:if>
        </div>
    </body>
</html>