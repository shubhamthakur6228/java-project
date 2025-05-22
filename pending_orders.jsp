<%@ page import="java.sql.*" %>
<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String address = request.getParameter("address");
    String paymentMethod = request.getParameter("payment_method");
    String totalAmount = request.getParameter("total_amount");

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/fooddelivery", "app", "app");

        String query = "INSERT INTO PENDING_ORDERS (order_id, name, email, address, payment_method, total_amount) VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement pst = con.prepareStatement(query);

        int orderId = (int) (Math.random() * 100000);
        pst.setInt(1, orderId);
        pst.setString(2, name);
        pst.setString(3, email);
        pst.setString(4, address);
        pst.setString(5, paymentMethod);
        pst.setDouble(6, Double.parseDouble(totalAmount));

        int rows = pst.executeUpdate();

        if (rows > 0) {
            if (paymentMethod.equals("cod")) {
                out.println("<script>alert('Order placed successfully! Redirecting to confirmation...'); window.location.href='order-confirmation.html';</script>");
            } else if (paymentMethod.equals("paypal")) {
                out.println("<script>alert('Redirecting to online payment...'); window.location.href='onlinepayment.html';</script>");
            }
        } else {
            out.println("<script>alert('Failed to place order. Try again.'); window.location.href='checkout.html';</script>");
        }

        pst.close();
        con.close();
    } catch (Exception e) {
        out.println("<script>alert('Database error: " + e.getMessage() + "'); window.location.href='checkout.html';</script>");
    }
%>
