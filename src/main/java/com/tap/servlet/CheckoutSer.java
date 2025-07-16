package com.tap.servlet;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.tap.daoimplementation.OrderDaoImpl;
import com.tap.daoimplementation.orderItemDaoImpl;
import com.tap.model.order;
import com.tap.model.OrderItem;
import com.tap.dao.Cart;
import com.tap.model.CartItem;

@WebServlet("/CheckoutSer")
public class CheckoutSer extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Debug log (optional)
        System.out.println("------ CheckoutSer Execution ------");

        Integer userId = (Integer) session.getAttribute("userId");
        Integer restaurantId = (Integer) session.getAttribute("restaurantId");
        Cart cart = (Cart) session.getAttribute("cart");

        // Debug checks
        System.out.println("UserId: " + userId);
        System.out.println("RestaurantId: " + restaurantId);
        System.out.println("Cart is null? " + (cart == null));
        System.out.println("Cart Items null? " + (cart != null && cart.getItems() == null));
        System.out.println("Cart Empty? " + (cart != null && cart.getItems() != null && cart.getItems().isEmpty()));

        // Check login
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Check cart
        if (restaurantId == null || cart == null || cart.getItems() == null || cart.getItems().isEmpty()) {
            response.sendRedirect("cart.jsp");
            return;
        }

        // Form inputs
        String receiverName = request.getParameter("receiverName");
        String receiverPhone = request.getParameter("receiverPhone");
        String customerAddress = request.getParameter("customerAddress");
        String paymentMethod = request.getParameter("paymentMethod");

        double totalAmount = cart.calculateTotalPrice();

        // Create and save order
        order order = new order();
        order.setUserId(userId);
        order.setRestaurantId(restaurantId);
        order.setOrderDate(Date.valueOf(LocalDate.now()));
        order.setTotalAmount(totalAmount);
        order.setStatus("Pending");
        order.setPaymentMode(paymentMethod);

        OrderDaoImpl orderDAO = new OrderDaoImpl();
        int orderId = orderDAO.addOrder(order); // Get generated order ID

        // Save order items
        orderItemDaoImpl orderItemDAO = new orderItemDaoImpl();
        for (CartItem cartItem : cart.getItems().values()) {
            double itemTotal = cartItem.getPrice() * cartItem.getQuantity();

            OrderItem orderItem = new OrderItem();
            orderItem.setOrder1Id(orderId);
            orderItem.setMenuId(cartItem.getMenuId());
            orderItem.setQuantity(cartItem.getQuantity());
            orderItem.setTotalPrice(itemTotal);

            orderItemDAO.insertOrderItem(orderItem);
        }

        // Clear cart after order is placed
        session.removeAttribute("cart");

        // Forward to success page (you can also use sendRedirect if needed)
        request.setAttribute("receiverName", receiverName);
        request.setAttribute("receiverPhone", receiverPhone);
        request.setAttribute("customerAddress", customerAddress);
        request.setAttribute("paymentMethod", paymentMethod);
//        response.sendRedirect("success.jsp");

        request.getRequestDispatcher("success.jsp").forward(request, response);
    }
}
