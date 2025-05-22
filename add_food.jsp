<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<script>
var openFile = function(event) {
    var input = event.target;
    var reader = new FileReader();
    reader.onload = function() {
        var dataURL = reader.result;
        var output = document.getElementById('img1');
        output.src = dataURL;
        document.getElementById("bd1").value = dataURL;
    };
    reader.readAsDataURL(input.files[0]);
};
</script>
<head>
    <link rel="stylesheet" href="addfood.css">
</head>

<body>
    <div class="header">
        <a href="index.html" class="logo">FoodExpress</a>
        <div class="header-right">
            <a href="admin_feedback.jsp">Customer Feedback</a>
            <a class="active" href="add_food.jsp">Add Food</a>
            <a href="admin_logout.jsp">Logout</a>
        </div>
    </div>
    
    <div class="topnav">
        <a class="active" href="add_food.jsp">Add Food</a>
        <a href="admin_update.jsp">Update Food</a>
        <a href="admin_view.jsp">View Menu</a>
        
        <ul style="position:relative; padding:10px; color:#fefefe"> Welcome, <%=session.getAttribute("a")%></ul>
    </div>
    
    <div class="update_p">
        <h2 align="center">Add Food Item</h2>
        <form action="add_food_server.jsp" method="POST">
            <table border="0" align="center">
                <tr>
                    <td><b>Enter Food ID:</b></td>
                    <td><input type="number" name="food_id" id="food_id" required></td>
                </tr>
                <tr>
                    <td><b>Food Name:</b></td>
                    <td><input type="text" name="food_name" id="food_name" required></td>
                    
                </tr>
                <tr>
                    <td><b>Price:</b></td>
                    <td><input type="number" name="price" id="price" required></td>
                    
                </tr>
                <tr>
                    <td><b>Food Image:</b></td>
                    <td><input type="file" name="food_image" id="food_image" onchange="openFile(event)"></td>
                </tr>
                <tr>
                    <td colspan="4" align="center">
                        <input type="submit" value="Add Food" style="background-color: #6f8c6f;color: white;padding: 12px 20px;margin: 20px 0;border:none;cursor: pointer;width: 40%;">
                    </td>
                </tr>
            </table>
            <img src="" id="img1" width="100" height="100" style="position:absolute;top:900px;right:150px">
            <input type="hidden" name="bd" id="bd1">
        </form>
    </div>
</body>
</html>