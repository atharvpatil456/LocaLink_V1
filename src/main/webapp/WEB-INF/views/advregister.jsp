<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Advertiser Registration</title>
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

        .registration-container {
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
        }

        input[type="text"],
        input[type="email"],
        input[type="password"],
        textarea {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            width: 100%;
            resize: none;
        }

        input[readonly] {
            background-color: #f0f0f0;
            color: #888;
        }

        textarea {
            height: 80px;
        }

        button, input[type="submit"] {
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }

        button:hover, input[type="submit"]:hover {
            background-color: #0056b3;
        }

        .error-message {
            color: red;
            font-size: 14px;
            margin-top: 10px;
        }

    </style>
    <script>
        function openMapPage() {
            const mapWindow = window.open("/advertiser/mapPageforadv", "Select Location", "width=800,height=600");

            // Listen for the message with the selected coordinates from mapPage.jsp
            window.addEventListener("message", function(event) {
                if (event.origin !== window.location.origin) return;
                const { latitude, longitude, address } = event.data;
                document.getElementById("latitude").value = latitude;
                document.getElementById("longitude").value = longitude;
                document.getElementById("shopAddress").value = address;
            });
        }
    </script>
</head>
<body>

<div class="registration-container">
    <h2>Register as an Advertiser</h2>
    <form action="/advertiser/advregister" method="post">
        <label for="advertiserName">Name:</label>
        <input type="text" id="advertiserName" name="advertiserName" required>

        <label for="advertiserEmail">Email:</label>
        <input type="email" id="advertiserEmail" name="advertiserEmail" required>

        <label for="advertiserPassword">Password:</label>
        <input type="password" id="advertiserPassword" name="advertiserPassword" required>

        <label for="phoneNumber">Phone Number:</label>
        <input type="text" id="phoneNumber" name="phoneNumber" required>

        <label for="shopDescription">Shop Description:</label>
        <textarea id="shopDescription" name="shopDescription" required></textarea>

        <label for="shopAddress">Shop Address:</label>
        <input type="text" id="shopAddress" name="shopAddress" readonly required>

        <label for="status">Status:</label>
        <input type="text" id="status" name="status" value="pending" readonly>

        <label for="latitude">Latitude:</label>
        <input type="text" id="latitude" name="latitude" readonly required>

        <label for="longitude">Longitude:</label>
        <input type="text" id="longitude" name="longitude" readonly required>

        <button type="button" onclick="openMapPage()">Select Location on Map</button>
        <input type="submit" value="Register">
    </form>

    <c:if test="${not empty error}">
        <p class="error-message">${error}</p>
    </c:if>
</div>

</body>
</html>
