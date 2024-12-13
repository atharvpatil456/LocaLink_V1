<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home Page</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .home-container {
            text-align: center;
        }
        h1 {
            color: #333;
            margin-bottom: 50px;
        }
        .home-button {
            display: inline-block;
            background-color: #007bff;
            color: white;
            padding: 20px 40px;
            margin: 20px;
            border: none;
            border-radius: 5px;
            font-size: 18px;
            cursor: pointer;
            width: 200px;
            text-align: center;
        }
        .home-button:hover {
            background-color: #0056b3;
        }
        a {
            text-decoration: none;
            color: white;
        }
    </style>
</head>
<body>

<div class="home-container">
    <h1>Welcome to the Portal</h1>
    <button class="home-button"><a href="/advertiser/advlogin">Advertiser</a></button>
    <button class="home-button"><a href="/admin/adminlogin">Admin</a></button>
</div>

</body>
</html>
