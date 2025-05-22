<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Connection con = null;
    PreparedStatement ps = null;
    
    try {
        // Get the food ID from the request
        int foodId = Integer.parseInt(request.getParameter("food_id"));
        
        // Database connection
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        con = DriverManager.getConnection("jdbc:derby://localhost:1527/fooddelivery", "app", "app");
        
        
        // SQL query to delete the food item
        String query = "DELETE FROM menu WHERE food_id = ?";
        ps = con.prepareStatement(query);
        ps.setInt(1, foodId);
        
        int rowsAffected = ps.executeUpdate();
        
        if (rowsAffected > 0) {
            response.sendRedirect("admin_view.jsp?success=1"); // Redirect back with success message
        } else {
            response.sendRedirect("admin_view.jsp?error=1"); // Redirect back with error message
        }
    } catch (Exception e) {
        response.sendRedirect("admin_view.jsp?error=1"); // Redirect back with error message
    } finally {
        if (ps != null) ps.close();
        if (con != null) con.close();
    }
%>
