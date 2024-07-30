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
    <a href = allBookingsServlet>Bookings</a>
    <a style="float: right" href="LoginServlet">Log Out</a>
</div>

<div>
    <h1>Booking Status: Confirmed. Your booking ID is: <%= request.getParameter("bookingId") %></h1>
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
        </tr>
    </table>
    <%
        }
    %>

    <h2>Passenger Details</h2>
    <%
        List<Passenger> passengers = (List<Passenger>) session.getAttribute("passengerDetails");
        // Retrieve number of passengers from session
        Integer numPassengers = passengers.size();
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
            <% if (session.getAttribute("role").equals("ADMIN")) {%>
            <th>Update</th>
            <th>Delete</th>
            <%}%>
        </tr>
        <%
            for (int i = 0; i < passengers.size(); i++) {
                Passenger passenger = (passengers != null && passengers.size() > i) ? passengers.get(i) : null;
        %>
        <tr>
            <td><%= (passenger != null) ? passenger.getFullName() : "" %></td>
            <td><%= (passenger != null) ? passenger.getAge() : "" %></td>
            <td><%= (passenger != null) ? passenger.getPhone() : "" %></td>
            <td><%= (passenger != null) ? passenger.getEmail() : "" %></td>
            <td><%= (passenger != null) ? passenger.getPassportNum() : "" %></td>
            <td><%= (passenger != null) ? passenger.getGender() : "" %></td>
            <% if (session.getAttribute("role").equals("ADMIN")) {%>
            <td>
                <form action="updatePassenger.jsp" method="get">
                    <input type="hidden" name="fullName" value="<%= passenger.getFullName() %>">
                    <input type="hidden" name="age" value="<%= passenger.getAge() %>">
                    <input type="hidden" name="phone" value="<%= passenger.getPhone() %>">
                    <input type="hidden" name="email" value="<%= passenger.getEmail() %>">
                    <input type="hidden" name="passportNum" value="<%= passenger.getPassportNum() %>">
                    <input type="hidden" name="gender" value="<%= passenger.getGender() %>">
                    <input type = "hidden" name = "bookingId" value = "<%= request.getParameter("bookingId")%>">
                    <input type="submit" value="Update">
                </form>
            </td>
            <td>
                <form action="DeletePassengerServlet" method="post">
                    <input type="hidden" name="passportNum" value="<%= passenger.getPassportNum() %>">
                    <input type = "hidden" name = "bookingId" value = "<%= request.getParameter("bookingId")%>">
                    <input type="submit" value="Delete">
                </form>
            </td>
            <%}%>
        </tr>
        <% } %>
    </table>

<% } %>

</div>
</body>
</html>

