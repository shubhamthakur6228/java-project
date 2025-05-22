<%@page import="java.sql.*"%>
<%@page import="org.json.JSONObject" %>

<%
    // Set the response type to JSON
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");

    // Database connection details
    String dbURL = "jdbc:derby://localhost:1527/fooddelivery";
    String dbUser = "app";
    String dbPassword = "app"; // Replace with your actual password

    // Get the order_id parameter
    String orderIdParam = request.getParameter("order_id");
    int orderId = 0;

    try {
        orderId = Integer.parseInt(orderIdParam);
    } catch (NumberFormatException e) {
        JSONObject errorResponse = new JSONObject();
        errorResponse.put("status", "Invalid Order ID.");
        response.getWriter().write(errorResponse.toString());
        return;
    }

    try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword)) {
        // Query to fetch order details
        String query = "SELECT status, latitude, longitude FROM orders WHERE order_id = ?";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setInt(1, orderId);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            String status = rs.getString("status");
            double latitude = rs.getDouble("latitude");
            double longitude = rs.getDouble("longitude");

            // Create JSON response
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("status", status);
            jsonResponse.put("location", new JSONObject().put("latitude", latitude).put("longitude", longitude));

            response.getWriter().write(jsonResponse.toString());
        } else {
            JSONObject errorResponse = new JSONObject();
            errorResponse.put("status", "Order not found.");
            response.getWriter().write(errorResponse.toString());
        }
    } catch (Exception e) {
        e.printStackTrace();
        JSONObject errorResponse = new JSONObject();
        errorResponse.put("status", "Database error.");
        response.getWriter().write(errorResponse.toString());
    }
%>
