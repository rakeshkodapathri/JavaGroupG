<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Flight Booking App</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
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
            padding: 20px;
        }
        .header {
            background-image: url('flight.jpeg');
            background-size: cover;
            padding: 100px;
            text-align: center;
            color: white;
        }
        .header h1 {
            font-size: 50px;
        }
        .search-form {
            margin: 20px 0;
        }
        .search-form input, .search-form select {
            padding: 10px;
            margin: 5px;
            width: 200px;
        }
        .featured, .testimonials {
            margin: 20px 0;
        }
        .featured h2, .testimonials h2 {
            text-align: center;
        }
        .featured .destination, .testimonials .testimonial {
            margin: 10px 0;
        }
    </style>
    <script>
        function loadCities() {
            fetch('getCities')
                .then(response => response.text())
                .then(data => {
                    document.getElementById('fromCity').innerHTML = data;
                })
                .catch(error => console.error('Error loading cities:', error));
        }

        window.onload = loadCities;
    </script>
</head>
<body>
<div class="navbar">
    <a href="#home">Home</a>
    <a href="#flights">Flights</a>
    <a href="#destinations">Destinations</a>
    <a href="#contact">Contact</a>
</div>

<div class="header">
    <h1>Welcome to FlyAway</h1>
    <p>Your gateway to the world's best destinations</p>
    <form class="search-form" action="FlightDetailsServlet" method="post">
<%--        <select id="fromCity" name="fromCity" required>--%>
<%--            <option value="">Loading...</option>--%>
<%--        </select>--%>
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
