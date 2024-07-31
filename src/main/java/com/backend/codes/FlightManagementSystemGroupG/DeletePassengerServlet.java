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

@WebServlet("/DeletePassengerServlet")

public class DeletePassengerServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null) {
            response.sendRedirect("LoginServlet");
        }
        else{
            String bookingId = request.getParameter("bookingId");
            String passportNum = request.getParameter("passportNum");
            PreparedStatement pstmt = null;

            try {
                Connection conn = DatabaseUtil.getConnection();
                String sql = "Delete From passengers WHERE Passportnum=? and booking_Id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, passportNum);
                pstmt.setString(2, bookingId);

                int rowsUpdated = pstmt.executeUpdate();
                if (rowsUpdated > 0) {
                    response.sendRedirect("confirmBooking?bookingId=" + bookingId);
                } else {
                    session.setAttribute("error", "No such passenger found with the provided details.");
                    response.sendRedirect("bookingDetails.jsp");
                }
                if (conn != null) conn.close();
            } catch (ClassNotFoundException | SQLException e) {
                Logger.log(e.getMessage());
                session.setAttribute("error", "Error updating passenger details: " + e.getMessage());
                response.sendRedirect("bookingDetails.jsp");
            } finally {
                try {
                    if (pstmt != null) pstmt.close();
                } catch (SQLException e) {
                    Logger.log(e.getMessage());
                }
            }
        }


    }
}
