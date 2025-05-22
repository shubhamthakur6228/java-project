<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
    String name = request.getParameter("t1");
    String email = request.getParameter("t2");
    String message = request.getParameter("t3");

    try {
        // Load the JDBC driver
        Class.forName("org.apache.derby.jdbc.ClientDriver");

        // Establish a database connection
        Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/fooddelivery","app","app");

        // Prepare the SQL query
        PreparedStatement pst = con.prepareStatement("INSERT INTO contact_us (name, email, message) VALUES (?, ?, ?)");
        pst.setString(1, name);
        pst.setString(2, email);
        pst.setString(3, message);

        // Execute the query
        pst.executeUpdate();

        // Close the connection
        pst.close();
        con.close();

        // Display success message
        out.println("<script>alert('Thank you for reaching out! We will get back to you soon.'); window.location.href='contact.html';</script>");
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
