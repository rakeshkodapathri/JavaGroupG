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
                <a class="nav-link" href="FlightDetailsServlet">Flights</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="PassengerDetailsServlet">Passenger Details</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="LoginServlet">Log Out</a>
            </li>
        </ul>
    </div>
</div>

<div class="container mt-4">
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
            <th>Seats Available</th>
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
            <td><%= flight.getSeats_Available() %></td>
        </tr>
        </tbody>
    </table>
    <%
        }
    %>

    <h2>Passenger Details</h2>
    <%
        // Retrieve number of passengers from session
        Integer numPassengers = (Integer) session.getAttribute("noOfPassengers");
        if (numPassengers == null || numPassengers == 0) {
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
        </tr>
        </thead>
        <tbody>
        <%
            // Retrieve passenger details from session if available
            List<Passenger> passengers = (List<Passenger>) session.getAttribute("passengerDetails");
            for (int i = 0; i < numPassengers; i++) {
                Passenger passenger = (passengers != null && passengers.size() > i) ? passengers.get(i) : null;
        %>
        <tr>
            <td><%= (passenger != null) ? passenger.getFullName() : "" %></td>
            <td><%= (passenger != null) ? passenger.getAge() : "" %></td>
            <td><%= (passenger != null) ? passenger.getPhone() : "" %></td>
            <td><%= (passenger != null) ? passenger.getEmail() : "" %></td>
            <td><%= (passenger != null) ? passenger.getPassportNum() : "" %></td>
            <td><%= (passenger != null) ? passenger.getGender() : "" %></td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
    <%
        }
    %>

    <form action="confirmBooking" method="post" class="mt-4">
        <input type="hidden" name="selectedFlight" value='<%= selectedFlightJson %>'>
        <button type="submit" class="btn btn-primary">Confirm Booking</button>
    </form>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
