<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Club Management</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style>
        body {
            background-color: #FFDAB9;
            font-family: 'Roboto', sans-serif;
        }

        .container {
            background-color: #f7f7f7;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
            margin-top: 50px;
        }

        .table-title {
            padding-bottom: 15px;
            background-color: #008080;
            color: white;
            border-radius: 10px;
            text-align: center;
        }

        .table-title h2 {
            margin: 5px 0 0;
            font-size: 24px;
        }

        .card {
            border: none;
            border-radius: 10px;
            overflow: hidden;
            transition: transform 0.3s ease-in-out;
            margin-bottom: 20px;
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
        }

        .card:hover {
            transform: translateY(-10px);
        }

        .card img {
            height: 70%; 
            width: 100%; 
            object-fit: cover; 
        }

        .card-body {
            padding: 15px;
            text-align: center;
        }

        .btn-outline-dark {
            color: #008080;
            border-color: #008080;
        }

        .btn-outline-dark:hover {
            color: white;
            background-color: #008080;
        }

        .modal-header {
            background-color: #008080;
            color: white;
        }

        .btn-primary {
            background-color: #008080;
        }

        .btn-primary:hover {
            background-color: #00555F;
        }

        .form-control {
            border-radius: 5px;
        }

        .card-deck {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }

        .card-deck .card {
            width: calc(33.33% - 20px); 
            margin-bottom: 20px;
        }

        @media (max-width: 768px) {
            .card-deck .card {
                width: calc(50% - 20px); 
            }
        }

        @media (max-width: 576px) {
            .card-deck .card {
                width: 100%; 
            }
        }

        .back-to-home {
            position: fixed;
            bottom: 20px;
            right: 20px;
            z-index: 999;
        }

        .back-to-home .btn-icon {
            background-color: #008080;
            color: white;
            border-radius: 50%;
            width: 50px;
            height: 50px;
            display: flex;
            justify-content: center;
            align-items: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            transition: background-color 0.3s;
        }

        .back-to-home .btn-icon:hover {
            background-color: #00555F;
        }
    </style>
</head>
<body>
    
    <div class="back-to-home rounded d-none d-sm-block">
        <a href="dashboard?action=home" class="btn btn-icon btn-primary">
            <i class="fa fa-home"></i>
        </a>
    </div>

    <jsp:include page="layout/sidebar.jsp"/>
    
    <div class="container" style="margin-top: -20px;">
        <div class="text-sm-end" style="margin-top: 20px;">
            <a href="#addEmployeeModal" class="btn btn-success" data-toggle="modal"><i class="fa fa-plus"></i> <span>Add New Club</span></a>
        </div>

        <div class="table-title">
            <h2>Manage <b>Clubs</b></h2>
        </div>

        <div class="card-deck">
            <c:choose>
                <c:when test="${not empty listClubs}">
                    <c:forEach items="${listClubs}" var="P">
                        <div class="card h-100 shadow-sm">
                            <a href="detail?club_id=${P.club_id}">
                                <img class="card-img-top img-responsive" src="${P.imageUrl}" alt="Club Image" />
                            </a>
                            <div class="card-body">
                                <h5 class="fw-bolder">${P.name}</h5>
                                <span class="text-muted">${P.code}</span>
                            </div>
                            <div class="card-footer bg-transparent">
                                <a class="btn btn-outline-dark mt-auto" href="registerclub">Join</a>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${listAllClubs}" var="P">
                        <div class="card h-100 shadow-sm">
                            <a href="detail?club_id=${P.club_id}">
                                <img class="card-img-top img-responsive" src="${P.imageUrl}" alt="Club Image" />
                            </a>
                            <div class="card-body">
                                <h5 class="fw-bolder">${P.name}</h5>
                                <span class="text-muted">${P.code}</span>
                            </div>
                            <div class="card-footer bg-transparent">
                                <a class="btn btn-outline-dark mt-auto" href="registerclub">Join</a>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Add Modal HTML -->
    <div id="addEmployeeModal" class="modal fade">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <form action="newclub" method="post">
                    <div class="modal-header bg-primary text-light">
                        <h4 class="modal-title">Add New Club</h4>
                        <button type="button" class="close text-light" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                        <div class="container-fluid">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="code">Code</label>
                                        <input type="text" class="form-control" id="code" name="code" required>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="clubName">Name</label>
                                        <input type="text" class="form-control" id="clubName" name="name" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="imageUrl">Image</label>
                                        <input type="text" class="form-control" id="imageUrl" name="imageUrl" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="phoneNumber">Phone Number</label>
                                        <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="facebook">Facebook</label>
                                        <input type="text" class="form-control" id="facebook" name="facebook" required>
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="description">Description</label>
                                        <textarea class="form-control" id="description" rows="3" name="description" required></textarea>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="category_id">Category</label>
                                        <select class="form-control" id="category_id" name="category_id">
                                            <c:forEach items="${listCategories}" var="C">
                                                <option value="${C.category_id}">${C.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <input type="submit" class="btn btn-primary" value="Add Club">
                    </div>
                </form>
            </div>
        </div>
    </div>

</body>
</html>
