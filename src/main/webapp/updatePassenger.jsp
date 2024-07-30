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
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Passenger Details</title>
    <link rel="stylesheet" href="css/updatePasenger.css">

</head>
<body>

<div class="navbar">
    <a href="HomePageServlet">Home</a>
    <a href = allBookingsServlet>Bookings</a>
    <a style="float: right" href="LoginServlet">Log Out</a>
</div>

<%
    String errorMessage = (String) session.getAttribute("error");
    if (errorMessage != null) {
        out.println("<p style='color:red;'>" + errorMessage + "</p>");
        session.removeAttribute("error");
    }
%>

<div class="form-container">
    <h2>Update Passenger Details</h2>
    <form action="UpdateBookingServlet" method="post">
        <label for="fullName">Full Name:</label>
        <input type="text" id="fullName" name="fullName" value="<%= fullName %>" required><br>

        <label for="age">Age:</label>
        <input type="number" id="age" name="age" value="<%= age %>" required><br>

        <label for="phone">Phone:</label>
        <input type="text" id="phone" name="phone" value="<%= phone %>" required><br>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" value="<%= email %>" required><br>

        <label for="passportNum">Passport Number:</label>
        <input type="text" id="passportNum" name="passportNum" value="<%= passportNum %>" readonly><br>

        <label for="gender">Gender:</label>
        <select id="gender" name="gender" required>
            <option value="Male" <%= "Male".equals(gender) ? "selected" : "" %>>Male</option>
            <option value="Female" <%= "Female".equals(gender) ? "selected" : "" %>>Female</option>
            <option value="Other" <%= "Other".equals(gender) ? "selected" : "" %>>Other</option>
        </select><br>

        <input type ="hidden" id = "bookingId" name = "bookingId" value=<%= bookingId %>>
        <input type="submit" value="Update">
    </form>
</div>
</body>
</html>
