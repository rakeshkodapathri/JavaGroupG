<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.backend.codes.FlightManagementSystemGroupG.Flight" %>
<%@ page import="com.backend.codes.FlightManagementSystemGroupG.Passenger" %>
<!DOCTYPE html>
<html>
<head>
    <title>Flight and Passenger Details</title>
    <link rel="stylesheet" href="css/booking.css">
</head>
<body>

<div class="navbar">
    <a href="HomePageServlet">Home</a>
    <a href="FlightDetailsServlet"> Flights </a>
    <a href="PassengerDetailsServlet"> Passenger Details </a>
    <a style="float: right" href="LoginServlet">Log Out</a>
</div>

<div class="container">
    <h1>Flight Details</h1>
    <%
        // Retrieve flight details from session
        String selectedFlightJson = (String) session.getAttribute("selectedFlight");
        Gson gson = new Gson();
        Flight flight = gson.fromJson(selectedFlightJson, Flight.class);

        if (flight == null) {
            out.println("<p>No flight details available.</p>");
        } else {
    %>
    <table>
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
    </table>
    <%
        }
    %>

    <h2>Passenger Details</h2>
    <%
        // Retrieve number of passengers from session
        Integer numPassengers = (Integer) session.getAttribute("noOfPassengers");
        if (numPassengers == null || numPassengers == 0) {
            out.println("<p>No passenger details available.</p>");
        } else {
    %>
    <table>
        <tr>
            <th>Full Name</th>
            <th>Age</th>
            <th>Phone</th>
            <th>Email</th>
            <th>Passport Number</th>
            <th>Gender</th>
        </tr>
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
    </table>
    <%
        }
    %>
    <form action="confirmBooking" method="post">
        <input type="hidden" name="selectedFlight" value='<%= selectedFlightJson %>'>
        <input type="submit" value="Confirm Booking">
    </form>
</div>
</body>
</html>

