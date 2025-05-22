<%@page import="java.sql.*"%>
<%@page contentType="application/json" pageEncoding="UTF-8"%>

<%
    String foodId = request.getParameter("food_id");
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        con = DriverManager.getConnection("jdbc:derby://localhost:1527/fooddelivery", "app", "app");

        String query = "SELECT * FROM menu WHERE food_id=?";
        ps = con.prepareStatement(query);
        ps.setInt(1, Integer.parseInt(foodId));
        rs = ps.executeQuery();

        if (rs.next()) {
            out.print("{\"status\": \"success\", \"food_name\": \"" + rs.getString("food_name") + "\", \"price\": " + rs.getDouble("price") + ", \"food_image\": \"" + rs.getString("food_image") + "\"}");
        } else {
            out.print("{\"status\": \"error\"}");
        }
    } catch (Exception e) {
        out.print("{\"status\": \"error\"}");
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (con != null) con.close();
    }
%>
