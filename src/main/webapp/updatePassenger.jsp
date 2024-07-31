<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.backend.codes.FlightManagementSystemGroupG.Flight" %>
<%@ page import="com.backend.codes.FlightManagementSystemGroupG.Passenger" %>

<%
    String fullName = request.getParameter("fullName");
    String ageParam = request.getParameter("age");
    int age = 0;
    String phone = request.getParameter("phone");
    String email = request.getParameter("email");
    String passportNum = request.getParameter("passportNum");
    String gender = request.getParameter("gender");
    String bookingId = request.getParameter("bookingId");

    try {
        if (ageParam != null && !ageParam.isEmpty()) {
            age = Integer.parseInt(ageParam);
        } else {
            // Handle the case where age is not provided
            out.println("<p style='color:red;'>Age is required.</p>");
        }
    } catch (NumberFormatException e) {
        // Handle the case where age is not a valid integer
        out.println("<p style='color:red;'>Invalid age value. Please enter a valid number.</p>");
    }
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Passenger Details</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>

<div class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="HomePageServlet">FlyAway</a>
    <div class="collapse navbar-collapse">
        <ul class="navbar-nav ml-auto">
            <li class="nav-item">
                <a class="nav-link" href="allBookingsServlet">Bookings</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="LoginServlet">Log Out</a>
            </li>
        </ul>
    </div>
</div>

<div class="container mt-4">
    <%
        String errorMessage = (String) session.getAttribute("error");
        if (errorMessage != null) {
            out.println("<div class='alert alert-danger'>" + errorMessage + "</div>");
            session.removeAttribute("error");
        }
    %>

    <h2>Update Passenger Details</h2>
    <form action="UpdateBookingServlet" method="post">
        <div class="form-group">
            <label for="fullName">Full Name:</label>
            <input type="text" id="fullName" name="fullName" class="form-control" value="<%= fullName %>" required>
        </div>

        <div class="form-group">
            <label for="age">Age:</label>
            <input type="number" id="age" name="age" class="form-control" value="<%= age %>" required>
        </div>

        <div class="form-group">
            <label for="phone">Phone:</label>
            <input type="text" id="phone" name="phone" class="form-control" value="<%= phone %>" required>
        </div>

        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" class="form-control" value="<%= email %>" required>
        </div>

        <div class="form-group">
            <label for="passportNum">Passport Number:</label>
            <input type="text" id="passportNum" name="passportNum" class="form-control" value="<%= passportNum %>" readonly>
        </div>

        <div class="form-group">
            <label for="gender">Gender:</label>
            <select id="gender" name="gender" class="form-control" required>
                <option value="Male" <%= "Male".equals(gender) ? "selected" : "" %>>Male</option>
                <option value="Female" <%= "Female".equals(gender) ? "selected" : "" %>>Female</option>
                <option value="Other" <%= "Other".equals(gender) ? "selected" : "" %>>Other</option>
            </select>
        </div>

        <input type="hidden" id="bookingId" name="bookingId" value="<%= bookingId %>">
        <button type="submit" class="btn btn-primary">Update</button>
    </form>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>