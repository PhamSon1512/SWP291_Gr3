<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Teams Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f8fa;
            color: #4a4a4a;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 1200px;
            margin: 20px auto;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }
        .rectangle-container {
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
            margin-bottom: 30px;
        }
        .rectangle {
            width: 150px;
            height: 150px;
            background-color: #007BFF;
            color: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 15px;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s;
            text-align: center;
            font-size: 16px;
            font-weight: bold;
        }
        .rectangle:hover {
            background-color: #0056b3;
        }
        .department-info, .members {
            display: none;
        }
        .department-info.active, .members.active {
            display: block;
        }
        .department-info {
            background-color: #f1f1f1;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
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
        }
        th {
            background-color: #007BFF;
            color: white;
        }
        .member img {
            border-radius: 50%;
            width: 60px;
            height: 60px;
            object-fit: cover;
        }
    </style>
    <script>
        function showDepartmentInfo(specialityId) {
            // Hide all department info sections
            document.querySelectorAll('.department-info, .members').forEach(function(element) {
                element.classList.remove('active');
            });
            
            // Show the selected department info section
            document.getElementById('department-info-' + specialityId).classList.add('active');
            document.getElementById('members-' + specialityId).classList.add('active');
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>Club Teams</h1>
        
        <div class="rectangle-container">
            <c:forEach var="entry" items="${departmentMembersMap}">
                <div class="rectangle" onclick="showDepartmentInfo(${entry.key})">
                    ${specialityMap[entry.key]}
                </div>
            </c:forEach>
        </div>
        
        <c:forEach var="entry" items="${departmentMembersMap}">
            <c:set var="deptInfo" value="${departmentInfoMap[entry.key]}" />
            <div id="department-info-${entry.key}" class="department-info">
                <h2>${specialityMap[entry.key]}</h2>
                <table>
                    <tr>
                        <th>Description</th>
                        <th>Member Count</th>
                        <th>Current Projects</th>
                        <th>Achievements</th>
                        <th>Regular Meeting Schedule</th>
                    </tr>
                    <tr>
                        <td>${deptInfo.description}</td>
                        <td>${deptInfo.memberCount}</td>
                        <td>${deptInfo.currentProjects}</td>
                        <td>${deptInfo.achievements}</td>
                        <td>${deptInfo.regularMeetingSchedule}</td>
                    </tr>
                </table>
            </div>
            
            <div id="members-${entry.key}" class="members">
                <h3>Members</h3>
                <table>
                    <tr>
                        <th>Image</th>
                        <th>Name</th>
                        <th>Email</th>
                    </tr>
                    <c:forEach var="member" items="${entry.value}">
                        <tr class="member">
                            <td><img src="${member.imageUrl}" alt="Member Image"></td>
                            <td>${member.fullName}</td>
                            <td>${member.email}</td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </c:forEach>
        
    </div>
</body>
</html>