<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Collections" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Bookings</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>

<%
    String search = request.getParameter("search");
%>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="HomePage.jsp">FlyAway</a>
    <div class="collapse navbar-collapse">
        <ul class="navbar-nav ml-auto">
            <li class="nav-item">
                <a class="nav-link" href="LoginServlet">Log Out</a>
            </li>
        </ul>
    </div>
</nav>

<div class="container mt-4">
    <!-- Search Form -->
    <form method="get" action="allBookings.jsp" class="mb-4">
        <div class="form-group">
            <label for="search">Search Booking ID</label>
            <input type="text" id="search" name="search" class="form-control" placeholder="Enter Booking ID"
                   value="<%= (search != null) ? search : "" %>">
        </div>
        <button type="submit" class="btn btn-primary">Search</button>
    </form>

    <table class="table table-striped">
        <thead>
        <tr>
            <th>Booking Id</th>
            <th>Booked By</th>
            <th>View Booking</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<String> allBookings = (List<String>) session.getAttribute("allBookings");
            if (allBookings != null) {
                boolean foundResults = false;
                for (String booking : allBookings) {
                    if (search == null || search.isEmpty() || booking.contains(search)) {
                        String[] parts = booking.split("-");
                        if (parts.length >= 2) {
                            String booking_id = parts[0].trim();
                            String bookedByUser = parts[1].trim();
                            foundResults = true;
        %>
        <tr>
            <td><%= booking_id %></td>
            <td><%= bookedByUser %></td>
            <td><a href="confirmBooking?bookingId=<%= booking_id %>" class="btn btn-info">View</a></td>
        </tr>
        <%
                    } else {
                        out.println("<tr><td colspan='3' class='text-danger'>Invalid booking format: " + booking + "</td></tr>");
                    }
                }
            }
            if (!foundResults) {
        %>
        <tr>
            <td colspan="3" class="text-center">No bookings found.</td>
        </tr>
        <%
                }
            }
        %>
        </tbody>
    </table>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
