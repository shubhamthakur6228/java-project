<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cart - FoodExpress</title>
    <link rel="stylesheet" href="cart.css">
</head>
<body>
    <header>
        <nav>
            <h1>FoodExpress</h1>
            <ul>
                <li><a href="index.html">Home</a></li>
                <li><a href="menu.html">Menu</a></li>
                <li><a href="cart.jsp" class="active">Cart</a></li>
                <li><a href="aboutus.html">About</a></li>
                <li><a href="contact.html">Contact</a></li>
            </ul>
        </nav>
    </header>

    <main>
        <section class="cart">
            <h2>Your Cart</h2>
            <table>
                <thead>
                    <tr>
                        <th>Item</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Total</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Connection con = null;
                        Statement stmt = null;
                        ResultSet rs = null;

                        try {
                            // Connect to the database
                            Class.forName("org.apache.derby.jdbc.ClientDriver");
                            con = DriverManager.getConnection("jdbc:derby://localhost:1527/fooddelivery","app","app");

                            // Query the orders table to fetch cart items
                            String query = "SELECT id, item_name, item_price, quantity FROM orders";
                            stmt = con.createStatement();
                            rs = stmt.executeQuery(query);

                            double subtotal = 0;

                            while (rs.next()) {
                                int id = rs.getInt("id");
                                String itemName = rs.getString("item_name");
                                double itemPrice = rs.getDouble("item_price");
                                int quantity = rs.getInt("quantity");
                                double total = itemPrice * quantity;
                                subtotal += total;
                    %>
                    <tr>
                        <td><%= itemName %></td>
                        <td>$<%= String.format("%.2f", itemPrice) %></td>
                        <td><%= quantity %></td>
                        <td>$<%= String.format("%.2f", total) %></td>
                        <td>
                            <form method="post" action="cart.jsp">
                                <input type="hidden" name="deleteId" value="<%= id %>">
                                <button type="submit">Remove</button>
                            </form>
                        </td>
                    </tr>
                    <%
                            }
                    %>
                </tbody>
            </table>

            <div class="cart-summary">
                <p>Subtotal: $<%= String.format("%.2f", subtotal) %></p>
                <a href="checkout.html" class="checkout-btn">Proceed to Checkout</a>
                <a href="menu.html" class="add-more-btn">Add More Items</a>
            </div>
        </section>
    </main>

    <footer>
        <p>&copy; 2024 FoodExpress. All rights reserved.</p>
    </footer>

    <%
        } catch (Exception e) {
            out.println("<tr><td colspan='5'>Error fetching cart: " + e.getMessage() + "</td></tr>");
        } finally {
            // Close resources
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                out.println("Error closing resources: " + e.getMessage());
            }
        }

        // Handle item removal from the cart
        String deleteId = request.getParameter("deleteId");
        if (deleteId != null) {
            try {
                // Connect to the database
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                con = DriverManager.getConnection("jdbc:derby://localhost:1527/fooddelivery", "app", "app");

                // Delete the item with the specified ID
                String deleteQuery = "DELETE FROM orders WHERE id = ?";
                PreparedStatement pst = con.prepareStatement(deleteQuery);
                pst.setInt(1, Integer.parseInt(deleteId));
                pst.executeUpdate();

                pst.close();
                con.close();

                // Redirect to refresh the page
                response.sendRedirect("cart.jsp");
            } catch (Exception e) {
                out.println("<script>alert('Error removing item: " + e.getMessage() + "');</script>");
            }
        }
    %>
</body>
</html>
