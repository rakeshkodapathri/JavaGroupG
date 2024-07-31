package com.backend.codes.FlightManagementSystemGroupG;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpSession;

@WebServlet("/FlightDetailsServlet")
public class FlightDetailsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("flightDetails.jsp");
        dispatcher.forward(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession().getAttribute("user") == null) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
        }
        else{
            HttpSession session = request.getSession();
            String selectedFlightJson = request.getParameter("selectedFlight");
            session.setAttribute("selectedFlight", selectedFlightJson);
            RequestDispatcher dispatcher = request.getRequestDispatcher("passengerDetails.jsp");
            dispatcher.forward(request, response);
        }
    }
}
