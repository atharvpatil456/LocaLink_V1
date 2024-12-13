<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Advertisement</title>
    <style>
        /* General Page Styling */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7f9;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .form-container {
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            width: 100%;
            text-align: center;
        }

        h2 {
            color: #333;
            margin-bottom: 20px;
        }

        /* Form Styling */
        form {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        label {
            font-weight: bold;
            color: #333;
            text-align: left;
            margin-bottom: 5px;
        }

        input[type="text"],
        input[type="number"] {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            width: 100%;
        }

        input[type="submit"] {
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
            margin-top: 10px;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }

        .error-message {
            color: red;
            font-size: 14px;
            margin-top: 10px;
        }
    </style>
</head>
<body>

<div class="form-container">
    <h2>Create Advertisement</h2>
    <form:form method="post" modelAttribute="advertisement">
        <label for="adDesc">Description:</label>
        <form:input path="adDesc" id="adDesc" required/>

        <label for="adName">Name:</label>
        <form:input path="adName" id="adName" required/>

        <label for="adPrice">Price:</label>
        <form:input path="adPrice" id="adPrice" type="number" step="0.01" required/>

        <label for="imageUrl">Image URL:</label>
        <form:input path="imageUrl" id="imageUrl" required/>

        <label for="latitude">Latitude:</label>
        <form:input path="latitude" id="latitude" required/>

        <label for="longitude">Longitude:</label>
        <form:input path="longitude" id="longitude" required/>

        <input type="hidden" name="advertiserEmail" value="${advertiser.advertiserEmail}" />
        <input type="submit" value="Create Ad" />
    </form:form>

    <c:if test="${not empty error}">
        <p class="error-message">${error}</p>
    </c:if>
</div>

</body>
</html>
