<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Flight Details - FlyAway</title>
    <link rel="stylesheet" href="css/booking.css">
</head>
<body>
<div class="navbar">
    <a href="index.jsp">Home</a>
    <a href="flight-details.jsp">Flights</a>
    <a href="passengerDetails.jsp">Passenger</a>
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
                        <td><%= request.getAttribute("selectedFlight") %></td>
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
                        <td><%= request.getAttribute("name") %></td>
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
