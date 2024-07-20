package com.backend.codes.practise16june;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;

@WebServlet("/SelectedFlightServlet")
public class SelectedFlightServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String selectedFlight = request.getParameter("selectedFlight");
        int numPassengers = Integer.parseInt(request.getParameter("numPassengers"));

        for (int i = 1; i <= numPassengers; i++) {
            // Retrieve form parameters for each passenger
            String fullname = request.getParameter("fullname" + i);
            String dob = request.getParameter("dob" + i);
            String gender = request.getParameter("gender" + i);
            String passport = request.getParameter("passport" + i);


        }
            // You can process the selected flight here, for example, saving it to the session or database

        request.setAttribute("selectedFlight", selectedFlight);

        RequestDispatcher dispatcher = request.getRequestDispatcher("booking.jsp");
        dispatcher.forward(request, response);
    }
}
