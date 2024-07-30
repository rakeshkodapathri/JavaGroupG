<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User Registration</title>
    <link rel="stylesheet" type="text/css" href="css/HomePage.css">
</head>
<body>
<div class="navbar">
    <a href="HomePageServlet">Home</a>
    <a href="allBookingsServlet">Bookings</a>
    <a style="float: right" href="LoginServlet">Log Out</a>
</div>

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

        <label for="role"> Role: </label>
        <select name="role" id = "role" required>
            <option value="Admin">ADMIN</option>
            <option value="Passenger">PASSENGER</option>
        </select>

        <input type="submit" value="Register">
    </form>
</div>
</body>
</html>
