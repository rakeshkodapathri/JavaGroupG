<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.List" %>
<%@ page import="com.backend.codes.practise16june.Flight" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Available Flights - FlyAway</title>
    <link rel = "stylesheet" href="css/flightDetails.css">
</head>
<body>
<div class="navbar">
    <a href="index.jsp">Home</a>
</div>

<div class="container">
    <div class="section">
        <h2>Available Flights</h2>
        <form action="PassengerDetails" method="post">
            <div class="flight-info">
                <table>
                    <tr>
                        <th>Flight Number</th>
                        <th>Airline</th>
                        <th>From</th>
                        <th>To</th>
                        <th>Departure Time</th>
                        <th>Arrival Time</th>
                        <th>Price</th>
                    </tr>
                    <%
                        List<Flight> availableFlights = (List<Flight>) request.getAttribute("availableFlights");
                        for (Flight flight : availableFlights) {
                    %>
                    <tr>
                        <td><input type="radio" name="selectedFlight" value="<%= flight.getFlightNumber() %>" required></td>
                        <td><%= flight.getFlightNumber() %></td>
                        <td><%= flight.getAirline() %></td>
                        <td><%= flight.getFromCity() %></td>
                        <td><%= flight.getToCity() %></td>
                        <td><%= flight.getDepartureTime() %></td>
                        <td><%= flight.getArrivalTime() %></td>
                        <td>$<%= flight.getPrice() %></td>
                    </tr>
                    <%
                        }
                    %>
                </table>
            </div>
            <div class="button-container">
                <button type="submit">Select Flight</button>
            </div>
        </form>
    </div>
</div>
</body>
</html>
