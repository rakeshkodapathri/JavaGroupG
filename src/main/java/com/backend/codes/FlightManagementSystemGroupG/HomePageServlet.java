package com.backend.codes.FlightManagementSystemGroupG;

import java.io.IOException;
import java.sql.Connection;
import java.text.SimpleDateFormat;
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
import jakarta.servlet.http.HttpSession;

@WebServlet("/HomePageServlet")
public class HomePageServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("HomePage.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
        }
        else{
            String fromCity = request.getParameter("fromCity");
            String toCity = request.getParameter("toCity");
            String departureStart = request.getParameter("departureStart");
            String departureEnd = request.getParameter("departureEnd");
            Integer noOfPassengers = Integer.parseInt(request.getParameter("passengers"));

            session.setAttribute("fromCity", fromCity);
            session.setAttribute("toCity", toCity);
            session.setAttribute("departureStart", departureStart);
            session.setAttribute("departureEnd", departureEnd);
            session.setAttribute("noOfPassengers", noOfPassengers);

            List<Flight> availableFlights = getAvailableFlights(fromCity, toCity, departureStart, departureEnd,noOfPassengers);

            session.setAttribute("availableFlights", availableFlights);

            RequestDispatcher dispatcher = request.getRequestDispatcher("flightDetails.jsp");
            dispatcher.forward(request, response);
        }
    }

    private List<Flight> getAvailableFlights(String fromCity, String toCity, String departureStart, String departureEnd, Integer noOfPassengers) {
        List<Flight> flights = new ArrayList<>();

        try {
            Connection connection = DatabaseUtil.getConnection();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date parsedStartDate = dateFormat.parse(departureStart);
            java.util.Date parsedEndDate = dateFormat.parse(departureEnd);
            java.sql.Date sqlStartDate = new java.sql.Date(parsedStartDate.getTime());
            java.sql.Date sqlEndDate = new java.sql.Date(parsedEndDate.getTime());

            String sql = "SELECT * FROM flights WHERE from_city = ? AND to_city = ? AND departure_date between ? and ? and seats_available >= ?";
//            String sql = "SELECT * FROM flights";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, fromCity);
            statement.setString(2, toCity);
            statement.setDate(3, sqlStartDate);
            statement.setDate(4, sqlEndDate);
            statement.setInt(5, noOfPassengers);

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
                flight.setDepartureDate(resultSet.getString("departure_date"));
                flight.setSeats_Available(resultSet.getString("seats_available"));
                flights.add(flight);
            }
            connection.close();
        } catch (Exception e) {
            Logger.log(e.getMessage());
        }

        return flights;
    }
}
