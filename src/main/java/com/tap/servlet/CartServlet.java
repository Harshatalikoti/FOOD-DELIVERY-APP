package com.tap.servlet;

import java.io.IOException;
import com.tap.dao.Cart;
import com.tap.model.CartItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cartAction")
public class CartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        // Get or create cart
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        // Get restaurantId from session or from request parameter
        Integer restaurantId = null;
        try {
            Object sessionRestId = session.getAttribute("restaurantId");
            if (sessionRestId != null) {
                restaurantId = (Integer) sessionRestId;
            } else {
                restaurantId = Integer.parseInt(req.getParameter("restaurantId"));
                session.setAttribute("restaurantId", restaurantId);
            }
        } catch (Exception e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Restaurant ID is required.");
            return;
        }

        String action = req.getParameter("action");
        int menuId = 0;
        try {
            menuId = Integer.parseInt(req.getParameter("menuId"));
        } catch (Exception e) {
            // ignore parse error for add action because menuId may be missing or invalid
        }

        if ("add".equals(action)) {
            try {
                String itemName = req.getParameter("name");
                double price = Double.parseDouble(req.getParameter("price"));
                int quantity = Integer.parseInt(req.getParameter("quantity"));
                cart.addCartItem(menuId, itemName, price, quantity);
            } catch (Exception e) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid input for add operation.");
                return;
            }
        } else if ("remove".equals(action)) {
            cart.removeCartItem(menuId);
        } else if ("update".equals(action)) {
            try {
                int newQuantity = Integer.parseInt(req.getParameter("quantity"));
                cart.updateCartItem(menuId, newQuantity);
            } catch (NumberFormatException e) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid quantity format.");
                return;
            }
        }

        // Optionally update the cart item count attribute
        session.setAttribute("cartItemCount", cart.getItems().size());

        // Redirect to cart.jsp after action
        resp.sendRedirect(req.getContextPath() + "/cart.jsp");
    }
}
