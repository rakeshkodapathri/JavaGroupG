<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Flight Booking App</title>
    <link rel = "stylesheet" href="css/index.css">
</head>
<body>

<div class="header">
    <h1>Welcome to FlyAway</h1>
    <p>Your gateway to the world's best destinations</p>
    <form class="search-form" action="FlightDetailsServlet" method="post">
        <input type="text" name="fromCity" placeholder="From" required>
        <input type="text" name="toCity" placeholder="To" required>
        <input type="date" name="departureDate" required>
        <input type="date" name="returnDate" required>
        <select name="passengers" required>
            <option value="">Passengers</option>
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
        </select>
        <button type="submit">Search Flights</button>
    </form>
</div>

<div class="container">
    <div class="testimonials">
        <h2>Customer Testimonials</h2>
        <div class="testimonial">
            <p>"FlyAway made our honeymoon trip to Paris unforgettable. The booking process was so easy!" - Jane & John</p>
        </div>
        <div class="testimonial">
            <p>"Great prices and amazing service. We will definitely use FlyAway for our next vacation." - The Smith Family</p>
        </div>
    </div>
</div>
</body>
</html>
