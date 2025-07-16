<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="com.tap.dao.Cart" %>
<%@ page import="com.tap.model.CartItem" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Confirmation</title>
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: url('https://images.unsplash.com/photo-1555396273-367ea4eb4db5?auto=format&fit=crop&q=80') center/cover no-repeat fixed;
            padding: 20px;
        }

        .container {
            width: 100%;
            max-width: 600px;
            padding: 20px;
        }

        .confirmation-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            text-align: center;
            animation: slideIn 0.6s ease-out;
        }

        @keyframes slideIn {
            from {
                transform: translateY(30px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        /* Checkmark Animation */
        .success-checkmark {
            width: 80px;
            height: 80px;
            margin: 0 auto 30px;
            position: relative;
        }

        .check-icon {
            width: 80px;
            height: 80px;
            position: relative;
            border-radius: 50%;
            box-sizing: content-box;
            border: 4px solid #4CAF50;
        }

        .check-icon::before {
            top: 3px;
            left: -2px;
            width: 30px;
            transform-origin: 100% 50%;
            border-radius: 100px 0 0 100px;
        }

        .check-icon::after {
            top: 0;
            left: 30px;
            width: 60px;
            transform-origin: 0 50%;
            border-radius: 0 100px 100px 0;
            animation: rotate-circle 4.25s ease-in;
        }

        .check-icon::before, .check-icon::after {
            content: '';
            height: 100px;
            position: absolute;
            background: #FFFFFF;
            transform: rotate(-45deg);
        }

        .icon-line {
            height: 5px;
            background-color: #4CAF50;
            display: block;
            border-radius: 2px;
            position: absolute;
            z-index: 10;
        }

        .line-tip {
            top: 46px;
            left: 14px;
            width: 25px;
            transform: rotate(45deg);
            animation: icon-line-tip 0.75s;
        }

        .line-long {
            top: 38px;
            right: 8px;
            width: 47px;
            transform: rotate(-45deg);
            animation: icon-line-long 0.75s;
        }

        .icon-circle {
            top: -4px;
            left: -4px;
            z-index: 10;
            width: 80px;
            height: 80px;
            border-radius: 50%;
            position: absolute;
            box-sizing: content-box;
            border: 4px solid rgba(76, 175, 80, .5);
        }

        .icon-fix {
            top: 8px;
            width: 5px;
            left: 26px;
            z-index: 1;
            height: 85px;
            position: absolute;
            transform: rotate(-45deg);
            background-color: #FFFFFF;
        }

        @keyframes rotate-circle {
            0% {
                transform: rotate(-45deg);
            }
            5% {
                transform: rotate(-45deg);
            }
            12% {
                transform: rotate(-405deg);
            }
            100% {
                transform: rotate(-405deg);
            }
        }

        @keyframes icon-line-tip {
            0% {
                width: 0;
                left: 1px;
                top: 19px;
            }
            54% {
                width: 0;
                left: 1px;
                top: 19px;
            }
            70% {
                width: 50px;
                left: -8px;
                top: 37px;
            }
            84% {
                width: 17px;
                left: 21px;
                top: 48px;
            }
            100% {
                width: 25px;
                left: 14px;
                top: 46px;
            }
        }

        @keyframes icon-line-long {
            0% {
                width: 0;
                right: 46px;
                top: 54px;
            }
            65% {
                width: 0;
                right: 46px;
                top: 54px;
            }
            84% {
                width: 55px;
                right: 0px;
                top: 35px;
            }
            100% {
                width: 47px;
                right: 8px;
                top: 38px;
            }
        }

        .content {
            padding: 20px 0;
        }

        h1 {
            color: #2d3436;
            font-size: 2.2rem;
            margin-bottom: 15px;
            animation: fadeIn 0.8s ease-out;
        }

        .greeting {
            color: #636e72;
            font-size: 1.2rem;
            margin-bottom: 30px;
        }

        .customer-name {
            color: #2d3436;
            font-weight: 600;
        }

        .order-details {
            background: rgba(255, 255, 255, 0.9);
            border-radius: 12px;
            padding: 25px;
            margin: 20px 0;
            text-align: left;
        }

        .detail-item {
            display: flex;
            align-items: flex-start;
            margin-bottom: 15px;
            padding: 10px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .detail-item:hover {
            background: rgba(236, 240, 241, 0.6);
        }

        .detail-item i {
            font-size: 1.5rem;
            color: #e17055;
            margin-right: 15px;
            min-width: 24px;
        }

        .detail-item span {
            color: #2d3436;
            font-size: 1rem;
            line-height: 1.5;
        }

        .actions {
            margin-top: 30px;
        }

        .back-btn {
            display: inline-flex;
            align-items: center;
            padding: 12px 24px;
            background: #e17055;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .back-btn:hover {
            background: #d15a45;
            transform: translateY(-2px);
        }

        .back-btn i {
            margin-right: 8px;
            font-size: 1.2rem;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        @media (max-width: 480px) {
            .container {
                padding: 10px;
            }

            .confirmation-card {
                padding: 20px;
            }

            h1 {
                font-size: 1.8rem;
            }

            .greeting {
                font-size: 1.1rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="confirmation-card">
            <div class="success-checkmark">
                <div class="check-icon">
                    <span class="icon-line line-tip"></span>
                    <span class="icon-line line-long"></span>
                    <div class="icon-circle"></div>
                    <div class="icon-fix"></div>
                </div>
            </div>

            <div class="content">
                <h1>Order Confirmed!</h1>
               <p class="greeting">Thank you, <span class="customer-name">
				<% 
				    String receiverName = (String) request.getAttribute("receiverName");
				    if (receiverName == null) receiverName = "Guest";
				%>
				<%= receiverName %>
			</span>!</p>

                <div class="order-details">
                    <div class="detail-item">
                        <i class='bx bx-time-five'></i>
                        <span>Estimated Delivery Time: 30-45 minutes</span>
                    </div>
                    <div class="detail-item">
                        <i class='bx bx-map'></i>
                        <span>Delivery Address:<br>
                            <%= request.getAttribute("customerAddress") != null ? request.getAttribute("customerAddress") : "Not provided" %>
                        </span>
                    </div>
                    <div class="detail-item">
                        <i class='bx bx-phone'></i>
                        <span>Contact Number: 
                            <%= request.getAttribute("receiverPhone") != null ? request.getAttribute("receiverPhone") : "Not provided" %>
                        </span>
                    </div>
                </div>

                <div class="actions">
                    <a href="homee.jsp" class="back-btn">
                        <i class='bx bx-restaurant'></i>
                        Browse Restaurants
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Add a class to trigger animations when the page loads
        document.addEventListener('DOMContentLoaded', function() {
            document.querySelector('.confirmation-card').classList.add('show');
        });
    </script>
</body>
</html>