<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.FileReader" %>
<%@ page import="java.io.IOException" %>
<!DOCTYPE html>
<html>
<head>
    <title>Log Viewer</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .log-container {
            border: 1px solid #ccc;
            padding: 10px;
            margin: 20px;
            max-height: 400px;
            overflow-y: scroll;
            background-color: #f9f9f9;
        }
    </style>
</head>
<body>
<h1>Log Viewer</h1>
<div class="log-container">
        <pre>
<%
    String logFilePath = "/path/to/logs.txt"; // Replace with your file path
    try (BufferedReader br = new BufferedReader(new FileReader(logFilePath))) {
        String line;
        while ((line = br.readLine()) != null) {
            out.println(line);
        }
    } catch (IOException e) {
        out.println("Error reading log file: " + e.getMessage());
    }
%>
        </pre>
</div>
</body>
</html>
