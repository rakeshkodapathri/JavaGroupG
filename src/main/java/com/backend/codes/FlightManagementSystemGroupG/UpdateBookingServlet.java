package com.backend.codes.FlightManagementSystemGroupG;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/UpdateBookingServlet")
public class UpdateBookingServlet extends HttpServlet {
    // Database connection parameters

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String fullName = request.getParameter("fullName");
        String ageStr = request.getParameter("age");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String passportNum = request.getParameter("passportNum");
        String gender = request.getParameter("gender");
        String bookingID = request.getParameter("bookingId");

        int age = 0;
        boolean valid = true;

        try {
            age = Integer.parseInt(ageStr);
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid age value. Please enter a valid number.");
            valid = false;
        }

        if (valid) {
            PreparedStatement pstmt = null;
            try {
                Connection conn = DatabaseUtil.getConnection();
                String sql = "UPDATE passengers SET fullName=?, age=?, phone=?, email=?, gender=? WHERE Passportnum=? and booking_Id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, fullName);
                pstmt.setInt(2, age);
                pstmt.setString(3, phone);
                pstmt.setString(4, email);
                pstmt.setString(5, gender);
                pstmt.setString(6, passportNum);
                pstmt.setString(7, bookingID);

                int rowsUpdated = pstmt.executeUpdate();
                if (rowsUpdated > 0) {
                    response.sendRedirect("confirmBooking?bookingId=" + bookingID);
                } else {
                    session.setAttribute("error", "No such passenger found with the provided details.");
                    response.sendRedirect("updatePassenger.jsp");
                }
                if (conn != null) conn.close();
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
                session.setAttribute("error", "Error updating passenger details: " + e.getMessage());
                response.sendRedirect("updatePassenger.jsp");
            } finally {
                try {
                    if (pstmt != null) pstmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        } else {
            response.sendRedirect("updatePassenger.jsp");
        }
    }
}
