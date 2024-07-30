package com.backend.codes.FlightManagementSystemGroupG;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DatabaseUtil {
    private static final Logger logger = Logger.getLogger(DatabaseUtil.class.getName());
    private static String URL;
    private static String USER;
    private static String PASSWORD;

    static {
        try (InputStream input = DatabaseUtil.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (input == null) {
                throw new RuntimeException("Sorry, unable to find db.properties");
            }

            Properties prop = new Properties();
            prop.load(input);

            URL = prop.getProperty("db.url");
            USER = prop.getProperty("db.user");
            PASSWORD = prop.getProperty("db.password");

            // Optionally check if properties are loaded correctly
            if (URL == null || USER == null || PASSWORD == null) {
                throw new RuntimeException("Missing database connection properties.");
            }

        } catch (Exception ex) {
            throw new RuntimeException("Failed to initialize database properties", ex);
        }
    }

    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }


    public static void Initialize() {
        try (var connection = DatabaseUtil.getConnection()) {
            logger.info("Connection established successfully");

            createTableIfNotExist(connection, "User", """
                    CREATE TABLE User (
                         id INT AUTO_INCREMENT PRIMARY KEY,
                         email VARCHAR(255) NOT NULL UNIQUE,
                         username VARCHAR(255) NOT NULL UNIQUE,
                         password VARCHAR(255) NOT NULL,
                         role ENUM('ADMIN', 'PASSENGER') NOT NULL DEFAULT 'PASSENGER'
                    );""");

            createTableIfNotExist(connection, "Passenger", """
                    CREATE TABLE Passenger (
                        id INT AUTO_INCREMENT PRIMARY KEY,
                        name VARCHAR(255) NOT NULL,
                        email VARCHAR(255) NOT NULL UNIQUE,
                        phone VARCHAR(20)
                    );""");

            createTableIfNotExist(connection, "Flight", """
                    CREATE TABLE Flight (
                        flightNumber VARCHAR(20) PRIMARY KEY,
                        departure VARCHAR(255) NOT NULL,
                        destination VARCHAR(255) NOT NULL,
                        departureTime DATETIME NOT NULL,
                        arrivalTime DATETIME NOT NULL,
                        status ENUM('SCHEDULED', 'CANCELLED', 'DELAYED', 'ON_TIME', 'LANDED') NOT NULL
                    );""");

            createTableIfNotExist(connection, "Reservation", """
                    CREATE TABLE Reservation (
                        reservationNumber VARCHAR(20) PRIMARY KEY,
                        flightNumber VARCHAR(20),
                        passengerId INT,
                        seatNumber VARCHAR(10) NOT NULL,
                        status ENUM('CONFIRMED', 'CANCELLED', 'PENDING') NOT NULL,
                        FOREIGN KEY (flightNumber) REFERENCES Flight(flightNumber),
                        FOREIGN KEY (passengerId) REFERENCES Passenger(id)
                    );""");

            createTableIfNotExist(connection, "Payment", """
                    CREATE TABLE Payment (
                        paymentId INT AUTO_INCREMENT PRIMARY KEY,
                        reservationNumber VARCHAR(20),
                        amount DOUBLE NOT NULL,
                        paymentDate DATETIME NOT NULL,
                        paymentStatus ENUM('COMPLETED', 'FAILED', 'PENDING') NOT NULL,
                        FOREIGN KEY (reservationNumber) REFERENCES Reservation(reservationNumber)
                    );""");

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Initialization failed", e);
            throw new RuntimeException(e);
        }
    }

    private static void createTableIfNotExist(Connection connection, String tableName, String createQuery) throws SQLException {
        var tables = connection.getMetaData().getTables(null, null, tableName, null);
        if (!tables.next()) {
            try (var statement = connection.createStatement()) {
                statement.execute(createQuery);
                logger.info("Table " + tableName + " created successfully");
            } catch (SQLException e) {
                logger.log(Level.SEVERE, "Failed to create table " + tableName, e);
                throw e;
            }
        } else {
            logger.info("Table " + tableName + " already exists");
        }
    }
}
