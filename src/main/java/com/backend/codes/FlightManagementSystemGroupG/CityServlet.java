package com.backend.codes.FlightManagementSystemGroupG;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/CityServlet")
public class CityServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String query = "SELECT name FROM cities";

        try {
            Connection connection = DatabaseUtil.getConnection();
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(query);

            while (resultSet.next()) {
                String cityName = resultSet.getString("name");
                out.println("<option value=\"" + cityName + "\">" + cityName + "</option>");
            }

            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            out.close();
        }

    }
}
