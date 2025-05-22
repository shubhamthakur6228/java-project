<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>
<head>
    <title>Update Food - Server</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #ff9966, #ff5e62);
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            background: white;
            padding: 20px;
            width: 50%;
            text-align: center;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            animation: fadeIn 0.8s ease-in-out;
        }

        h2 {
            color: #333;
        }

        .status-box {
            margin: 20px 0;
            padding: 15px;
            border-radius: 5px;
            font-size: 16px;
        }

        .success {
            background-color: #28a745;
            color: white;
            padding: 10px;
            border-radius: 5px;
            animation: slideIn 0.5s ease-in-out;
        }

        .error {
            background-color: #dc3545;
            color: white;
            padding: 10px;
            border-radius: 5px;
            animation: slideIn 0.5s ease-in-out;
        }

        .back-btn {
            display: inline-block;
            margin-top: 15px;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: background 0.3s ease;
        }

        .back-btn:hover {
            background-color: #0056b3;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: scale(0.9); }
            to { opacity: 1; transform: scale(1); }
        }

        @keyframes slideIn {
            from { transform: translateY(-20px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Update Food Status</h2>
        <div class="status-box">
            <%
                Connection con = null;
                PreparedStatement ps = null;

                String foodId = request.getParameter("food_id");
                String foodName = request.getParameter("food_name");
                String price = request.getParameter("price");
                String foodImage = request.getParameter("food_image");

                try {
                    Class.forName("org.apache.derby.jdbc.ClientDriver");
                    con = DriverManager.getConnection("jdbc:derby://localhost:1527/fooddelivery", "app", "app");

                    String query = "UPDATE menu SET food_name=?, price=?, food_image=? WHERE food_id=?";
                    ps = con.prepareStatement(query);
                    ps.setString(1, foodName);
                    ps.setDouble(2, Double.parseDouble(price));
                    ps.setString(3, foodImage);
                    ps.setInt(4, Integer.parseInt(foodId));

                    int updated = ps.executeUpdate();

                    if (updated > 0) {
            %>
                        <div class="success">
                            ✅ Food item updated successfully!
                        </div>
            <%
                    } else {
            %>
                        <div class="error">
                            ❌ Update failed! Food ID not found.
                        </div>
            <%
                    }
                } catch (Exception e) {
            %>
                    <div class="error">
                        ❌ Error: <%= e.getMessage() %>
                    </div>
            <%
                } finally {
                    if (ps != null) ps.close();
                    if (con != null) con.close();
                }
            %>
        </div>
        <a href="admin_update.jsp" class="back-btn">Back to Update Page</a>
    </div>
</body>
</html>
