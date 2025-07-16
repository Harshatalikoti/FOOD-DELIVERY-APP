<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.tap.model.restaurant" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tap Foods</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Montserrat', sans-serif;
        }

        body {
            background-color: #f8f8f8;
        }

        .cart-icon {
            position: fixed;
            bottom: 2rem;
            right: 2rem;
            background-color: #ff6b00;
            color: white;
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            text-decoration: none;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease, background-color 0.3s ease;
            z-index: 1000;
        }

        .cart-icon:hover {
            transform: scale(1.1);
            background-color: #e65100;
        }

        .top-header {
            background-color: transparent;
            position: absolute;
            width: 100%;
            padding: 20px 40px;
            z-index: 100;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .top-nav {
            display: flex;
            gap: 30px;
        }

        .top-nav a {
            color: white;
            text-decoration: none;
            font-size: 16px;
            font-weight: 500;
        }

        .hero-section {
            height: 540px;
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),
                        url('https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&q=80&w=2070&h=768') center/cover;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            color: white;
            text-align: center;
            padding: 20px;
            margin-bottom: 40px;
        }

        .logo {
            font-size: 52px;
            font-weight: 700;
            margin-bottom: 20px;
            letter-spacing: 1px;
        }

        .hero-text {
            font-size: 36px;
            margin-bottom: 30px;
            max-width: 800px;
        }

        .search-container {
            position: relative;
            display: flex;
            max-width: 800px;
            width: 100%;
            background: white;
            border-radius: 8px;
            overflow: hidden;
        }

        .location-select {
            width: 30%;
            padding: 16px;
            border: none;
            border-right: 1px solid #e0e0e0;
            font-size: 16px;
            outline: none;
        }

        .search-input {
            width: 70%;
            padding: 16px;
            border: none;
            font-size: 16px;
            outline: none;
        }

        .categories {
            display: flex;
            justify-content: center;
            gap: 30px;
            padding: 60px 40px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .category-card {
            flex: 1;
            max-width: 360px;
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
            text-decoration: none;
            color: inherit;
        }

        .category-card:hover {
            transform: translateY(-5px);
        }

        .category-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .category-content {
            padding: 20px;
        }

        .category-title {
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 8px;
            color: #1c1c1c;
        }

        .category-description {
            font-size: 14px;
            color: #666;
            line-height: 1.5;
        }

        /* Updated Restaurant Section Styles */
        .restaurants-section {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 20px;
        }

        .section-title {
            font-size: 28px;
            font-weight: 600;
            color: #1c1c1c;
            margin-bottom: 30px;
            text-align: center;
        }

         .restaurant-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            padding: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .restaurant-card {
            position: relative;
            background: white;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
            cursor: pointer;
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
        }

        .restaurant-content {
            width: 100%;
            padding: 20px;
        }

        .restaurant-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-bottom: 1px solid #ddd;
        }

        .restaurant-info {
            margin-top: 10px;
        }

        .restaurant-name {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 5px;
        }

        .restaurant-type {
            font-size: 16px;
            color: #777;
            margin-bottom: 10px;
        }

        .restaurant-meta {
            display: flex;
            justify-content: center;
            gap: 10px;
            align-items: center;
        }

        .rating-badge {
            background: #ff6b00;
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            font-weight: 600;
        }

        .status-badge {
            background: #28a745;
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
        }

        .restaurant-location, .delivery-time {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 5px;
            margin-top: 5px;
            font-size: 14px;
            color: #666;
        }

        .restaurant-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        @media (max-width: 768px) {
            .restaurant-grid {
                grid-template-columns: 1fr;
                padding: 16px;
            }
        }

        .popup-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.85);
            display: flex;
            align-items: center;
            justify-content: center;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease;
            z-index: 2;
        }

        .restaurant-card:hover .popup-overlay {
            opacity: 1;
            visibility: visible;
        }

        .popup-content {
            color: white;
            text-align: center;
            padding: 20px;
            transform: translateY(20px);
            transition: all 0.3s ease;
        }

        .restaurant-card:hover .popup-content {
            transform: translateY(0);
        }

        .popup-content h3 {
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .popup-content p {
            font-size: 14px;
            margin-bottom: 16px;
            color: #e0e0e0;
        }

        .popup-details {
            margin: 20px 0;
            text-align: left;
        }

        .popup-details p {
            margin: 8px 0;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .popup-details i {
            color: #ff6b00;
        }

        .popup-button {
            display: inline-block;
            background: #ff6b00;
            color: white;
            padding: 12px 24px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
            transition: background 0.3s ease;
        }

        .popup-button:hover {
            background: #e65100;
        }

        /* Add media query for mobile devices */
        @media (max-width: 768px) {
            .popup-overlay {
                display: none;
            }
        }
        .dot {
            color: #999;
        }

        .view-menu-overlay {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            background: #ff6b00;
            color: white;
            text-align: center;
            padding: 12px;
            text-decoration: none;
            font-weight: 500;
            opacity: 0;
            transition: opacity 0.2s ease;
        }

        .restaurant-card:hover .view-menu-overlay {
            opacity: 1;
        }

        @media (max-width: 768px) {
            .hero-text {
                font-size: 28px;
            }

            .search-container {
                flex-direction: column;
            }

            .location-select,
            .search-input {
                width: 100%;
            }

            .categories {
                flex-direction: column;
                align-items: center;
            }

            .category-card {
                width: 100%;
            }

            .restaurant-grid {
                grid-template-columns: 1fr;
                padding: 16px;
            }

            .cart-icon {
                bottom: 1rem;
                right: 1rem;
                width: 50px;
                height: 50px;
                font-size: 1.2rem;
            }
        }
    </style>
</head>
<body>
    <header class="top-header">
        <div class="top-nav">
            <a href="#">Get the App</a>
        </div>
        <div class="top-nav">
            <a href="#">Investor Relations</a>
            <a href="#">Add restaurant</a>
            <a href="login.jsp">Log in</a>
            <a href="signup.jsp">Sign up</a>
        </div>
    </header>

    <a href="cart.jsp" class="cart-icon">
        <i class="fas fa-shopping-cart"></i>
    </a>

    <section class="hero-section">
        <h1 class="logo">tap foods</h1>
        <h2 class="hero-text">Discover the best food & drinks in Bengaluru</h2>
        <div class="search-container">
            <select class="location-select" id="location-select">
                <option value="bengaluru">Bengaluru</option>
                <option value="mumbai">Mumbai</option>
                <option value="delhi">Delhi</option>
            </select>
            <input type="text" class="search-input" id="search-input" 
                   placeholder="Search for restaurant, cuisine or a dish"
                   autocomplete="off">
        </div>
    </section>

    <section class="categories">
        <a href="#" class="category-card">
            <img src="https://media.istockphoto.com/id/1324465031/photo/high-angle-view-close-up-asian-woman-using-meal-delivery-service-ordering-food-online-with.jpg?s=1024x1024&w=is&k=20&c=SBTB9mNIoDe1Ua6OrZfnpY2ad52OdXdTfuRRM2IzVHI=" 
                 alt="Order Online" 
                 class="category-image">
            <div class="category-content">
                <h3 class="category-title">Order Online</h3>
                <p class="category-description">Stay home and order to your doorstep</p>
            </div>
        </a>

        <a href="#" class="category-card">
            <img src="https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&q=80&w=500&h=300" 
                 alt="Dining" 
                 class="category-image">
            <div class="category-content">
                <h3 class="category-title">Dining</h3>
                <p class="category-description">View the city's favourite dining venues</p>
            </div>
        </a>

        <a href="#" class="category-card">
            <img src="https://images.unsplash.com/photo-1514525253161-7a46d19cd819?auto=format&fit=crop&q=80&w=500&h=300" 
                 alt="Live Events" 
                 class="category-image">
            <div class="category-content">
                <h3 class="category-title">Live Events</h3>
                <p class="category-description">Discover India's best events & concerts</p>
            </div>
        </a>
    </section>

    <section class="restaurants-section">
    <h2 class="section-title">Restaurants Near You</h2>
    <div class="restaurant-grid">
        <% List<restaurant> restaurants = (List<restaurant>) request.getAttribute("restaurants"); %>
        <% if (restaurants != null && !restaurants.isEmpty()) { %>
            <% for (restaurant r : restaurants) { %>
                <div class="restaurant-card">
                    <div class="restaurant-content">
                        <img src="<%=r.getImagePath()%>" alt="<%=r.getName()%>" class="restaurant-image">
                        <div class="restaurant-info">
                            <h3 class="restaurant-name"><%=r.getName()%></h3>
                            <p class="restaurant-type"><%=r.getCusineType()%></p>
                            <div class="restaurant-meta">
                                <span class="rating-badge">
                                    <span>★</span>
                                    <span><%=r.getRating()%></span>
                                </span>
                                <span class="status-badge">Open Now</span>
                            </div>
                            <div class="restaurant-location">
                                <i class="fas fa-map-marker-alt"></i>
                                <span><%=r.getAddress()%></span>
                            </div>
                            <div class="delivery-time">
                                <i class="far fa-clock"></i>
                                <span><%=r.getEta()%> mins</span>
                            </div>
                        </div>
                    </div>
                    <div class="popup-overlay">
                        <div class="popup-content">
                            <h3><%=r.getName()%></h3>
                            <p><%=r.getCusineType()%></p>
                            <div class="popup-details">
                                <p><i class="fas fa-star"></i> <%=r.getRating()%> Rating</p>
                                <p><i class="fas fa-clock"></i> <%=r.getEta()%> mins delivery</p>
                                <p><i class="fas fa-map-marker-alt"></i> <%=r.getAddress()%></p>
                            </div>
                            <a href="Menu?restaurantId=<%=r.getRestaurantId()%>" class="popup-button">View Menu</a>
                        </div>
                    </div>
                </div>
            <% } %>
        <% } else { %>
            <p style="text-align: center; color: red;">No restaurants available.</p>
        <% } %>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Prevent popup from showing on mobile devices
            if (window.innerWidth > 768) {
                const restaurantCards = document.querySelectorAll('.restaurant-card');
                
                restaurantCards.forEach(card => {
                    card.addEventListener('mouseenter', function() {
                        this.querySelector('.popup-overlay').style.opacity = '1';
                        this.querySelector('.popup-overlay').style.visibility = 'visible';
                    });
                    
                    card.addEventListener('mouseleave', function() {
                        this.querySelector('.popup-overlay').style.opacity = '0';
                        this.querySelector('.popup-overlay').style.visibility = 'hidden';
                    });
                });
            }
        });
    </script>
</body>
</html>
