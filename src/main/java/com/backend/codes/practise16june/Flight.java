package com.backend.codes.practise16june;

public class Flight {
    private String flightNumber;
    private String airline;
    private String fromCity;
    private String toCity;
    private java.sql.Time departureTime;
    private java.sql.Time arrivalTime;
    private double price;
    private String departureDate;
    private String seats_Available;

    // Getters and Setters
    public String getFlightNumber() { return flightNumber; }
    public void setFlightNumber(String flightNumber) { this.flightNumber = flightNumber; }

    public String getAirline() { return airline; }
    public void setAirline(String airline) { this.airline = airline; }

    public String getFromCity() { return fromCity; }
    public void setFromCity(String fromCity) { this.fromCity = fromCity; }

    public String getToCity() { return toCity; }
    public void setToCity(String toCity) { this.toCity = toCity; }

    public java.sql.Time getDepartureTime() { return departureTime; }
    public void setDepartureTime(java.sql.Time departureTime) { this.departureTime = departureTime; }

    public java.sql.Time getArrivalTime() { return arrivalTime; }
    public void setArrivalTime(java.sql.Time arrivalTime) { this.arrivalTime = arrivalTime; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getDepartureDate() { return departureDate; }
    public void setDepartureDate(String departureDate) {this.departureDate = departureDate; }

    public String getSeats_Available() { return seats_Available; }
    public void setSeats_Available(String seats_Available) { this.seats_Available = seats_Available;}
}
