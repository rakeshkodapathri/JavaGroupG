package com.backend.codes.practise16june;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;


@WebServlet("/getCities")
public class CityServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try (Connection conn = DatabaseUtil.getConnection()) {
                String query = "SELECT name FROM cities";
                try (PreparedStatement stmt = conn.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {
                    out.println("<option value=''>Select City</option>");
                    while (rs.next()) {
                        out.println("<option value='" + rs.getString("name") + "'>" + rs.getString("name") + "</option>");
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fromCity = request.getParameter("fromCity");
        String toCity = request.getParameter("toCity");
        String departureDate = request.getParameter("departureDate");
        String returnDate = request.getParameter("returnDate");
        String passengers = request.getParameter("passengers");

        request.setAttribute("fromCity", fromCity);
        request.setAttribute("toCity", toCity);
        request.setAttribute("departureDate", departureDate);
        request.setAttribute("returnDate", returnDate);
        request.setAttribute("passengers", passengers);

        RequestDispatcher dispatcher = request.getRequestDispatcher("booking.jsp");
        dispatcher.forward(request, response);
    }
}
