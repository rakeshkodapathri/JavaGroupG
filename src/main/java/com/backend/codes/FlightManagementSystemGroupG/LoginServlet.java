package com.backend.codes.FlightManagementSystemGroupG;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "LoginServlet", value = "/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(DatabaseUtil.class.getName());
    private static final String SECRET_KEY = "qwerty12345";
    private final Gson gson = new Gson();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.setAttribute("username", "");
        session.setAttribute("role", "");
        session.setAttribute("token", "");
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        StringBuilder jsonBuffer = new StringBuilder();
        String line;

        try (BufferedReader reader = request.getReader()) {
            while ((line = reader.readLine()) != null) {
                jsonBuffer.append(line);
            }
        }

        JsonObject jsonObject = gson.fromJson(jsonBuffer.toString(), JsonObject.class);
        String email = jsonObject.get("email").getAsString();
        String password = jsonObject.get("password").getAsString();
        String hashedPassword = Integer.toString(password.hashCode());

        logger.log(Level.SEVERE, "email: " + email);

        try (Connection connection = DatabaseUtil.getConnection()) {
            String sql = "SELECT * FROM User WHERE email = ? AND password = ?";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, email);
                statement.setString(2, hashedPassword);
                ResultSet resultSet = statement.executeQuery();

                if (resultSet.next()) {
                    String token = generateToken(resultSet.getString("email"));
                    HttpSession session = request.getSession(true);
                    session.setAttribute("token", token);
                    session.setAttribute("user", resultSet.getString("username"));
                    session.setAttribute("role",resultSet.getString("role"));
                    logger.log(Level.SEVERE, "token " + token);

                    response.setContentType("application/json");
                    response.getWriter().println("{\"token\": \"" + token + "\"}");
                } else {
                    response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                    response.getWriter().println("Invalid email or password.");
                }
            }
        } catch (SQLException e) {
//            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

//        RequestDispatcher dispatcher = request.getRequestDispatcher("HomePage.jsp");
//        dispatcher.forward(request, response);
    }

    private String generateToken(String email) {
        logger.log(Level.SEVERE, "email: in token " + email);
        return Jwts.builder()
                .setSubject(email)
                .signWith(SignatureAlgorithm.HS256, SECRET_KEY)
                .compact();
    }
}
