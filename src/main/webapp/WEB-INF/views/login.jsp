<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<html>
<head>
    <title>Login</title>
</head>
<body>
    <h2>Login</h2>
    <form:form method="POST" modelAttribute="user" action="/user/login">
        <div>
            <label for="userEmail">Email:</label>
            <form:input path="userEmail" id="userEmail" required="true"/>
        </div>
        <div>
            <label for="userPassword">Password:</label>
            <form:password path="userPassword" id="userPassword" required="true"/>
        </div>
        <div>
            <button type="submit">Login</button>
        </div>
    </form:form>

    <div style="color: red;">
        <c:if test="${not empty error}">
            ${error}
        </c:if>
    </div>

    <a href="/user/register">Don't have an account? Register here</a>
</body>
</html>
