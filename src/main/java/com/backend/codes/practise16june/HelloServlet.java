package com.backend.codes.practise16june;

import java.io.*;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.*;

import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.ServletException;

@WebServlet(name = "helloServlet", value = "/hello-servlet")
public class HelloServlet extends HttpServlet {
    private String message;
    Person p1 = new Person();
    public void init() {
        message = "Hello World!";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");

        try{
            String driver = "com.mysql.cj.jdbc.Driver";
            Class.forName(driver);
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ebookShop","root","Raki@230");
            Statement st = con.createStatement();
            String sql = "Select user_name from users where user_name = 'rakesh'";

            ResultSet rs = st.executeQuery(sql);
            while (rs.next()){
                p1.setName(rs.getString(1));
            }
        }
        catch (Exception e) {
            p1.setName("error" + e);
        }

        request.setAttribute("input1","Hello");
        request.setAttribute("input2","World");

        // Hello
        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        out.println("<h1>" + p1.getName() + "</h1>");
        out.println("</body></html>");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Set the values as request attributes
        request.setAttribute("input1", "Hello");
        request.setAttribute("input2", "World");

        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    public void destroy() {
    }
}