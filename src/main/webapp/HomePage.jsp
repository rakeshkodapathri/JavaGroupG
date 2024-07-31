<%@ page import="java.util.Enumeration" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.InputStreamReader" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Flight Booking App - FlyAway</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="HomePage.jsp">FlyAway</a>
    <div class="collapse navbar-collapse">
        <ul class="navbar-nav ml-auto">
            <li class="nav-item">
                <a class="nav-link" href="allBookingsServlet">Bookings</a>
            </li>
            <% if ("ADMIN".equals(session.getAttribute("role"))) { %>
            <li class="nav-item">
                <a class="nav-link" href="RegisterServlet">Register User</a>
            </li>
            <% } %>
            <li class="nav-item">
                <a class="nav-link" href="LoginServlet">Log Out</a>
            </li>
        </ul>
    </div>
</nav>

<%
    // Remove all session attributes except specific ones
    Enumeration<String> attributeNames = session.getAttributeNames();
    while (attributeNames.hasMoreElements()) {
        String attributeName = attributeNames.nextElement();
        if (!("user".equals(attributeName) || "token".equals(attributeName) || "role".equals(attributeName))) {
            session.removeAttribute(attributeName);
        }
    }
%>

<header class="bg-primary text-white text-center py-5 mb-4">
    <div class="container">
        <h1 class="font-weight-light">Welcome to FlyAway</h1>
        <p class="lead">Your gateway to the world's best destinations</p>
    </div>
</header>

<div class="container mb-4">
    <form class="row g-3" action="HomePageServlet" method="post">
        <div class="col-md-3">
            <label for="fromCity" class="form-label">From</label>
            <select name="fromCity" id="fromCity" class="form-select" required>
                <option value="" selected>Select City</option>
                <%
                    try {
                        URL url = new URL("http://localhost:8080/FlightManagementSystemGroupG_war_exploded/CityServlet");
                        BufferedReader in = new BufferedReader(new InputStreamReader(url.openStream()));
                        String inputLine;
                        while ((inputLine = in.readLine()) != null) {
                            out.println(inputLine);
                        }
                        in.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                %>
            </select>
        </div>
        <div class="col-md-3">
            <label for="toCity" class="form-label">To</label>
            <select name="toCity" id="toCity" class="form-select" required>
                <option value="" selected>Select City</option>
                <%
                    try {
                        URL url = new URL("http://localhost:8080/FlightManagementSystemGroupG_war_exploded/CityServlet");
                        BufferedReader in = new BufferedReader(new InputStreamReader(url.openStream()));
                        String inputLine;
                        while ((inputLine = in.readLine()) != null) {
                            out.println(inputLine);
                        }
                        in.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                %>
            </select>
        </div>
        <div class="col-md-3">
            <label for="departureStart" class="form-label">Departure Start</label>
            <input type="date" name="departureStart" id="departureStart" class="form-control" required>
        </div>
        <div class="col-md-3">
            <label for="departureEnd" class="form-label">Departure End</label>
            <input type="date" name="departureEnd" id="departureEnd" class="form-control" required>
        </div>
        <div class="col-md-3 mt-3">
            <label for="passengers" class="form-label">Passengers</label>
            <select name="passengers" id="passengers" class="form-select" required>
                <option value="" selected>Select Number</option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
            </select>
        </div>
        <div class="col-md-12 mt-3 text-center">
            <button type="submit" class="btn btn-primary">Search Flights</button>
        </div>
    </form>
</div>

<div class="container mb-4">
    <h2 class="text-center">Customer Testimonials</h2>
    <div class="card-deck">
        <div class="card">
            <div class="card-body">
                <p class="card-text">"FlyAway made our honeymoon trip to Paris unforgettable. The booking process was so easy!"</p>
                <footer class="blockquote-footer">Jane & John</footer>
            </div>
        </div>
        <div class="card">
            <div class="card-body">
                <p class="card-text">"Great prices and amazing service. We will definitely use FlyAway for our next vacation."</p>
                <footer class="blockquote-footer">The Smith Family</footer>
            </div>
        </div>
        <div class="card">
            <div class="card-body">
                <p class="card-text">"Excellent customer service and smooth booking experience. Highly recommended!"</p>
                <footer class="blockquote-footer">Michael Lee</footer>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
