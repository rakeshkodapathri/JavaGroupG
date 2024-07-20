package com.backend.codes.practise16june;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpSession;

@WebServlet("/PassengerDetails")
public class PassengerDetails extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String selectedFlight = request.getParameter("selectedFlight");

        HttpSession session = request.getSession();
        session.setAttribute("selectedFlight", selectedFlight);

        RequestDispatcher dispatcher = request.getRequestDispatcher("passengerDetails.jsp");
        dispatcher.forward(request, response);
    }
}
