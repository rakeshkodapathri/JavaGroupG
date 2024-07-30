<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Collections" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>All Bookings</title>
    <link rel="stylesheet" href="css/booking.css">
</head>
<body>
<div class="navbar">
    <a href="HomePage.jsp">Home</a>
    <a style="float: right" href="LoginServlet">Log Out</a>
</div>
<div>
    <!-- Search Form -->
    <form method="get" action="allBookings.jsp">
        <div style="padding: 20px">
            <%
                String search = request.getParameter("search");
            %>
            <input type="text" name="search" placeholder="Enter Booking ID"
                   value="<%= (search != null) ? search : "Enter Booking ID" %>">
            <button type="submit">Search</button>
        </div>
    </form>

    <table>
        <tr>
            <th> Booking Id </th>
            <th> Booked By </th>
            <th> View Booking </th>
        </tr>
        <%
            List<String> allBookings = (List<String>) session.getAttribute("allBookings");
            if (allBookings != null) {
                for (String booking : allBookings) {
                    if (search == null || search.isEmpty() || booking.contains(search)) {
                        String[] parts = booking.split("-");
                        if (parts.length >= 2) {
                            String booking_id = parts[0].trim();
                            String bookedByUser = parts[1].trim();
        %>
        <tr>
            <td><%= booking_id %></td>
            <td><%= bookedByUser %></td>
            <td><a href="confirmBooking?bookingId=<%= booking_id %>">Click Here</a></td>
        </tr>
        <%
                        }
                        else {
                            // Handle the case where the split did not result in two parts
                            // You can log an error, skip this entry, or display a default value
                            out.println("<tr><td colspan='2'>Invalid booking format: " + booking + "</td></tr>");
                        }
                    }
                }
            }
        %>
    </table>
</div>
</body>
</html>
