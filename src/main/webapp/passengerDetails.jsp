<%@ page import="com.backend.codes.FlightManagementSystemGroupG.Flight" %>
<%@ page import="com.google.gson.Gson" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Flight Passenger Details</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="scripts/passengerDetails.js"></script>
</head>
<body onload="addPassengerFields()">

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="HomePage.jsp">FlyAway</a>
    <div class="collapse navbar-collapse">
        <ul class="navbar-nav ml-auto">
            <li class="nav-item">
                <a class="nav-link" href="FlightDetailsServlet">Flights</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="LoginServlet">Log Out</a>
            </li>
        </ul>
    </div>
</nav>

<div class="container mt-4">
    <%
        // Retrieve flight details from session
        String selectedFlightJson = (String) session.getAttribute("selectedFlight");
        Gson gson = new Gson();
        Flight flight = gson.fromJson(selectedFlightJson, Flight.class);
    %>

    <div class="flight-details mb-4">
        <h2>Selected Flight</h2>
        <p><strong>Flight Number:</strong> <%= flight.getFlightNumber() %></p>
    </div>

    <form action="PassengerDetailsServlet" method="POST">
        <div class="form-group">
            <label for="numPassengers">Number of Passengers</label>
            <input id="numPassengers" name="numPassengers" type="text" class="form-control" value="<%= session.getAttribute("noOfPassengers") %>" disabled>
        </div>
        <h2>Enter Passenger Details</h2>
        <div id="passengerContainer">
            <!-- Passenger details dynamically added here -->
        </div>
        <button type="submit" class="btn btn-primary mt-3">Submit Details</button>
    </form>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
