package com.backend.codes.FlightManagementSystemGroupG;

import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

public class Logger {
    private static final String LOG_FILE = "/path/to/logs.txt"; // Replace with your file path

    public static void log(String message) {
        try (PrintWriter out = new PrintWriter(new FileWriter(LOG_FILE, true))) {
            out.println(message);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
