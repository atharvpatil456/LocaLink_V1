<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<html>
<head>
    <title>Register</title>
</head>
<body>
    <h2>Register</h2>
    <form:form method="POST" modelAttribute="user" action="/user/register">
        <div>
            <label for="userName">Name:</label>
            <form:input path="userName" id="userName" required="true"/>
        </div>
        <div>
            <label for="userEmail">Email:</label>
            <form:input path="userEmail" id="userEmail" required="true"/>
        </div>
        <div>
            <label for="userNumber">Phone Number:</label>
            <form:input path="userNumber" id="userNumber" required="true"/>
        </div>
        <div>
            <label for="userPassword">Password:</label>
            <form:password path="userPassword" id="userPassword" required="true"/>
        </div>
        <div>
            <button type="submit">Register</button>
        </div>
    </form:form>

    <div style="color: red;">
        <c:if test="${not empty error}">
            ${error}
        </c:if>
    </div>

    <a href="/user/login">Already have an account? Login here</a>
</body>
</html>
