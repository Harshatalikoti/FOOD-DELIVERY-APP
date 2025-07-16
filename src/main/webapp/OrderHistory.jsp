<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "com.tap.daoimplementation.OrderHistoryImpl" %>
<%@ page import = "com.tap.model.OrderHistory" %>
<%@ page import = "java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order History</title>

<!-- Add CSS for the card layout -->
<style>
    /* Basic body and font styling */
    body {
        font-family: 'Arial', sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f9f9f9;
        color: #333;
    }
    .container {
        max-width: 1100px;
        margin: 30px auto;
        padding: 20px;
        background-color: #fff;
        border-radius: 12px;
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
    }
    h1 {
        font-size: 34px;
        font-weight: 700;
        margin-bottom: 30px;
        text-align: center;
        color: #2c3e50;wwwww
    }

    /* Card container styling */
    .card-container {
        display: flex;
        flex-wrap: wrap;
        gap: 20px;
        justify-content: center;
    }

    /* Order card styling */
    .order-card {
        background-color: #fff;
        border: 1px solid #ddd;
        border-radius: 8px;
        padding: 20px;
        width: 280px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        text-align: left;
    }

    .order-card h2 {
        font-size: 20px;
        color: #2c3e50;
        margin-bottom: 10px;
    }

    .order-card p {
        font-size: 16px;
        color: #555;
        margin: 8px 0;
    }

    .view-details-button {
        display: inline-block;
        margin-top: 15px;
        padding: 10px 20px;
        background-color: #3498db;
        color: #fff;
        border-radius: 5px;
        text-decoration: none;
        text-align: center;
        transition: background-color 0.3s ease;
    }
    .view-details-button:hover {
        background-color: #1c5d77;
    }

    /* Empty order history message */
    .empty-message {
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
        height: 350px;
        text-align: center;
        color: #7f8c8d;
        margin-top: 50px;
    }
    .empty-message img {
        max-width: 180px;
        margin-bottom: 30px;
    }
    .empty-message h1 {
        font-size: 28px;
        font-weight: 600;
        color: #34495e;
        margin-bottom: 15px;
    }
    .empty-message p {
        font-size: 18px;
        color: #7f8c8d;
        margin-bottom: 25px;
    }
    .empty-message .btn {
        padding: 12px 25px;
        font-size: 18px;
        background-color: #2ecc71;
        border-radius: 6px;
        color: #fff;
        text-decoration: none;
        transition: background-color 0.3s ease;
    }
    .empty-message .btn:hover {
        background-color: #27ae60;
    }

    /* Responsive styling */
    @media (max-width: 768px) {
        .order-card {
            width: 100%;
        }
    }

</style>

</head>
<body>
<div class="container">
    <h1>Your Order History</h1>
    
    <!-- Display orders as cards -->
    <div class="card-container">
        <% 
        int userId = (int)session.getAttribute("userId");
        OrderHistoryImpl oh = new OrderHistoryImpl();
        List<OrderHistory> list = oh.fechOnUserId(userId);
        
        if(list != null && !list.isEmpty()) {
        %>
        
        <% 
        // Loop through the list and display each order as a card
        for (OrderHistory o : list) {
            int orderId = o.getOrderHistoryId(); // Assuming this method exists
            String orderDate = o.getDate(); // Assuming this method exists
            double totalAmount = o.getTotal(); // Assuming this method exists
            String status = o.getStatus(); // Assuming this method exists
        %>
        <div class="order-card">
            <h2>Order ID: <%= orderId %></h2>
            <p><strong>Date:</strong> <%= orderDate %></p>
            <p><strong>Total:</strong> ₹<%= totalAmount %></p>
            <p><strong>Status:</strong> <%= status %></p>
            <a href="OrderDetails.jsp?orderId=<%= orderId %>" class="view-details-button">View Details</a>
        </div>
        <% 
        }
        %>
        
        <% 
        } else {  // Else block if the list is null or empty
        %>
        
        <!-- Empty order history message with image -->
        <div class="empty-message">
            <img src="https://img.icons8.com/ios/452/shopping-cart.png" alt="Empty Cart">
            <h1>Your order history is empty</h1>
            <p>It looks like you haven't placed any orders yet. Start exploring the menu and place your first order.</p>
            <a href="homee.jsp" class="btn">Browse Menu</a>
        </div>
        
        <% 
        }
        %>
    </div> <!-- Close card-container div -->

</body>
</html>
