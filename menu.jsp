<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menu - Food Delivery</title>
    <style>
        /* General Styles */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f8f8;
            text-align: center;
        }
        h1 {
            margin: 20px;
            color: #333;
            background-color: orangered;
        }

        /* Navigation Bar */
        .cart-button {
            margin-bottom: 20px;
            text-align: right;
        }

        .cart-button nav {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            background-color: #333;
            padding: 10px 20px;
            border-radius: 5px;
        }

        .cart-button nav a {
            color: white;
            text-decoration: none;
            font-size: 16px;
            font-weight: bold;
            margin: 0 15px;
            transition: color 0.3s ease-in-out;
        }

        .cart-button nav a:hover {
            color: #f8b400;
        }

        /* Responsive Grid Layout for Menu Items */
        .menu-items {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); /* Auto adjust grid */
            gap: 20px;
            padding: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .item {
            background-color: white;
            border-radius: 10px;
            padding: 15px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: transform 0.2s ease-in-out;
        }

        .item:hover {
            transform: scale(1.05);
        }

        .item img {
            width: 100%;
            max-height: 150px;
            object-fit: cover;
            border-radius: 10px;
        }

        .item h3 {
            color: #333;
            font-size: 20px;
            margin: 10px 0;
        }

        .item p {
            color: #555;
            font-size: 18px;
            font-weight: bold;
        }

        .item input {
            width: 50px;
            padding: 5px;
            margin-top: 5px;
            text-align: center;
        }

        .item button {
            background-color: #ff6600;
            color: white;
            border: none;
            padding: 8px 15px;
            margin-top: 10px;
            cursor: pointer;
            border-radius: 5px;
            font-size: 14px;
            transition: background 0.3s ease;
        }

        .item button:hover {
            background-color: #cc5500;
        }

        /* Search Bar */
        .search-bar {
            margin: 20px;
        }

        .search-bar input {
            width: 60%;
            padding: 10px;
            font-size: 16px;
            border: 2px solid #333;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <header>
        <h1>Our Menu</h1>
    </header>

    <div class="cart-button">
        <nav>
            <a href="cart.html">Cart</a>
            <a href="logouts.jsp">Logout</a>
            <a href="aboutus.html">about-us</a>
            <a href="contact.html">contact-us</a>
            
        </nav>
    </div>

    <div class="search-bar">
        <input type="text" id="searchInput" placeholder="Search for food..." onkeyup="filterMenu()">
    </div>

    <div class="menu-items" id="menuItems">
        <%-- Static Menu Items --%>
        <div class="item" data-name="pizza">
            <img src="pizza.jpg" alt="Pizza">
            <h3>Pizza</h3>
            <p>₹120.00</p>
            <input type="number" id="pizzaQty" value="1" min="1" max="10">
            <button onclick="addToCart('Pizza', 120.00, document.getElementById('pizzaQty').value)">Add to Cart</button>
        </div>
        <div class="item" data-name="burger">
            <img src="burger.jpg" alt="Burger">
            <h3>Burger</h3>
            <p>₹50.00</p>
            <input type="number" id="burgerQty" value="1" min="1" max="10">
            <button onclick="addToCart('Burger', 50.00, document.getElementById('burgerQty').value)">Add to Cart</button>
        </div>
        <div class="item" data-name="pasta">
            <img src="pasta.jpg" alt="Pasta">
            <h3>Pasta</h3>
            <p>₹80.00</p>
            <input type="number" id="pastaQty" value="1" min="1" max="10">
            <button onclick="addToCart('Pasta', 80.00, document.getElementById('pastaQty').value)">Add to Cart</button>
        </div>

        <%-- Fetching Dynamic Items from Database --%>
        <% 
            Connection con = null;
            Statement stmt = null;
            ResultSet rs = null;
            try {
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                con = DriverManager.getConnection("jdbc:derby://localhost:1527/fooddelivery","app","app");
                stmt = con.createStatement();
                rs = stmt.executeQuery("SELECT * FROM menu");

                while (rs.next()) {
                    String name = rs.getString("food_name");
                    String image = rs.getString("food_image");
                    double price = rs.getDouble("price");
        %>
        <div class="item" data-name="<%= name.toLowerCase() %>">
            <img src="<%= image %>" alt="<%= name %>">
            <h3><%= name %></h3>
            <p>₹<%= price %></p>
            <input type="number" id="<%= name.toLowerCase() %>Qty" value="1" min="1" max="10">
            <button onclick="addToCart('<%= name %>', <%= price %>, document.getElementById('<%= name.toLowerCase() %>Qty').value)">Add to Cart</button>
        </div>
        <% 
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            }
        %>
    </div>

    <script>
        function addToCart(itemName, itemPrice, quantity) {
            let cart = JSON.parse(localStorage.getItem('cart')) || [];
            const item = { name: itemName, price: itemPrice, quantity: parseInt(quantity) };
            
            const existingItemIndex = cart.findIndex(cartItem => cartItem.name === itemName);
            if (existingItemIndex > -1) {
                cart[existingItemIndex].quantity += item.quantity;
            } else {
                cart.push(item);
            }
            
            localStorage.setItem('cart', JSON.stringify(cart));
            alert(`${itemName} (x${quantity}) has been added to your cart!`);
        }

        function filterMenu() {
            const input = document.getElementById('searchInput').value.toLowerCase();
            const items = document.querySelectorAll('.menu-items .item');
            
            items.forEach(item => {
                const name = item.getAttribute('data-name');
                item.style.display = name.toLowerCase().includes(input) ? '' : 'none';
            });
        }
    </script>
</body>
</html>
