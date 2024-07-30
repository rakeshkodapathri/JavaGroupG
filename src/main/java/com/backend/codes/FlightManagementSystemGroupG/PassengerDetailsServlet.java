package com.backend.codes.FlightManagementSystemGroupG;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpSession;

@WebServlet("/PassengerDetailsServlet")
public class PassengerDetailsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("passengerDetails.jsp");
        dispatcher.forward(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
        }
        else{
            String selectedFlight = (String) session.getAttribute("selectedFlight");
            int numPassengers = (int) session.getAttribute("noOfPassengers");

            List<Passenger> Passengers = new ArrayList<>(numPassengers);

            for (int i = 1; i <= numPassengers; i++) {
                Passenger passenger = new Passenger();
                passenger.setFullName(request.getParameter("fullname"+i));
                passenger.setEmail(request.getParameter("email"+i));
                passenger.setAge(Integer.parseInt(request.getParameter("age"+i)));
                passenger.setGender(request.getParameter("gender"+i));
                passenger.setPhone(request.getParameter("phone"+i));
                passenger.setPassportNum(request.getParameter("passport"+i));
                Passengers.add(passenger);

            }
            // You can process the selected flight here, for example, saving it to the session or database

            session.setAttribute("passengerDetails", Passengers);
            request.setAttribute("selectedFlight", selectedFlight);

            RequestDispatcher dispatcher = request.getRequestDispatcher("confirmationBooking.jsp");
            dispatcher.forward(request, response);
        }

        }
}
