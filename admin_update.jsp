<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>
<head>
    <title>Update Food Item</title>
    <link rel="stylesheet" href="update_food.css">
    <script>
        // Function to preview image before updating
        function previewImage(event) {
            var input = event.target;
            var reader = new FileReader();
            reader.onload = function () {
                var dataURL = reader.result;
                document.getElementById("imgPreview").src = dataURL;
                document.getElementById("hiddenImage").value = dataURL;
            };
            reader.readAsDataURL(input.files[0]);
        }

        // Function to fetch existing food item details
        function fetchFoodDetails() {
            var foodId = document.getElementById("food_id").value;
            if (foodId === "") {
                alert("Please enter a Food ID.");
                return;
            }
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "fetch_food_details.jsp?food_id=" + foodId, true);
            xhr.onreadystatechange = function () {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    var response = JSON.parse(xhr.responseText);
                    if (response.status === "success") {
                        document.getElementById("food_name").value = response.food_name;
                        document.getElementById("price").value = response.price;
                        document.getElementById("imgPreview").src = response.food_image;
                        document.getElementById("hiddenImage").value = response.food_image;
                    } else {
                        alert("Food ID not found!");
                    }
                }
            };
            xhr.send();
        }
    </script>
</head>
<body>
    <div class="header">
        <a href="index.html" class="logo">FoodExpress</a>
        <div class="header-right">
            <a href="admin_feedback.jsp">Customer Feedback</a>
            <a href="add_food.jsp">Add Food</a>
            <a class="active" href="admin_update.jsp">Update Food</a>
            <a href="admin_logout.jsp">Logout</a>
        </div>
    </div>

    <div class="container">
        <h2>Update Food Item</h2>
        <form action="update_food_server.jsp" method="POST">
            <div class="input-group">
                <label>Enter Food ID:</label>
                <input type="number" name="food_id" id="food_id" required>
                <button type="button" onclick="fetchFoodDetails()">Search</button>
            </div>

            <div class="input-group">
                <label>Food Name:</label>
                <input type="text" name="food_name" id="food_name" required>
            </div>

            <div class="input-group">
                <label>Price:</label>
                <input type="number" name="price" id="price" required>
            </div>

            <div class="input-group">
                <label>Food Image:</label>
                <input type="file" name="food_image" id="food_image" onchange="previewImage(event)">
            </div>

            <div class="preview">
                <img src="" id="imgPreview" width="120" height="120">
            </div>

            <input type="hidden" name="hiddenImage" id="hiddenImage">

            <button type="submit" class="update-btn">Update Food</button>
        </form>
    </div>
</body>
</html>
