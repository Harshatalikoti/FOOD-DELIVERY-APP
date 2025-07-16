<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.tap.dao.Cart" %>
<%@ page import="com.tap.model.CartItem" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Cart</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* --- CSS Styles (unchanged from your provided code) --- */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        body {
            background-color: #f8f8f8;
            min-height: 100vh;
            padding: 2rem;
        }
        header {
            background: linear-gradient(135deg, #ff6b00, #ff8533);
            color: white;
            padding: 2rem;
            border-radius: 15px;
            margin-bottom: 2rem;
            box-shadow: 0 4px 15px rgba(255, 107, 0, 0.2);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .header-content {
            display: flex;
            align-items: center;
            gap: 2rem;
        }
        .home-icon {
            color: white;
            font-size: 1.8rem;
            text-decoration: none;
            transition: transform 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        .home-icon:hover {
            transform: scale(1.1);
        }
        .home-icon span {
            font-size: 1rem;
            font-weight: 500;
        }
        h1 {
            font-size: 2.5rem;
            font-weight: 700;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
        }
        .view-menu {
            background-color: white;
            color: #ff6b00;
            text-decoration: none;
            padding: 0.8rem 1.5rem;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }
        .view-menu:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }
        table {
            width: 100%;
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            border-collapse: collapse;
            margin-bottom: 2rem;
        }
        thead {
            background-color: #1a1a1a;
            color: white;
        }
        th {
            padding: 1.5rem;
            text-align: left;
            font-weight: 600;
            font-size: 1.1rem;
        }
        td {
            padding: 1.2rem 1.5rem;
            border-bottom: 1px solid #eee;
            vertical-align: middle;
        }
        tr:last-child td {
            border-bottom: none;
        }
        tbody tr:hover {
            background-color: #fff8f3;
        }
        input[type="number"] {
            width: 80px;
            padding: 0.7rem;
            border: 2px solid #ddd;
            border-radius: 8px;
            margin-right: 0.8rem;
            font-size: 1rem;
            transition: border-color 0.3s ease;
        }
        input[type="number"]:focus {
            outline: none;
            border-color: #ff6b00;
        }
        button {
            background-color: #ff6b00;
            color: white;
            border: none;
            padding: 0.7rem 1.2rem;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
            font-size: 0.95rem;
        }
        button:hover {
            background-color: #e65100;
            transform: translateY(-2px);
        }
        button[type="submit"][value="remove"] {
            background-color: #1a1a1a;
        }
        button[type="submit"][value="remove"]:hover {
            background-color: #333;
        }
        .total-section {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            text-align: right;
            font-size: 1.5rem;
            font-weight: 700;
            color: #1a1a1a;
            margin-bottom: 2rem;
        }
        .total-section span {
            color: #ff6b00;
            margin-left: 1rem;
            font-size: 1.8rem;
        }
        .empty-cart {
            text-align: center;
            padding: 3rem;
            color: #666;
            font-size: 1.2rem;
        }
        .checkout-container {
            display: flex;
            justify-content: flex-end; /* Align to the right */
            padding: 0 1rem;
            margin-top: 1rem; /* Add some spacing */
        }
        .checkout-button {
            background: linear-gradient(135deg, #ff6b00, #ff8533);
            color: white;
            border: none;
            padding: 1.2rem 3rem;
            border-radius: 12px;
            font-size: 1.2rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 1px;
            box-shadow: 0 4px 15px rgba(255, 107, 0, 0.2);
            display: flex;
            align-items: center;
            gap: 0.8rem;
        }
        .checkout-button:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(255, 107, 0, 0.3);
            background: linear-gradient(135deg, #ff8533, #ff6b00);
        }
        .checkout-button:active {
            transform: translateY(-1px);
        }
        .checkout-button i {
            font-size: 1.4rem;
        }
        @media (max-width: 768px) {
            body {
                padding: 1rem;
            }
            header {
                flex-direction: column;
                gap: 1.5rem;
                text-align: center;
                padding: 1.5rem;
            }
            .header-content {
                flex-direction: column;
                gap: 1rem;
            }
            h1 {
                font-size: 2rem;
            }
            table {
                display: block;
                overflow-x: auto;
                white-space: nowrap;
            }
            th, td {
                padding: 1rem;
            }
            .total-section {
                text-align: center;
                font-size: 1.2rem;
            }
            .checkout-container {
                justify-content: center;
            }
            .checkout-button {
                width: 100%;
                justify-content: center;
                padding: 1rem 2rem;
            }
        }
     </style>
</head>
<body>
    <header>
        <div class="header-content">
            <a href="homeServlet" class="home-icon">
                <i class="fas fa-home"></i>
                <span>Back to Home</span>
            </a>
            <h1>Your Cart</h1>
        </div>
        <nav>
            <a href="menu.jsp" class="view-menu">Back to Menu</a>
        </nav>
    </header>

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
                Cart cart = (Cart) session.getAttribute("cart");
                if (cart == null || cart.getItems().isEmpty()) {
            %>
            <tr>
                <td colspan="5" class="empty-cart">Your cart is empty.</td>
            </tr>
            <%
                } else {
                    for (CartItem item : cart.getItems().values()) {
            %>
            <tr>
                <td><%= item.getName() %></td>
                <td>₹<%= item.getPrice() %></td>
                <td>
                    <form action="cartAction" method="post">
				    <input type="hidden" name="action" value="update">
				    <input type="hidden" name="menuId" value="<%= item.getMenuId() %>">
				    <input type="hidden" name="restaurantId" value="<%= session.getAttribute("restaurantId") %>">
				    <input type="number" name="quantity" value="<%= item.getQuantity() %>" min="1" required>
				    <button type="submit">Update</button>
				</form>

                </td>
                <td>₹<%= item.getPrice() * item.getQuantity() %></td>
                <td>
                    <form action="cartAction" method="post">
				    <input type="hidden" name="action" value="remove">
				    <input type="hidden" name="menuId" value="<%= item.getMenuId() %>">
				    <input type="hidden" name="restaurantId" value="<%= session.getAttribute("restaurantId") %>">
				    <button type="submit">Remove</button>
				</form>

                </td>
            </tr>
            <%
                    }
                }
            %>
        </tbody>
    </table>

    <% if (cart != null && !cart.getItems().isEmpty()) { %>
    <div class="total-section">
        Total: <span>₹<%= cart.calculateTotalPrice() %></span>
    </div>
    <div class="checkout-container">
        <form action="login.jsp" method="post">
            <input type="hidden" name="action" value="checkout">
            <button type="submit" class="checkout-button">
                <i class="fas fa-shopping-cart"></i> Checkout
            </button>
        </form>
    </div>
    <% } %>
</body>
</html>