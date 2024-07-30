<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.List" %>
<%@ page import="com.backend.codes.FlightManagementSystemGroupG.Flight" %>\
<%@ page import="com.google.gson.Gson" %>
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
    <a href="HomePageServlet">Home</a>
    <a style="float: right" href="LoginServlet">Log Out</a>

</div>
<div class="container">
    <div class="section">
        <h2>Available Flights</h2>
        <form action="FlightDetailsServlet" method="post">
            <label for = "noOfPassengers"> No Of Passengers </label>
            <Input name = "noOfPassengers" id = "noOfPassengers" type="text"
                   value = <%= session.getAttribute("noOfPassengers") %> readonly >
            <div class="flight-info">
                <table>
                    <tr>
                        <th></th>
                        <th>Flight Number</th>
                        <th>Airline</th>
                        <th>From</th>
                        <th>To</th>
                        <th>Departure Time</th>
                        <th>Arrival Time</th>
                        <th>Price</th>
                        <th>Date</th>
                        <th>Seats</th>
                    </tr>
                    <%
                        List<Flight> availableFlights = (List<Flight>) session.getAttribute("availableFlights");
                        for (Flight flight : availableFlights) {
                            String flightJson = new Gson().toJson(flight); // Serialize the flight object to JSON

                    %>
                    <tr>
                        <td>
                            <input type="radio" name="selectedFlight" value='<%= flightJson %>' required>
                        </td>
                        <td><%= flight.getFlightNumber() %>></td>
                        <td><%= flight.getAirline() %></td>
                        <td><%= flight.getFromCity() %></td>
                        <td><%= flight.getToCity() %></td>
                        <td><%= flight.getDepartureTime() %></td>
                        <td><%= flight.getArrivalTime() %></td>
                        <td>$<%= flight.getPrice() %></td>
                        <td><%= flight.getDepartureDate() %></td>
                        <td><%= flight.getSeats_Available() %></td>

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
