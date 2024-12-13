<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Panel</title>
    <style>
        /* General Page Styling */
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f9fc;
            margin: 0;
            padding: 20px;
        }

        h2, h3 {
            color: #333;
            text-align: center;
        }

        /* Form Styling */
        #locationForm {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 15px;
            padding: 10px 0;
            margin-bottom: 20px;
        }

        #locationForm label {
            font-weight: bold;
        }

        #locationForm input[type="text"] {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        #locationForm button {
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s;
        }

        #locationForm button:hover {
            background-color: #0056b3;
        }

        /* Table Styling */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 15px;
            text-align: left;
            border: 1px solid #ddd;
        }

        th {
            background-color: #4CAF50;
            color: white;
            font-weight: normal;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #e9f5fb;
        }

        /* Action Form in Table */
        .action-form {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .action-form select {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .action-form button {
            padding: 8px 15px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 12px;
            transition: background-color 0.3s;
        }

        .action-form button:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

    <h2>Admin Panel - Manage Advertisers</h2>

    <!-- Location Form -->
    <form id="locationForm" action="/admin/filterAdvertisers" method="post">
        <label for="latitude">Select Latitude:</label>
        <input type="text" id="latitude" name="latitude" required>

        <label for="longitude">Select Longitude:</label>
        <input type="text" id="longitude" name="longitude" required>

        <button type="submit">Filter Advertisers</button>
    </form>

    <!-- Advertisers Table -->
    <h3>Advertisers List</h3>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Email</th>
                <th>Name</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="advertiser" items="${advertisers}">
                <tr>
                    <td>${advertiser.advertiserId}</td>
                    <td>${advertiser.advertiserEmail}</td>
                    <td>${advertiser.name}</td>
                    <td>${advertiser.status}</td>
                    <td>
                        <form class="action-form" action="/admin/updateStatus" method="post">
                            <input type="hidden" name="advertiserId" value="${advertiser.advertiserId}">
                            <select name="newStatus">
                                <option value="approved">Approve</option>
                                <option value="rejected">Reject</option>
                            </select>
                            <button type="submit">Update Status</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

</body>
</html>
