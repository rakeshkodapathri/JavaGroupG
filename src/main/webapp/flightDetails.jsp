<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.List" %>
<%@ page import="com.backend.codes.FlightManagementSystemGroupG.Flight" %>
<%@ page import="com.google.gson.Gson" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Available Flights - FlyAway</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="HomePageServlet">FlyAway</a>
    <div class="collapse navbar-collapse">
        <ul class="navbar-nav ml-auto">
            <li class="nav-item">
                <a class="nav-link" href="LoginServlet">Log Out</a>
            </li>
        </ul>
    </div>
</div>

<div class="container mt-4">
    <div class="section">
        <h2>Available Flights</h2>
        <form action="FlightDetailsServlet" method="post">
            <div class="form-group">
                <label for="noOfPassengers">No Of Passengers</label>
                <input class="form-control" name="noOfPassengers" id="noOfPassengers" type="text"
                       value="<%= session.getAttribute("noOfPassengers") %>" readonly>
            </div>
            <div class="flight-info">
                <table class="table table-bordered">
                    <thead class="thead-light">
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
                    </thead>
                    <tbody>
                    <%
                        List<Flight> availableFlights = (List<Flight>) session.getAttribute("availableFlights");
                        if (availableFlights != null) {
                            for (Flight flight : availableFlights) {
                                String flightJson = new Gson().toJson(flight);
                    %>
                    <tr>
                        <td>
                            <input type="radio" name="selectedFlight" value='<%= flightJson %>' required>
                        </td>
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
                    <%
                        }
                    } else {
                    %>
                    <tr>
                        <td colspan="10">No available flights found.</td>
                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
            <div class="button-container mt-3">
                <button type="submit" class="btn btn-primary">Select Flight</button>
            </div>
        </form>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
