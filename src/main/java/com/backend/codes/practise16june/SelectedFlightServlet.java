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
        String name = request.getParameter("fullname");
        String dob = request.getParameter("dob");
        String Passport = request.getParameter("passport");

        // You can process the selected flight here, for example, saving it to the session or database

        request.setAttribute("selectedFlight", selectedFlight);
        request.setAttribute("name", name);
        request.setAttribute("dob", dob);
        request.setAttribute("Passport", Passport);

        RequestDispatcher dispatcher = request.getRequestDispatcher("booking.jsp");
        dispatcher.forward(request, response);
    }
}
