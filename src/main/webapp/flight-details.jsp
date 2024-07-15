<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.List" %>
<%@ page import="com.backend.codes.practise16june.Flight" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Available Flights - FlyAway</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .navbar {
            background-color: #333;
            overflow: hidden;
        }
        .navbar a {
            float: left;
            display: block;
            color: white;
            text-align: center;
            padding: 14px 20px;
            text-decoration: none;
        }
        .navbar a:hover {
            background-color: #ddd;
            color: black;
        }
        .container {
            width: 80%;
            margin: 20px auto;
            background-color: white;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .section {
            margin-bottom: 20px;
        }
        .section h2 {
            border-bottom: 2px solid #ddd;
            padding-bottom: 10px;
        }
        .flight-info {
            display: flex;
            justify-content: space-between;
        }
        .flight-info table {
            width: 100%;
            border-collapse: collapse;
        }
        .flight-info th, .flight-info td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        .flight-info th {
            background-color: #f2f2f2;
        }
        .button-container {
            text-align: center;
        }
        .button-container button {
            background-color: #4CAF50;
            color: white;
            padding: 14px 20px;
            border: none;
            cursor: pointer;
        }
        .button-container button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<div class="navbar">
    <a href="index.jsp">Home</a>
    <a href="search.jsp">Search Flights</a>
    <a href="booking.jsp">My Bookings</a>
    <a href="contact.jsp">Contact</a>
</div>

<div class="container">
    <div class="section">
        <h2>Available Flights</h2>
        <form action="SelectedFlightServlet" method="post">
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
