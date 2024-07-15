<%-- 
    Document   : financial_management.jsp
    Created on : July 1, 2024, 3:00 PM
    Author     : Your Name
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Financial Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            color: #333;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 1200px;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            text-align: center;
            color: #333;
        }
        .section {
            margin-bottom: 30px;
            padding: 15px;
            background-color: #f9f9f9;
            border-radius: 4px;
        }
        .section-header {
            margin-bottom: 10px;
            padding-bottom: 10px;
            border-bottom: 1px solid #ccc;
        }
        .section-title {
            font-size: 1.5rem;
            color: #333;
            margin-bottom: 10px;
        }
        .section-content {
            margin-top: 15px;
        }
        .table-container {
            margin-top: 20px;
            overflow-x: auto;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
            font-weight: bold;
        }
        .form-container {
            margin-top: 20px;
            background-color: #f9f9f9;
            padding: 15px;
            border-radius: 4px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-group input, .form-group select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 1rem;
        }
        .form-group textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 1rem;
            resize: vertical;
        }
        .button-container {
            margin-top: 15px;
            text-align: center;
        }
        .button-container button {
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1rem;
        }
        .button-container button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Financial Management</h1>
        
        <div class="section">
            <div class="section-header">
                <h2 class="section-title">Budget Management</h2>
            </div>
            <div class="section-content">
                <p>Manage and track your club's budget here.</p>
                <!-- Add budget management forms and tables -->
                <div class="form-container">
                    <h3>Add New Budget Item</h3>
                    <form action="add_budget_item" method="post">
                        <div class="form-group">
                            <label for="item_name">Item Name:</label>
                            <input type="text" id="item_name" name="item_name" required>
                        </div>
                        <div class="form-group">
                            <label for="item_amount">Item Amount:</label>
                            <input type="number" id="item_amount" name="item_amount" required>
                        </div>
                        <div class="button-container">
                            <button type="submit">Add Budget Item</button>
                        </div>
                    </form>
                </div>
                <div class="table-container">
                    <h3>Current Budget Items</h3>
                    <table>
                        <thead>
                            <tr>
                                <th>Item Name</th>
                                <th>Amount</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Populate table with budget items dynamically -->
                            <tr>
                                <td>Item 1</td>
                                <td>$1000</td>
                            </tr>
                            <tr>
                                <td>Item 2</td>
                                <td>$500</td>
                            </tr>
                            <!-- Repeat rows as needed -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        
        <div class="section">
            <div class="section-header">
                <h2 class="section-title">Income and Expenses Management</h2>
            </div>
            <div class="section-content">
                <p>Manage income and expenses for your club.</p>
                <!-- Add income and expenses management forms and tables -->
                <div class="form-container">
                    <h3>Add New Income or Expense</h3>
                    <form action="add_income_expense" method="post">
                        <div class="form-group">
                            <label for="transaction_type">Transaction Type:</label>
                            <select id="transaction_type" name="transaction_type" required>
                                <option value="income">Income</option>
                                <option value="expense">Expense</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="amount">Amount:</label>
                            <input type="number" id="amount" name="amount" required>
                        </div>
                        <div class="form-group">
                            <label for="description">Description:</label>
                            <textarea id="description" name="description" rows="3"></textarea>
                        </div>
                        <div class="button-container">
                            <button type="submit">Add Transaction</button>
                        </div>
                    </form>
                </div>
                <div class="table-container">
                    <h3>Recent Transactions</h3>
                    <table>
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Type</th>
                                <th>Amount</th>
                                <th>Description</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Populate table with transactions dynamically -->
                            <tr>
                                <td>2024-07-01</td>
                                <td>Income</td>
                                <td>$100</td>
                                <td>Membership fees</td>
                            </tr>
                            <tr>
                                <td>2024-06-30</td>
                                <td>Expense</td>
                                <td>$50</td>
                                <td>Equipment purchase</td>
                            </tr>
                            <!-- Repeat rows as needed -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        
        <div class="section">
            <div class="section-header">
                <h2 class="section-title">Financial Reports</h2>
            </div>
            <div class="section-content">
                <p>View and analyze financial reports.</p>
                <!-- Add financial reports -->
                <div class="table-container">
                    <h3>Monthly Financial Summary</h3>
                    <table>
                        <thead>
                            <tr>
                                <th>Month</th>
                                <th>Income</th>
                                <th>Expenses</th>
                                <th>Net Income</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Populate table with monthly summary dynamically -->
                            <tr>
                                <td>January 2024</td>
                                <td>$1500</td>
                                <td>$800</td>
                                <td>$700</td>
                            </tr>
                            <tr>
                                <td>February 2024</td>
                                <td>$1800</td>
                                <td>$1000</td>
                                <td>$800</td>
                            </tr>
                            <!-- Repeat rows as needed -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        
        <div class="section">
            <div class="section-header">
                <h2 class="section-title">Debt and Financial Management</h2>
            </div>
            <div class="section-content">
                <p>Manage debts and financial obligations.</p>
                <!-- Add debt management forms and tables -->
                <div class="form-container">
                    <h3>Add New Debt Item</h3>
                    <form action="add_debt_item" method="post">
                        <div class="form-group">
                            <label for="debtor_name">Debtor Name:</label>
                            <input type="text" id="debtor_name" name="debtor_name" required>
                        </div>
                        <div class="form-group">
                            <label for="debt_amount">Debt Amount:</label>
                            <input type="number" id="debt_amount" name="debt_amount" required>
                        </div>
                        <div class="form-group">
                            <label for="debt_description">Debt Description:</label>
                            <textarea id="debt_description" name="debt_description" rows="3"></textarea>
                        </div>
                        <div class="button-container">
                            <button type="submit">Add Debt Item</button>
                        </div>
                    </form>
                </div>
                <div class="table-container">
                    <h3>Current Debts</h3>
                    <table>
                        <thead>
                            <tr>
                                <th>Debtor Name</th>
                                <th>Amount</th>
                                <th>Description</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Populate table with debt items dynamically -->
                            <tr>
                                <td>Supplier A</td>
                                <td>$500</td>
                                <td>Equipment purchase</td>
                            </tr>
                            <tr>
                                <td>Supplier B</td>
                                <td>$300</td>
                                <td>Material supply</td>
                            </tr>
                            <!-- Repeat rows as needed -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        
    </div>
</body>
</html>
