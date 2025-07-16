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
    <link rel="stylesheet" href="css/styles.css">
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
            <jsp:include page="homee.jsp" />
        </div>
    </section>

    <script src="js/main.js"></script>
</body>
</html>