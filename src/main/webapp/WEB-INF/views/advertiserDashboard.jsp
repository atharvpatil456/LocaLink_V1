<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.athar.LocaLink.model.Advertisement" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Advertiser Dashboard</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/ScrollTrigger.min.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            scroll-behavior: smooth;
        }
        body {
            background: linear-gradient(135deg, #e4e2df 0%, #cf9b58 100%);
            min-height: 100vh;
            overflow-x: hidden;
        }
        nav {
            background: white;
            padding: 1rem 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
        }
        .logo {
            font-size: 1.5rem;
            font-weight: bold;
            color: #d32f2f;
            text-decoration: none;
        }
        .logo span {
            color: #f3a024;
        }
        .nav-buttons {
            display: flex;
            gap: 1rem;
        }
        .nav-btn {
            padding: 0.8rem 1.5rem;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .nav-btn-primary {
            background: #d32f2f;
            color: white;
        }
        .nav-btn-secondary {
            border: 2px solid #d32f2f;
            color: #d32f2f;
        }
        .nav-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(211, 47, 47, 0.2);
        }
        .dashboard-container {
            margin-top: 6rem;
            padding: 2rem;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            max-width: 1200px;
            margin: 100px auto;
        }
        h2 {
            font-size: 2rem;
            color: #d32f2f;
            margin-bottom: 1.5rem;
            text-align: center;
            position: relative;
        }
        .advertisement {
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 1rem;
            text-align: center;
            box-shadow: 0 4px 15px rgb(193 81 38);
            transition: transform 0.3s;
        }
        .advertisement:hover {
            transform: translateY(-5px);
        }
        .advertisement img {
            max-width: 100%;
            height: auto;
            border-radius: 10px;
            margin-bottom: 1rem;
        }
        .action-buttons {
            margin-top: 1rem;
        }
        .btn {
            padding: 0.5rem 1rem;
            border-radius: 5px;
        }
        .table th, .table td {
            vertical-align: middle;
        }
        .table {
            margin-top: 1rem;
        }
    </style>
</head>
<body>

<!-- Navigation Bar -->
<nav>
    <a href="/advertiser/home" class="logo">Loca<span>Link</span></a>
    <div class="nav-buttons">
        <a href="/advertiser/advertisements" class="nav-btn nav-btn-secondary">My Advertisements</a>
        <a href="/advertiser/profile" class="nav-btn nav-btn-secondary">Profile</a>
        <a href="/logout" class="nav-btn nav-btn-primary">Logout</a>
    </div>
</nav>

<!-- Dashboard Content -->
<div class="dashboard-container">
    <h2>Welcome, Advertiser!</h2>
    <p>Your email: ${advertiserEmail}</p>

    <!-- Add Advertisement Button -->
    <form action="/advertiser/advertisement/addAdvertisement" method="get">
        <input type="hidden" name="advertiserEmail" value="<%= (String) request.getAttribute("advertiserEmail") %>" />
        <button type="submit" class="btn btn-primary">Add Advertisement</button>
    </form>

    <h2>Your Advertisements</h2>
    
    <div class="container">
        <div class="row">
            <!-- Loop through the advertisements -->
            <%
                List<Advertisement> advertisements = (List<Advertisement>) request.getAttribute("advertisements");
                if (advertisements != null && !advertisements.isEmpty()) {
                    for (int i = 0; i < advertisements.size(); i++) {
                        Advertisement ad = advertisements.get(i);
            %>
                        <div class="col-md-4 mb-4">
                            <div class="advertisement">
                                <h3><%= ad.getAdName() %></h3>
                                <p>Description: <%= ad.getAdDesc() %></p>
                                <p>Price: <%= ad.getAdPrice() %></p>
                                <img src="<%= ad.getImageUrl() %>" alt="Advertisement Image"/>
                                <div class="action-buttons">
                                    <!-- Update Button -->
                                    <form action="/advertisement/updateAdvertisement" method="get" style="display:inline;">
                                        <input type="hidden" name="adId" value="<%= ad.getAdId() %>" />
                                        <button type="submit" class="btn btn-success">Update</button>
                                    </form>
                                    <!-- Delete Button -->
                                    <form action="/advertisement/deleteAdvertisement" method="post" style="display:inline;">
                                        <input type="hidden" name="adId" value="<%= ad.getAdId() %>" />
                                        <button type="submit" class="btn btn-danger">Delete</button>
                                    </form>
                                </div>
                            </div>
                        </div>
            <%
                        // Close the row after every 3 advertisements
                        if ((i + 1) % 3 == 0) {
            %>
                    </div>
                    <div class="row">
            <%
                        }
                    }
                } else {
            %>
                <p>No advertisements found.</p>
            <%
                }
            %>
        </div>
    </div>
</div>

<script>
    gsap.from(".dashboard-container", {
        opacity: 0,
        y: 50,
        duration: 1,
        ease: "power3.out"
    });
</script>
</body>
</html>
