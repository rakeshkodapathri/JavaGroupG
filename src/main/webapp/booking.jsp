<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Flight Details - FlyAway</title>
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
        .flight-info, .passenger-info, .booking-summary {
            display: flex;
            justify-content: space-between;
        }
        .flight-info div, .passenger-info div, .booking-summary div {
            width: 48%;
        }
        .flight-info table, .passenger-info table, .booking-summary table {
            width: 100%;
            border-collapse: collapse;
        }
        .flight-info th, .passenger-info th, .booking-summary th,
        .flight-info td, .passenger-info td, .booking-summary td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        .flight-info th, .passenger-info th, .booking-summary th {
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
    <a href="bookings.jsp">My Bookings</a>
    <a href="contact.jsp">Contact</a>
</div>

<div class="container">
    <div class="section">
        <h2>Flight Information</h2>
        <div class="flight-info">
            <div>
                <table>
                    <tr>
                        <th>From</th>
                        <td><%= request.getAttribute("fromCity") %></td>
                    </tr>
                    <tr>
                        <th>To</th>
                        <td><%= request.getAttribute("toCity") %></td>
                    </tr>
                    <tr>
                        <th>Departure Date</th>
                        <td><%= request.getAttribute("departureDate") %></td>
                    </tr>
                    <tr>
                        <th>Return Date</th>
                        <td><%= request.getAttribute("returnDate") %></td>
                    </tr>
                </table>
            </div>
            <div>
                <table>
                    <tr>
                        <th>Airline</th>
                        <td>FlyAway Airlines</td>
                    </tr>
                    <tr>
                        <th>Flight Number</th>
                        <td>FL123</td>
                    </tr>
                    <tr>
                        <th>Class</th>
                        <td>Economy</td>
                    </tr>
                    <tr>
                        <th>Passengers</th>
                        <td><%= request.getAttribute("passengers") %></td>
                    </tr>
                </table>
            </div>
        </div>
    </div>

    <div class="section">
        <h2>Passenger Details</h2>
        <div class="passenger-info">
            <div>
                <table>
                    <tr>
                        <th>Passenger Name</th>
                        <td>John Doe</td>
                    </tr>
                    <tr>
                        <th>Email</th>
                        <td>john.doe@example.com</td>
                    </tr>
                </table>
            </div>
            <div>
                <table>
                    <tr>
                        <th>Phone</th>
                        <td>+1 234 567 890</td>
                    </tr>
                    <tr>
                        <th>Seat</th>
                        <td>12A</td>
                    </tr>
                </table>
            </div>
        </div>
    </div>

    <div class="section">
        <h2>Booking Summary</h2>
        <div class="booking-summary">
            <div>
                <table>
                    <tr>
                        <th>Total Price</th>
                        <td>$350</td>
                    </tr>
                    <tr>
                        <th>Taxes & Fees</th>
                        <td>$50</td>
                    </tr>
                </table>
            </div>
            <div>
                <table>
                    <tr>
                        <th>Grand Total</th>
                        <td>$400</td>
                    </tr>
                </table>
            </div>
        </div>
    </div>

    <div class="button-container">
        <button type="button" onclick="confirmBooking()">Confirm Booking</button>
    </div>
</div>

<script>
    function confirmBooking() {
        alert("Your booking has been confirmed!");
    }
</script>
</body>
</html>
