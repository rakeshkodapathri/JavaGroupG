<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User Registration</title>
    <link rel="stylesheet" type="text/css" href="css/register.css">
</head>
<body>
<div class="container">
    <div style="color: red;">
        <% String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) { %>
        <p><%= errorMessage %></p>
        <% } %>
    </div>

    <h2>User Registration</h2>
    <form action="RegisterServlet" method="post">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required>

        <select name="role" required>
            <option value="">Role</option>
            <option value="Admin">ADMIN</option>
            <option value="Passenger">PASSENGER</option>
        </select>

        <input type="submit" value="Register">
    </form>
    <div class="footer">
        <p>Already have an account? <a href="LoginServlet">Login</a></p>
    </div>
</div>
</body>
</html>
