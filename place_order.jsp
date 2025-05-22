<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, org.json.JSONObject, org.json.JSONArray"%>

<%
    // Set response type to JSON
    response.setContentType("application/json");
    
    // Read JSON data from the request
    StringBuilder sb = new StringBuilder();
    String line;
    while ((line = request.getReader().readLine()) != null) {
        sb.append(line);
    }

    try {
        // Parse JSON request data
        JSONObject json = new JSONObject(sb.toString());
        String name = json.getString("name");
        String email = json.getString("email");
        String address = json.getString("address");
        String paymentMethod = json.getString("paymentMethod");
        String paymentAmount = json.getString("paymentAmount").replace("₹", ""); // Remove ₹ symbol if present
        JSONArray cartItems = json.getJSONArray("cartItems");

        Connection con = null;
        PreparedStatement psOrder = null, psItem = null;
        ResultSet rs = null;

        try {
            // Database connection
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            con = DriverManager.getConnection("jdbc:derby://localhost:1527/fooddelivery", "app", "app");

            // Insert order into `orders` table
            String orderSQL = "INSERT INTO orders (name, email, address, payment_method, total_amount, status) VALUES (?, ?, ?, ?, ?, 'Pending')";
            psOrder = con.prepareStatement(orderSQL, Statement.RETURN_GENERATED_KEYS);
            psOrder.setString(1, name);
            psOrder.setString(2, email);
            psOrder.setString(3, address);
            psOrder.setString(4, paymentMethod);
            psOrder.setDouble(5, Double.parseDouble(paymentAmount));
            psOrder.executeUpdate();

            // Get the generated order ID
            rs = psOrder.getGeneratedKeys();
            int orderId = -1;
            if (rs.next()) {
                orderId = rs.getInt(1);
            }

            // Insert ordered items into `order_items` table
            String itemSQL = "INSERT INTO order_items (order_id, food_name, quantity, price) VALUES (?, ?, ?, ?)";
            psItem = con.prepareStatement(itemSQL);

            for (int i = 0; i < cartItems.length(); i++) {
                JSONObject item = cartItems.getJSONObject(i);
                psItem.setInt(1, orderId);
                psItem.setString(2, item.getString("name"));
                psItem.setInt(3, item.getInt("quantity"));
                psItem.setDouble(4, item.getDouble("price"));
                psItem.executeUpdate();
            }

            // Send JSON success response
            out.print("{\"status\": \"success\", \"order_id\": " + orderId + "}");

        } catch (Exception e) {
            out.print("{\"status\": \"error\", \"message\": \"" + e.getMessage() + "\"}");
        } finally {
            if (rs != null) rs.close();
            if (psOrder != null) psOrder.close();
            if (psItem != null) psItem.close();
            if (con != null) con.close();
        }

    } catch (Exception e) {
        out.print("{\"status\": \"error\", \"message\": \"Invalid JSON format\"}");
    }
%>
