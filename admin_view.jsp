<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin View - Food Items</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid black; padding: 10px; text-align: left; }
        th { background-color: #f2f2f2; }
        img { max-width: 100px; max-height: 100px; border-radius: 5px; }
        .delete-btn {
            background-color: red;
            color: white;
            padding: 5px 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .delete-btn:hover {
            background-color: darkred;
        }
    </style>
</head>
<body>
    <h2>Admin View - Food Items</h2>
    <table>
        <tr>
            <th>ID</th>
            <th>Food Name</th>
            <th>Price</th>
            <th>Food Image</th>
            <th>Action</th>
        </tr>
        
        <% 
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            con = DriverManager.getConnection("jdbc:derby://localhost:1527/fooddelivery", "app", "app");
            
            String query = "SELECT * FROM menu";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            
            while (rs.next()) {
        %>
                <tr>
                    <td><%= rs.getInt("food_id") %></td>
                    <td><%= rs.getString("food_name") %></td>
                    <td>₹<%= rs.getDouble("price") %></td>
                    <td>
                        <img src="<%= rs.getString("food_image") %>" alt="Food Image">
                    </td>
                    <td>
                        <form action="delete_food.jsp" method="POST" onsubmit="return confirm('Are you sure you want to delete this item?');">
                            <input type="hidden" name="food_id" value="<%= rs.getInt("food_id") %>">
                            <button type="submit" class="delete-btn">Remove</button>
                        </form>
                    </td>
                </tr>
        <%
            }
        } catch (Exception e) {
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
        %>
    </table><br>
    <center><a href="add_food.jsp">Back to Admin Page</a></center>
</body>
</html>
