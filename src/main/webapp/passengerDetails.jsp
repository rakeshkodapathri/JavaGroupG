<%@ page import="com.backend.codes.practise16june.Flight" %>
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
    <a href="index.jsp">Home</a>
    <a href="flight-details.jsp"> Flights </a>
</div>

<div class="flight-details">
    <h2>Selected Flight Details</h2>
    <p>Flight Number: <%= session.getAttribute("selectedFlight") %></p>

</div>


<form action="SelectedFlightServlet" method="POST">
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
