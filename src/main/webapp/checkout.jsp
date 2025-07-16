<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.tap.dao.Cart" %>
<%@ page import="com.tap.model.CartItem" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout</title>
    <link rel="stylesheet" href="./checkout.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
</head>
<body>
    <div class="navbar">
        <h1>Checkout</h1>
        <div class="nav-buttons">
            <a href="homeServlet" class="nav-btn">
                <span class="material-icons">home</span>
                Home
            </a>
            <a href="cart.jsp" class="nav-btn">
                <span class="material-icons">shopping_cart</span>
                Cart
            </a>
        </div>
    </div>

    <div class="checkout-container">
        <%
            Cart cart = (Cart) session.getAttribute("cart");
            if (cart == null || cart.getItems() == null || cart.getItems().isEmpty()) {
        %>
            <div class="empty-cart">
                <p>Your cart is empty</p>
                <a href="menu.jsp">
                    <span class="material-icons">restaurant_menu</span>
                    Browse Menu
                </a>
            </div>
        <%
            } else {
        %>
        <h3>Grand Total: ₹<%= cart.calculateTotalPrice() %></h3>

        <!-- Order Form -->
        <form id="checkoutForm" action="CheckoutSer" method="post">
            <div class="form-group">
                <label for="receiverName">Receiver Name</label>
                <input type="text" id="receiverName" name="receiverName" required>
            </div>
            <div class="form-group">
                <label for="receiverPhone">Phone Number</label>
                <input type="text" id="receiverPhone" name="receiverPhone" required 
                       pattern="[0-9]{10}" title="Please enter a valid 10-digit phone number">
            </div>
            <div class="form-group">
                <label for="customerAddress">Address</label>
                <textarea id="customerAddress" name="customerAddress" rows="3" required></textarea>
            </div>
            <div class="form-group">
                <label for="paymentMethod">Payment Method</label>
                <select id="paymentMethod" name="paymentMethod" required>
                    <option value="Cash on Delivery">Cash on Delivery</option>
                    <option value="Credit Card">Credit Card</option>
                    <option value="UPI">UPI</option>
                </select>
            </div>
            <button type="submit" class="confirm-btn">
                <span class="material-icons">check_circle</span>
                Confirm Order
            </button>
            <button type="button" class="cancel-btn" onclick="window.location.href='cart.jsp'">
                <span class="material-icons">cancel</span>
                Cancel
            </button>
        </form>
        <%
            }
        %>
    </div>
</body>
</html>
