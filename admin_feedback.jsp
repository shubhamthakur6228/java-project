<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>
<head>
    <title>Customer Feedback</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #6f8c6f, #4b6d4b); /* Matching add_food.jsp */
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        h2 {
            margin-top: 20px;
            color: white;
            text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2);
            font-size: 30px;
            animation: fadeIn 1s ease-in-out;
        }

        .feedback-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            margin-top: 20px;
            width: 80%;
        }

        .feedback-card {
            background: #fefefe; /* Light background for contrast */
            padding: 15px;
            width: 320px;
            margin: 15px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            animation: slideIn 0.8s ease-in-out;
            position: relative;
            overflow: hidden;
        }

        .feedback-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
        }

        .feedback-header {
            font-size: 18px;
            font-weight: bold;
            color: #2e472e; /* Darker shade from add_food.jsp */
        }

        .feedback-email {
            font-size: 14px;
            color: #3e5b3e; /* Muted green */
            font-style: italic;
            margin-top: 5px;
        }

        .feedback-message {
            font-size: 16px;
            color: #333;
            margin: 15px 0;
        }

        .refresh-btn {
            background: #6f8c6f; /* Matching primary button color */
            color: white;
            padding: 12px 20px;
            border: none;
            cursor: pointer;
            font-size: 16px;
            border-radius: 5px;
            transition: background 0.3s ease, transform 0.2s ease;
            margin-top: 20px;
        }

        .refresh-btn:hover {
            background: #4b6d4b; /* Darker green for hover */
            transform: scale(1.05);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: scale(0.9); }
            to { opacity: 1; transform: scale(1); }
        }

        @keyframes slideIn {
            from { transform: translateY(20px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }
    </style>
</head>
<body>

    <h2>Customer Feedback</h2>
    <div class="feedback-container">
        <%
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                con = DriverManager.getConnection("jdbc:derby://localhost:1527/fooddelivery", "app", "app");

                String query = "SELECT * FROM Contact_us ORDER BY name ASC";
                ps = con.prepareStatement(query);
                rs = ps.executeQuery();

                while (rs.next()) {
        %>
                    <div class="feedback-card">
                        <div class="feedback-header">
                            🧑 <%= rs.getString("name") %>
                        </div>
                        <div class="feedback-email">
                            ✉ <%= rs.getString("email") %>
                        </div>
                        <div class="feedback-message">
                            "<%= rs.getString("message") %>"
                        </div>
                    </div>
        <%
                }
            } catch (Exception e) {
                out.println("<p style='color: red;'>Error: " + e.getMessage() + "</p>");
            } finally {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            }
        %>
    </div>

    <button class="refresh-btn" onclick="location.reload();">🔄 Refresh Feedback</button>

</body>
</html>
