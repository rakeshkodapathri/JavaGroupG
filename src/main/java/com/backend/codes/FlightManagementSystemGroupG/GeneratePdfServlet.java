package com.backend.codes.FlightManagementSystemGroupG;

import com.google.gson.Gson;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Font;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

@WebServlet("/DownloadPdfServlet")
public class GeneratePdfServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=\"FlightAndPassengerDetails.pdf\"");

        try (OutputStream out = response.getOutputStream()) {
            Document document = new Document();
            PdfWriter.getInstance(document, out);
            document.open();

            // Define font styles
            Font headingFont = new Font(Font.FontFamily.HELVETICA, 16, Font.BOLD);
            Font subHeadingFont = new Font(Font.FontFamily.HELVETICA, 14, Font.BOLD);
            Font tableHeaderFont = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD);
            Font normalFont = new Font(Font.FontFamily.HELVETICA, 12);

            // Add flight details
            String selectedFlightJson = (String) request.getSession().getAttribute("selectedFlight");
            Gson gson = new Gson();
            Flight flight = gson.fromJson(selectedFlightJson, Flight.class);

            if (flight != null) {
                document.add(new Paragraph("Flight Details", headingFont));
                document.add(new Paragraph("", subHeadingFont));

                PdfPTable flightTable = new PdfPTable(8); // Adjust columns as needed
                flightTable.setWidthPercentage(100); // Table width
                flightTable.setSpacingBefore(10f);
                flightTable.setSpacingAfter(10f);

                // Table headers
                addCell(flightTable, "Flight Number", tableHeaderFont);
                addCell(flightTable, "Airline", tableHeaderFont);
                addCell(flightTable, "From", tableHeaderFont);
                addCell(flightTable, "To", tableHeaderFont);
                addCell(flightTable, "Departure Time", tableHeaderFont);
                addCell(flightTable, "Arrival Time", tableHeaderFont);
                addCell(flightTable, "Price", tableHeaderFont);
                addCell(flightTable, "Departure Date", tableHeaderFont);

                // Flight details
                addCell(flightTable, flight.getFlightNumber(), normalFont);
                addCell(flightTable, flight.getAirline(), normalFont);
                addCell(flightTable, flight.getFromCity(), normalFont);
                addCell(flightTable, flight.getToCity(), normalFont);
                addCell(flightTable, String.valueOf(flight.getDepartureTime()), normalFont);
                addCell(flightTable, String.valueOf(flight.getArrivalTime()), normalFont);
                addCell(flightTable, String.valueOf(flight.getPrice()), normalFont);
                addCell(flightTable, flight.getDepartureDate(), normalFont);

                document.add(flightTable);
            }

            // Add passenger details
            List<Passenger> passengers = (List<Passenger>) request.getSession().getAttribute("passengerDetails");

            if (passengers != null && !passengers.isEmpty()) {
                document.add(new Paragraph("Passenger Details", headingFont));

                PdfPTable passengerTable = new PdfPTable(6); // Adjust columns as needed
                passengerTable.setWidthPercentage(100); // Table width
                passengerTable.setSpacingBefore(10f);
                passengerTable.setSpacingAfter(10f);

                // Table headers
                addCell(passengerTable, "Full Name", tableHeaderFont);
                addCell(passengerTable, "Age", tableHeaderFont);
                addCell(passengerTable, "Phone", tableHeaderFont);
                addCell(passengerTable, "Email", tableHeaderFont);
                addCell(passengerTable, "Passport Number", tableHeaderFont);
                addCell(passengerTable, "Gender", tableHeaderFont);

                // Passenger details
                for (Passenger passenger : passengers) {
                    addCell(passengerTable, passenger.getFullName(), normalFont);
                    addCell(passengerTable, String.valueOf(passenger.getAge()), normalFont);
                    addCell(passengerTable, passenger.getPhone(), normalFont);
                    addCell(passengerTable, passenger.getEmail(), normalFont);
                    addCell(passengerTable, passenger.getPassportNum(), normalFont);
                    addCell(passengerTable, passenger.getGender(), normalFont);
                }

                document.add(passengerTable);
            }

            document.close();
        } catch (DocumentException e) {
            throw new ServletException("Error generating PDF", e);
        }
    }

    private void addCell(PdfPTable table, String text, Font font) {
        PdfPCell cell = new PdfPCell(new Phrase(text, font));
        cell.setPadding(8);
        table.addCell(cell);
    }
}
