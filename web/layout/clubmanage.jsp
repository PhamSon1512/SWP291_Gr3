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

            .section-title {
                margin-top: 30px;
                margin-bottom: 20px;
                font-size: 22px;
                color: #008080;
            }

            .statistics {
                display: flex;
                justify-content: space-around;
                margin-bottom: 20px;
            }

            .statistics .stat-box {
                background-color: #e0f7fa;
                padding: 20px;
                border-radius: 10px;
                text-align: center;
                flex: 1;
                margin: 0 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            }

            .statistics .stat-box h3 {
                margin-bottom: 10px;
                font-size: 18px;
            }

            .statistics .stat-box p {
                margin: 0;
                font-size: 16px;
            }

            .table-responsive {
                margin-bottom: 20px;
            }

            .table-responsive table {
                width: 100%;
                margin-bottom: 20px;
            }

            .table-responsive th,
            .table-responsive td {
                padding: 10px;
                text-align: center;
            }

            .table-responsive th {
                background-color: #008080;
                color: white;
            }

            .table-responsive td {
                background-color: #f1f1f1;
            }
        </style>
    </head>
    <body>

        <div class="back-to-home rounded d-none d-sm-block">
            <a href="dashboardmanager" class="btn btn-icon btn-primary">
                <i class="fa fa-home"></i>
            </a>
        </div>

        <div class="container">
            <div class="table-title">
                <h2>Manage <b>Clubs</b></h2>
            </div>

<!--            <div class="card-deck">
<div class="card h-100 shadow-sm">
                    <a href="detail?club_id=${club.club_id}">
                        <img class="card-img-top img-responsive" src="${club.imageUrl}" alt="Club Image" />
                    </a>
                    <div class="card-body">
                        <h5 class="fw-bolder">${club.name}</h5>
                      
                    </div>

                </div>

            </div>-->

            <a href="team?club_id=${club.club_id}"><div class="section-title">Club Departments</div></a>
            <div class="statistics">
                <div class="stat-box">
                    <h3>Total Departments</h3>
                    <p>${totalDepartments}</p>
                </div>
                <div class="stat-box">
                    <h3>Active Departments</h3>
                    <p>${activeDepartments}</p>
                </div>
                <div class="stat-box">
                    <h3>Inactive Departments</h3>
                    <p>${inactiveDepartments}</p>
                </div>
            </div>

            <a href="memberdetail?club_id=${club.club_id}"><div class="section-title">Club Members</div></a>
            <div class="statistics">
                <div class="stat-box">
                    <h3>Total Members</h3>
                    <p>${totalMembers}</p>
                </div>
                <div class="stat-box">
                    <h3>Active Members</h3>
                    <p>${activeMembers}</p>
                </div>
                <div class="stat-box">
                    <h3>Inactive Members</h3>
                    <p>${inactiveMembers}</p>
                </div>
            </div>

            <div class="section-title">Budget Expenses</div>
            <div class="table-responsive">
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Expense Category</th>
                            <th>Amount</th>
                            <th>Date</th>
                            <th>Description</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${budgetExpenses}" var="expense">
                            <tr>
                                <td>${expense.category}</td>
                                <td>${expense.amount}</td>
                                <td>${expense.date}</td>
                                <td>${expense.description}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
