<%@ page import="java.util.List" %>
<%@ page import="com.athar.LocaLink.model.Advertiser" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - LocaLink</title>
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
        .container {
            margin-top: 6rem !important;
            padding: 2rem;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            max-width: 800px;
        }
        h2 {
            font-size: 2rem;
            color: #d32f2f;
            margin-bottom: 1.5rem;
            text-align: center;
            position: relative;
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
        .mt-5, .my-5 {
    margin-top: 6rem !important;
}
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav>
        <a href="/" class="logo">Loca<span>Link</span></a>
        <div class="nav-buttons">
            <a href="/admin/login" class="nav-btn nav-btn-secondary">Admin Login</a>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container mt-5">
        <h2>Admin Dashboard</h2>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Email</th>
                    <th>Name</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Advertiser> advertisers = (List<Advertiser>) request.getAttribute("advertisers");
                    if (advertisers != null && !advertisers.isEmpty()) {
                        for (Advertiser advertiser : advertisers) {
                %>
                    <tr>
                        <td><%= advertiser.getAdvertiserEmail() %></td>
                        <td><%= advertiser.getAdvertiserName() %></td>
                        <td><%= advertiser.getStatus() %></td>
                        <td>
                            <form action="/admin/updateStatus" method="post" style="display:inline;">
                                <input type="hidden" name="advertiserId" value="<%= advertiser.getAdvertiserId() %>">
                                <select name="status" class="form-control d-inline" style="width: 150px; display:inline;">
                                    <option value="approved" <%= advertiser.getStatus().equals("approved") ? "selected" : "" %>>Approve</option>
                                    <option value="rejected" <%= advertiser.getStatus().equals("rejected") ? "selected" : "" %>>Reject</option>
                                </select>
                                <input type="submit" value="Update" class="btn btn-primary btn-sm">
                            </form>
                        </td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="4" class="text-center">No advertisers found.</td>
                    </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        gsap.from(".container", {
            opacity: 0,
            y: 50,
            duration: 1,
            ease: "power3.out"
        });
    </script>
</body>
</html>
