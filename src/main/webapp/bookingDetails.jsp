<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.backend.codes.FlightManagementSystemGroupG.Flight" %>
<%@ page import="com.backend.codes.FlightManagementSystemGroupG.Passenger" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Flight and Passenger Details</title>
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
    <div class="alert alert-success" role="alert">
        Booking Status: Confirmed. Your booking ID is: <%= request.getParameter("bookingId") %>
    </div>

    <h1>Flight Details</h1>
    <%
        // Retrieve flight details from session
        String selectedFlightJson = (String) session.getAttribute("selectedFlight");
        Gson gson = new Gson();
        Flight flight = gson.fromJson(selectedFlightJson, Flight.class);

        if (flight == null) {
            out.println("<div class='alert alert-warning' role='alert'>No flight details available.</div>");
        } else {
    %>
    <table class="table table-bordered">
        <thead class="thead-light">
        <tr>
            <th>Flight Number</th>
            <th>Airline</th>
            <th>From</th>
            <th>To</th>
            <th>Departure Time</th>
            <th>Arrival Time</th>
            <th>Price</th>
            <th>Departure Date</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td><%= flight.getFlightNumber() %></td>
            <td><%= flight.getAirline() %></td>
            <td><%= flight.getFromCity() %></td>
            <td><%= flight.getToCity() %></td>
            <td><%= flight.getDepartureTime() %></td>
            <td><%= flight.getArrivalTime() %></td>
            <td>$<%= flight.getPrice() %></td>
            <td><%= flight.getDepartureDate() %></td>
        </tr>
        </tbody>
    </table>
    <%
        }
    %>

    <h2>Passenger Details</h2>
    <%
        List<Passenger> passengers = (List<Passenger>) session.getAttribute("passengerDetails");
        Integer numPassengers = (passengers != null) ? passengers.size() : 0;
        if (numPassengers == 0) {
            out.println("<div class='alert alert-warning' role='alert'>No passenger details available.</div>");
        } else {
    %>
    <table class="table table-bordered">
        <thead class="thead-light">
        <tr>
            <th>Full Name</th>
            <th>Age</th>
            <th>Phone</th>
            <th>Email</th>
            <th>Passport Number</th>
            <th>Gender</th>
            <% if ("ADMIN".equals(session.getAttribute("role"))) { %>
            <th>Update</th>
            <th>Delete</th>
            <% } %>
        </tr>
        </thead>
        <tbody>
        <%
            for (Passenger passenger : passengers) {
        %>
        <tr>
            <td><%= passenger.getFullName() %></td>
            <td><%= passenger.getAge() %></td>
            <td><%= passenger.getPhone() %></td>
            <td><%= passenger.getEmail() %></td>
            <td><%= passenger.getPassportNum() %></td>
            <td><%= passenger.getGender() %></td>
            <% if ("ADMIN".equals(session.getAttribute("role"))) { %>
            <td>
                <form action="updatePassenger.jsp" method="get">
                    <input type="hidden" name="fullName" value="<%= passenger.getFullName() %>">
                    <input type="hidden" name="age" value="<%= passenger.getAge() %>">
                    <input type="hidden" name="phone" value="<%= passenger.getPhone() %>">
                    <input type="hidden" name="email" value="<%= passenger.getEmail() %>">
                    <input type="hidden" name="passportNum" value="<%= passenger.getPassportNum() %>">
                    <input type="hidden" name="gender" value="<%= passenger.getGender() %>">
                    <input type="hidden" name="bookingId" value="<%= request.getParameter("bookingId") %>">
                    <button type="submit" class="btn btn-warning btn-sm">Update</button>
                </form>
            </td>
            <td>
                <form action="DeletePassengerServlet" method="post">
                    <input type="hidden" name="passportNum" value="<%= passenger.getPassportNum() %>">
                    <input type="hidden" name="bookingId" value="<%= request.getParameter("bookingId") %>">
                    <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                </form>
            </td>
            <% } %>
        </tr>
        <% } %>
        </tbody>
    </table>
    <% } %>
</div>
<!-- Add this section to your existing JSP file -->

<div class="container mt-4">
    <a href="DownloadPdfServlet" class="btn btn-primary">Download PDF</a>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
