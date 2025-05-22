<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
    String email = request.getParameter("t1");
    String password =request.getParameter("t2");

    try {
        // Load the JDBC driver
        Class.forName("org.apache.derby.jdbc.ClientDriver");

        // Establish a database connection
        Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/fooddelivery", "app", "app");

        // Prepare the SQL query
        PreparedStatement pst = con.prepareStatement("SELECT * FROM users WHERE email = ? AND password = ?");
        pst.setString(1, email);
        pst.setString(2, password);

        // Execute the query
        ResultSet rs = pst.executeQuery();

        if (rs.next()) {
            // Store user login details in the session
            session.setAttribute("userEmail", email);
            session.setAttribute("isLoggedIn", true);
            // Redirect to menu.jsp if login is successful
            response.sendRedirect("menu.jsp");
        } else {
            // Display an error message if login fails
            out.println("<script>alert('Invalid email or password!'); window.location.href='login.html';</script>");
        }

        // Close the connection
        rs.close();
        pst.close();
        con.close();
    }
    
        catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
