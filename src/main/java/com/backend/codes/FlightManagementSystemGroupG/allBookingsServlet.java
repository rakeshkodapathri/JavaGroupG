package com.backend.codes.FlightManagementSystemGroupG;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/allBookingsServlet")
public class allBookingsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
        }
        else{
            List<String> allBookings = new ArrayList<>();
            String query = "Select DISTINCT CONCAT(booking_Id, '-', BookedByUser)  booking from Passengers where bookedByUser = ? or 'ADMIN' = ?";
            try {
                Connection connection = DatabaseUtil.getConnection();
                PreparedStatement statement = connection.prepareStatement(query);
                statement.setString(1, session.getAttribute("user").toString());
                statement.setString(2, session.getAttribute("role").toString());
                ResultSet resultSet = statement.executeQuery();

                while (resultSet.next()) {
                    String booking = resultSet.getString("booking");
                    allBookings.add(booking);
                }
                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            session.setAttribute("allBookings", allBookings);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/allBookings.jsp");
            dispatcher.forward(request, response);
        }
        }
}
