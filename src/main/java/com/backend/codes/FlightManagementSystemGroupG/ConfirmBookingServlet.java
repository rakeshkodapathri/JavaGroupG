package com.backend.codes.FlightManagementSystemGroupG;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.google.gson.Gson;
import jakarta.servlet.http.HttpSession;

@WebServlet("/confirmBooking")
public class ConfirmBookingServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
        }
        else{
            String selectedFlightJson = request.getParameter("selectedFlight");
            Gson gson = new Gson();
            Flight flight = gson.fromJson(selectedFlightJson, Flight.class);
            int noOfPasengers = (int) session.getAttribute("noOfPassengers");
            String bookedByUser = (String) session.getAttribute("user");

            List<Passenger> passengers = (List<Passenger>) request.getSession().getAttribute("passengerDetails");

            if (flight != null && passengers != null) {
                try {
                    String bookingId = saveBookingToDatabase(flight, passengers, noOfPasengers, bookedByUser);
                    response.sendRedirect("bookingDetails.jsp?bookingId=" + bookingId);
                } catch (SQLException | ClassNotFoundException e) {
                    Logger.log(e.getMessage());
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
                }
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid data");
            }

        }

    }

    private String saveBookingToDatabase(Flight flight, List<Passenger> passengers, int noOfPassengers,String bookedByUser) throws SQLException, ClassNotFoundException {
        Connection connection = DatabaseUtil.getConnection();
        PreparedStatement passengerStmt = null;
        PreparedStatement bookingStmt = null;
        PreparedStatement flightStmt = null;
        ResultSet generatedKeys = null;
        String bookingId = null;

        try {
            connection.setAutoCommit(false);
            // Generate Booking ID
            bookingId = generateBookingID();

            // Insert into passengers table
            String passengerSql = "INSERT INTO passengers (fullName, age, phone, email, passportNum, gender, flightNumber, Booking_ID, BookedByUser) VALUES (?, ?, ?, ?, ?, ?, ?, ?,?)";
            passengerStmt = connection.prepareStatement(passengerSql);

            for (Passenger passenger : passengers) {
                passengerStmt.setString(1, passenger.getFullName());
                passengerStmt.setInt(2, passenger.getAge());
                passengerStmt.setString(3, passenger.getPhone());
                passengerStmt.setString(4, passenger.getEmail());
                passengerStmt.setString(5, passenger.getPassportNum());
                passengerStmt.setString(6, passenger.getGender());
                passengerStmt.setString(7, flight.getFlightNumber());
                passengerStmt.setString(8, bookingId);
                passengerStmt.setString(9, bookedByUser);
                passengerStmt.addBatch();
            }

            passengerStmt.executeBatch();

            String flightsql = "Update flights set seats_Available = seats_Available - ? where flight_number = ?";

            flightStmt = connection.prepareStatement(flightsql);
            flightStmt.setInt(1,noOfPassengers);
            flightStmt.setString(2, flight.getFlightNumber());
            flightStmt.executeUpdate();

            connection.commit();
        } catch (SQLException e) {
            connection.rollback();
            throw e;
        } finally {
            if (passengerStmt != null) passengerStmt.close();
            if (connection != null) connection.close();
        }

        return bookingId;
    }

    private String generateBookingID() {
        return "BOOK" +  (int)(Math.random() * 1000);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
        }
        else{
            String bookingId = (String) request.getParameter("bookingId");
            request.setAttribute("bookingId", bookingId);

            try {
                BookingDetails bookingDetails = passengerFromDatabase(bookingId);
                List<Passenger> passenger = new ArrayList<>();
                passenger = bookingDetails.getPassengers();
                Flight flight = bookingDetails.getFlightDetails();
                String flightJson = new Gson().toJson(flight);

                session.setAttribute("selectedFlight", flightJson);
                session.setAttribute("passengerDetails", passenger);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            } catch (ClassNotFoundException e) {
                throw new RuntimeException(e);
            }

            response.sendRedirect("bookingDetails.jsp?bookingId=" + bookingId);

        }
    }

    private BookingDetails passengerFromDatabase(String bookingId) throws SQLException, ClassNotFoundException {
        BookingDetails bookingDetails;

        Flight flight = new Flight();
        List<Passenger> passengers = new ArrayList<>();
        String flightNumber =  new String();
            try{
                Connection connection = DatabaseUtil.getConnection();
                String sql = "SELECT * FROM passengers Join flights on flights.flight_number = Passengers.flightNumber WHERE booking_Id = ?";
                PreparedStatement statement = connection.prepareStatement(sql);
                statement.setString(1, bookingId);
                ResultSet resultSet = statement.executeQuery();
                while (resultSet.next()) {
                    Passenger passenger = new Passenger();
                    passenger.setFullName(String.valueOf(resultSet.getString("fullName")));
                    passenger.setAge(resultSet.getInt("age"));
                    passenger.setPhone(resultSet.getString("phone"));
                    passenger.setEmail(resultSet.getString("email"));
                    passenger.setPassportNum(resultSet.getString("passportNum"));
                    passenger.setGender(resultSet.getString("gender"));
                    flight.setFlightNumber(resultSet.getString("flightNumber"));
                    flight.setAirline(resultSet.getString("airline"));
                    flight.setFromCity(resultSet.getString("from_city"));
                    flight.setToCity(resultSet.getString("to_city"));
                    flight.setDepartureTime(resultSet.getTime("departure_time"));
                    flight.setArrivalTime(resultSet.getTime("arrival_time"));
                    flight.setPrice(resultSet.getDouble("price"));
                    flight.setDepartureDate(resultSet.getString("departure_date"));
                    flight.setSeats_Available(resultSet.getString("seats_available"));

                    passengers.add(passenger);
                }


                connection.close();
            }
            catch (SQLException e) {
                Logger.log(e.getMessage());
            }

        return new BookingDetails(passengers,flight);
    }

}
