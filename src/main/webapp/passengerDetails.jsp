<%@ page import="com.backend.codes.FlightManagementSystemGroupG.Flight" %>
<%@ page import="com.backend.codes.FlightManagementSystemGroupG.Flight" %>
<%@ page import="com.google.gson.Gson" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Flight Passenger Details</title>
    <link rel="stylesheet" href="css/passenger.css">
    <script src ="scripts/passengerDetails.js"></script>
</head>
<body onload="addPassengerFields()">

<div class="navbar">
    <a href="HomePage.jsp">Home</a>
    <a href="FlightDetailsServlet"> Flights </a>
    <a style="float: right" href="LoginServlet">Log Out</a>
</div>
<%
    // Retrieve flight details from session
    String selectedFlightJson = (String) session.getAttribute("selectedFlight");
    Gson gson = new Gson();
    Flight flight = gson.fromJson(selectedFlightJson, Flight.class);

%>

<div class="flight-details">
    <h2>Selected Flight </h2>
    <p>Flight Number: <%= flight.getFlightNumber() %></p>

</div>


<form action="PassengerDetailsServlet" method="POST">
    <label for = "numPassengers"> No Of Passengers </label>
    <Input id = "numPassengers" name = "numPassengers" type="text" value=<%= session.getAttribute("noOfPassengers") %> disabled>
    <h2>Enter Passenger Details</h2>
        <div id="passengerContainer">
            <!-- Passenger details dynamically added here -->
        </div>
    <button type="submit">Submit Details</button>
</form>
</body>
</html>
