<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Flight Passenger Details</title>
    <link rel="stylesheet" href="css/passenger.css">
    <script src ="scripts/passengerDetails.js"></script>
</head>
<body>

<div class="navbar">
    <a href="index.jsp">Home</a>
    <a href="flight-details.jsp"> Flights </a>
</div>

<div class="flight-details">
    <h2>Selected Flight Details</h2>
    <p>Flight Number: <%= request.getAttribute("selectedFlight") %></p>
</div>

<h2>Enter Passenger Details</h2>
<form action="SelectedFlightServlet" method="POST">
        <div id="passengerContainer">
            <!-- Passenger details dynamically added here -->
        </div>
    <button type="submit">Submit Details</button>
</form>
</body>
</html>
