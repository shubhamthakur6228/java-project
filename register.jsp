

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
    String name = request.getParameter("t1");
    String email = request.getParameter("t2");
    String password = request.getParameter("t3");

    try {
        // Load the JDBC driver
        Class.forName("org.apache.derby.jdbc.ClientDriver");

        // Establish a database connection
        Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/fooddelivery","app","app");

        // Prepare the SQL statement
        PreparedStatement pst = con.prepareStatement("INSERT INTO users (name, email, password) VALUES (?, ?, ?)");
        pst.setString(1, name);
        pst.setString(2, email);
        pst.setString(3, password);

        // Execute the SQL statement
        pst.executeUpdate();

        // Close the connection
        pst.close();
        con.close();

        // Redirect to login page
        response.sendRedirect("login.html");
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
