<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.util.Enumeration" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Flight Booking App</title>
    <link rel = "stylesheet" href="css/HomePage.css">
</head>
<body>

<div class="navbar">
    <a href="HomePage.jsp">Home</a>
    <a href="allBookingsServlet">Bookings</a>
    <% if (session.getAttribute("role").equals("ADMIN")) {%>
        <a href ="RegisterServlet" > Register User</a>
    <%}%>
    <a style="float: right" href="LoginServlet">Log Out</a>
</div>

<%
    // Remove all session attributes
    Enumeration<String> attributeNames = session.getAttributeNames();
    while (attributeNames.hasMoreElements()) {
        String attributeName = attributeNames.nextElement();
        if (!(attributeName.equals("user") || attributeName.equals("token") || attributeName.equals("role"))) {
            session.removeAttribute(attributeName);
        }
    }
%>

<div class="header">
    <h1>Welcome to FlyAway</h1>
    <p>Your gateway to the world's best destinations</p>
    <form class="search-form" action="HomePageServlet" method="post">
        <%--        <input type="text" name="fromCity" placeholder="From" required>--%>
        <select name="fromCity" required>
            <option value="">From</option>
            <%
                // Use a servlet to get city data from the database
                try {
                    URL url = new URL("http://localhost:8080/FlightManagementSystemGroupG_war_exploded/CityServlet");
                    BufferedReader in = new BufferedReader(new InputStreamReader(url.openStream()));
                    String inputLine;
                    while ((inputLine = in.readLine()) != null) {
                        out.println(inputLine);
                    }
                    in.close();
                } catch (IOException e) {
                    // Handle exception, e.g., log it or print an error message
                    e.printStackTrace();
                }
            %>
        </select>

        <select name="toCity" required>
            <option value="">To</option>
            <%
                // Use a servlet to get city data from the database
                try {
                    URL url = new URL("http://localhost:8080/FlightManagementSystemGroupG_war_exploded/CityServlet");
                    BufferedReader in = new BufferedReader(new InputStreamReader(url.openStream()));
                    String inputLine;
                    while ((inputLine = in.readLine()) != null) {
                        out.println(inputLine);
                    }
                    in.close();
                } catch (IOException e) {
                    // Handle exception, e.g., log it or print an error message
                    e.printStackTrace();
                }
            %>
        </select>

        <input type="date" name="departureStart" required>
        <input type="date" name="departureEnd" required>

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
