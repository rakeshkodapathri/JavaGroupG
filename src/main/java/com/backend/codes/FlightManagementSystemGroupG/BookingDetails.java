package com.backend.codes.FlightManagementSystemGroupG;
import java.util.ArrayList;
import java.util.List;

public class BookingDetails {
    private List<Passenger> passengers = new ArrayList<>();
    private Flight flight;
    public BookingDetails(List<Passenger> passengers, Flight flightDetails) {
        this.passengers = passengers;
        this.flight = flightDetails;
    }

    public List<Passenger> getPassengers() {
        return passengers;
    }

    public Flight getFlightDetails() {
        return flight;
    }
}
