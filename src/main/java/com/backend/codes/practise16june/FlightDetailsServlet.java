package com.backend.codes.practise16june;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;

@WebServlet("/FlightDetailsServlet")
public class FlightDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fromCity = request.getParameter("fromCity");
        String toCity = request.getParameter("toCity");
        String departureDate = request.getParameter("departureDate");

        List<Flight> availableFlights = getAvailableFlights(fromCity, toCity, departureDate);

        request.setAttribute("availableFlights", availableFlights);
        request.setAttribute("fromCity", fromCity);
        request.setAttribute("toCity", toCity);
        request.setAttribute("departureDate", departureDate);

        RequestDispatcher dispatcher = request.getRequestDispatcher("flight-details.jsp");
        dispatcher.forward(request, response);
    }

    private List<Flight> getAvailableFlights(String fromCity, String toCity, String departureDate) {
        List<Flight> flights = new ArrayList<>();
        String jdbcURL = "jdbc:mysql://localhost:3306/ebookShop";
        String dbUser = "root";
        String dbPassword = "Raki@230";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
            String sql = "SELECT * FROM flights WHERE from_city = ? AND to_city = ? AND departure_time >= ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, fromCity);
            statement.setString(2, toCity);
            statement.setString(3, departureDate);

            Flight flight2 = new Flight();
            flight2.setFlightNumber("234");
            flight2.setAirline(departureDate);
            flight2.setFromCity(fromCity);
            flight2.setToCity(toCity);
            flight2.setPrice(12.00);

            flights.add(flight2);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                Flight flight = new Flight();
                flight.setFlightNumber(resultSet.getString("flight_number"));
                flight.setAirline(resultSet.getString("airline"));
                flight.setFromCity(resultSet.getString("from_city"));
                flight.setToCity(resultSet.getString("to_city"));
                flight.setDepartureTime(resultSet.getTime("departure_time"));
                flight.setArrivalTime(resultSet.getTime("arrival_time"));
                flight.setPrice(resultSet.getDouble("price"));

                flights.add(flight);
            }

            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return flights;
    }
}
