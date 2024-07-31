package com.backend.codes.FlightManagementSystemGroupG;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.http.HttpSession;


@WebServlet(name = "RegisterServlet", value = "/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        if (username == null || email == null || password == null || username.isEmpty() || email.isEmpty() || password.isEmpty()) {
            request.setAttribute("errorMessage", "All fields are required.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
            dispatcher.forward(request, response);
            return;
        }
        String hashedPassword = Integer.toString(password.hashCode());

        try (Connection connection = DatabaseUtil.getConnection()) {
            String sql = "INSERT INTO User (email, username, password, role) VALUES (?, ?, ?, ?)";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, email);
                statement.setString(2, username);
                statement.setString(3, hashedPassword);
                statement.setString(4, role);
                int rowsInserted = statement.executeUpdate();
                if (rowsInserted > 0) {
                    // Set success message in session and redirect to login page
                    HttpSession session = request.getSession();
                    session.setAttribute("successMessage", "Registration successful! Please log in.");
                    response.sendRedirect("login.jsp");
                } else {
                    // Set error message in request and forward back to register page
                    request.setAttribute("errorMessage", "Registration failed. Please try again.");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
                    dispatcher.forward(request, response);
                }
            }
        } catch (SQLException e) {
            Logger.log(e.getMessage());
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
            dispatcher.forward(request, response);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }



}
