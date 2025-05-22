<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    int food_id = Integer.parseInt(request.getParameter("food_id"));
    String food_name = request.getParameter("food_name");
    double price = Double.parseDouble(request.getParameter("price"));
    String food_image = request.getParameter("food_image");  // Image in base64 format

    Connection con = null;
    PreparedStatement ps = null;

    try {
         Class.forName("org.apache.derby.jdbc.ClientDriver");
         con = DriverManager.getConnection("jdbc:derby://localhost:1527/fooddelivery","app","app");

        String sql = "INSERT INTO menu(food_id, food_name, price, food_image) VALUES ( ?, ?, ?, ?)";
        ps = con.prepareStatement(sql);
        ps.setInt(1, food_id);
        ps.setString(2, food_name);
        ps.setDouble(3, price);
        ps.setString(4, food_image);

        int result = ps.executeUpdate();
        if (result > 0) {
            response.sendRedirect("admin_view.jsp");
        } else {
            out.println("<script>alert('Failed to add food item.'); window.history.back();</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (ps != null) ps.close();
        if (con != null) con.close();
    }
%>