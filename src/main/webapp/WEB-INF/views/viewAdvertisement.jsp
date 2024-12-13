<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Advertisements</title>
</head>
<body>
    <h2>Your Advertisements</h2>

    <c:if test="${not empty advertisements}">
        <table border="1">
            <thead>
                <tr>
                    <th>Ad Name</th>
                    <th>Description</th>
                    <th>Price</th>
                    <th>Location</th>
                    <th>Image</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="ad" items="${advertisements}">
                    <tr>
                        <td>${ad.adName}</td>
                        <td>${ad.adDesc}</td>
                        <td>${ad.adPrice}</td>
                        <td>${ad.latitude}, ${ad.longitude}</td>
                        <td><img src="${ad.imageUrl}" alt="Ad Image" width="100"></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>

    <c:if test="${empty advertisements}">
        <p>No advertisements found.</p>
    </c:if>

    <a href="${pageContext.request.contextPath}/advertisement/mapPage">Add a New Advertisement</a>
</body>
</html>
