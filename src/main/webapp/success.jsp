<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Successful</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7fc;
            color: #333;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            text-align: center;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 80%;
            max-width: 500px;
        }

        h1 {
            color: #4CAF50;
            font-size: 2.5rem;
            margin-bottom: 20px;
        }

        .message {
            font-size: 1.2rem;
            color: #555;
            margin-bottom: 20px;
        }

        .success-image {
            width: 100px;
            height: 100px;
            margin-bottom: 20px;
        }

        .button {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            font-size: 1rem;
            margin-top: 20px;
            display: inline-block;
        }

        .button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Success Image -->
        <img src="https://www.pngmart.com/files/20/Success-PNG-HD.png" alt="Success" class="success-image">
        
        <!-- Success Message -->
        <h1>Order Successful!</h1>
        <p class="message">Thank you for your purchase! Your order has been successfully processed.</p>
        
        <!-- Button to continue or view orders -->
        <a href="Home.jsp" class="button">Go to Home</a>
    </div>
</body>
</html>
