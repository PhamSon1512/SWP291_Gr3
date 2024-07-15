<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="dal.ClubDAO" %>
<%@ page import="model.Club" %>
<%@ page import="java.util.List" %>

<%
    ClubDAO clubDAO = new ClubDAO();
    List<Club> clubs = clubDAO.getAllClubs();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Event</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/css/bootstrap.min.css">
    <style>
        body {
            background: #f0f2f5;
            font-family: Arial, sans-serif;
            padding: 20px;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            background: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .form-title {
            text-align: center;
            font-size: 2rem;
            font-weight: bold;
            color: #1877f2;
            margin-bottom: 20px;
        }
        .form-label {
            font-size: 1rem;
            font-weight: bold;
            color: #333;
        }
        .form-control {
            border: 1px solid #ced4da;
            border-radius: 5px;
            padding: 10px;
            margin-bottom: 15px;
        }
        .btn-primary {
            background-color: #1877f2;
            border: none;
            padding: 12px;
            border-radius: 5px;
            font-size: 1rem;
            font-weight: bold;
            cursor: pointer;
        }
        .btn-primary:hover {
            background-color: #166fe5;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="form-title">Add Event</h2>
        <form action="addEventServlet" method="post" enctype="multipart/form-data">
            <div class="mb-3">
                <label for="title" class="form-label">Event Title</label>
                <input type="text" id="title" name="title" class="form-control" required>
            </div>
            <div class="mb-3">
                <label for="content" class="form-label">Event Description</label>
                <textarea id="content" name="content" class="form-control" rows="5" required></textarea>
            </div>
            <div class="mb-3">
                <label for="thumbnail" class="form-label">Thumbnail Image:</label>
                <input type="file" id="thumbnail" name="thumbnail" class="form-control" accept="image/*" required>
            </div>
            <div class="mb-3">
                <label for="startDate" class="form-label">Start Date</label>
                <input type="date" id="startDate" name="startDate" class="form-control" required>
            </div>
            <div class="mb-3">
                <label for="endDate" class="form-label">End Date</label>
                <input type="date" id="endDate" name="endDate" class="form-control" required>
</div>
            <div class="mb-3">
                <label for="clubId" class="form-label">Select Club</label>
                <select id="clubId" name="clubId" class="form-control" required>
                    <option value="" disabled selected>Select a club</option>
                    <% for (Club club : clubs) { %>
                        <option value="<%= club.getClub_id() %>"><%= club.getName() %></option>
                    <% } %>
                </select>
            </div>
            <div class="mb-3">
                <label for="userId" class="form-label">User ID</label>
                <input type="number" id="userId" name="userId" class="form-control" required>
            </div>
            <div class="mb-3 text-center">
                <button type="submit" class="btn btn-primary">Add Event</button>
            </div>
        </form>
    </div>
</body>
</html>