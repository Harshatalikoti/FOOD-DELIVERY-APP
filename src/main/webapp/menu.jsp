<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.tap.model.menu" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Restaurant Menu</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f8f9fa;
            min-height: 100vh;
            padding: 20px;
        }

        .header {
            position: sticky;
            top: 0;
            background: white;
            padding: 15px 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            z-index: 100;
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .search-bar {
            flex: 1;
            max-width: 600px;
            margin: 0 20px;
            position: relative;
        }

        .search-bar input {
            width: 100%;
            padding: 12px 40px 12px 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 16px;
            outline: none;
        }

        .search-bar i {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #666;
        }

        .filters {
            display: flex;
            gap: 15px;
            margin-bottom: 30px;
            flex-wrap: wrap;
        }

        .filter-btn {
            padding: 8px 16px;
            border: 1px solid #ddd;
            border-radius: 20px;
            background: white;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .filter-btn:hover {
            background: #f0f0f0;
        }

        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 25px;
            padding: 20px 0;
        }

        .menu-item {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            transition: transform 0.3s ease;
        }

        .menu-item:hover {
            transform: translateY(-5px);
        }

        .menu-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .menu-content {
            padding: 20px;
        }

        .menu-name {
            font-size: 1.2rem;
            margin-bottom: 8px;
            color: #333;
        }

        .menu-rating {
            display: inline-block;
            background: #48c479;
            color: white;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.9rem;
            margin-bottom: 12px;
        }

        .menu-description {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 15px;
            line-height: 1.4;
        }

        .menu-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid #eee;
        }

        .menu-price {
            font-size: 1.2rem;
            font-weight: bold;
            color: #333;
        }

        .quantity-control {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .quantity-control input {
            width: 50px;
            padding: 5px;
            text-align: center;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .add-to-cart {
            background: #fc8019;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 500;
            transition: background 0.3s ease;
        }

        .add-to-cart:hover {
            background: #e67112;
        }

        .cart-icon {
            position: fixed;
            bottom: 30px;
            right: 30px;
            background: #fc8019;
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            text-decoration: none;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            transition: transform 0.3s ease;
        }

        .cart-icon:hover {
            transform: scale(1.1);
        }

        .cart-counter {
            position: absolute;
            top: -5px;
            right: -5px;
            background: #e67112;
            color: white;
            width: 24px;
            height: 24px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.8rem;
            font-weight: bold;
            border: 2px solid white;
        }

        @media (max-width: 768px) {
            .menu-grid {
                grid-template-columns: 1fr;
            }

            .header {
                flex-direction: column;
                gap: 15px;
            }

            .search-bar {
                width: 100%;
                margin: 10px 0;
            }

            .filters {
                justify-content: center;
            }
        }

        .notification {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 15px 25px;
            border-radius: 8px;
            background: #48c479;
            color: white;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            display: none;
            z-index: 1000;
            animation: slideIn 0.3s ease;
        }

        @keyframes slideIn {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }
    </style>
</head>
<body>
    <header class="header">
        <h1>Menu Item</h1>
        <div class="search-bar">
            <input type="text" placeholder="Search for restaurants and food">
            <i class="fas fa-search"></i>
        </div>
    </header>

    <div class="filters">
        <button class="filter-btn">Sort By <i class="fas fa-chevron-down"></i></button>
        <button class="filter-btn">Fast Delivery</button>
        <button class="filter-btn">New</button>
        <button class="filter-btn">Rating 4.0+</button>
    </div>

    <div class="menu-grid">
        <% 
            List<menu> menus = (List<menu>) session.getAttribute("menus");
            if (menus != null && !menus.isEmpty()) {
                for (menu menu : menus) {
        %>
        <div class="menu-item">
            <img src="<%= (menu.getImagePath() != null && !menu.getImagePath().isEmpty()) ? menu.getImagePath() : "default-menu-image.jpg" %>" 
                 alt="<%= menu.getItemName() != null ? menu.getItemName() : "Unnamed Item" %>" class="menu-image">
            <div class="menu-content">
                <h2 class="menu-name"><%= menu.getItemName() != null ? menu.getItemName() : "No Name" %></h2>
                <div class="menu-rating">★ <%= menu.getRating() %></div>
                <p class="menu-description"><%= menu.getDescription() != null ? menu.getDescription() : "No description available" %></p>
                <div class="menu-footer">
                    <p class="menu-price">₹<%= menu.getPrice() %></p>
                    <div class="quantity-control">
                        <input type="number" id="quantity-<%= menu.getMenuId() %>" name="quantity" value="1" min="1">
                        <button type="button" class="add-to-cart" onclick="addToCart(<%= menu.getMenuId() %>, '<%= menu.getItemName() %>', <%= menu.getPrice() %>, document.getElementById('quantity-<%= menu.getMenuId() %>').value)">
                            ADD
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <%
                }
            } else {
        %>
        <p>No restaurants available in your area.</p>
        <%
            }
        %>
    </div>

    <a href="cart.jsp" class="cart-icon">
        <i class="fas fa-shopping-cart"></i>
        <span class="cart-counter" id="cartCounter"><%= session.getAttribute("cartCount") != null ? session.getAttribute("cartCount") : 0 %></span>
    </a>

    <div id="notification" class="notification"></div>

    <script>
    function showNotification(message, isSuccess = true) {
        const notification = document.getElementById('notification');
        notification.style.background = isSuccess ? '#48c479' : '#ff4d4d';
        notification.textContent = message;
        notification.style.display = 'block';
        
        setTimeout(() => {
            notification.style.display = 'none';
        }, 3000);
    }

    function addToCart(menuId, name, price, quantity) {
        const formData = new URLSearchParams();
        formData.append('action', 'add');
        formData.append('menuId', menuId);
        formData.append('name', name);
        formData.append('price', price);
        formData.append('quantity', quantity);

        fetch('${pageContext.request.contextPath}/Menu', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: formData.toString()
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                const cartCounter = document.getElementById('cartCounter');
                const currentCount = parseInt(cartCounter.textContent);
                cartCounter.textContent = currentCount + parseInt(quantity);
                showNotification('Item added to cart successfully!');
            } else {
                showNotification('Failed to add item to cart.', false);
            }
        })
        .catch(error => {
            console.error('Error:', error);
            showNotification('An error occurred while adding the item to the cart.', false);
        });
    }

    </script>
</body>
</html>