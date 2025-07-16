package com.tap.servlet;

import java.io.IOException;
import java.util.List;

import com.tap.daoimplementation.menuDaoImpl;
import com.tap.daoimplementation.RestaurantDaoImpl;
import com.tap.model.menu;
import com.tap.model.restaurant;
import com.tap.dao.Cart;
import com.tap.model.CartItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/Menu")
public class MenuServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String restaurantIdParam = req.getParameter("restaurantId");

        // ✅ Debugging: Print received parameters
        System.out.println("Received restaurantId: " + restaurantIdParam);

        if (restaurantIdParam == null || restaurantIdParam.trim().isEmpty()) {
            req.setAttribute("errorMessage", "Restaurant ID is required.");
            req.getRequestDispatcher("menu.jsp").forward(req, resp);
            return;
        }

        try {
            int resId = Integer.parseInt(restaurantIdParam);

            // ✅ Debugging: Check if ID is parsed correctly
            System.out.println("Parsed restaurantId: " + resId);

            // Initialize DAOs
            menuDaoImpl menuDaoImp = new menuDaoImpl();
            RestaurantDaoImpl restaurantDaoImp = new RestaurantDaoImpl();

            // Fetch restaurant details
            restaurant restaurantById = restaurantDaoImp.getRestaurant(resId);
            if (restaurantById == null) {
                req.setAttribute("errorMessage", "Restaurant not found.");
                req.getRequestDispatcher("menu.jsp").forward(req, resp);
                return;
            }

            String resName = restaurantById.getName();

            // Fetch menu items for the restaurant
            List<menu> menuList = menuDaoImp.getMenuByrestaurant(resId); 

            // ✅ Debugging: Print retrieved menu size
            System.out.println("Menu items found: " + (menuList != null ? menuList.size() : 0));

            // Set attributes in session
            HttpSession session = req.getSession();
            session.setAttribute("menus", menuList);
            session.setAttribute("resName", resName);
            session.setAttribute("resId", resId);

            // Forward to JSP
            req.getRequestDispatcher("menu.jsp").forward(req, resp);

        } catch (NumberFormatException e) {
            System.err.println("Invalid Restaurant ID format: " + restaurantIdParam);
            req.setAttribute("errorMessage", "Invalid Restaurant ID format.");
            req.getRequestDispatcher("menu.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorMessage", "An unexpected error occurred.");
            req.getRequestDispatcher("menu.jsp").forward(req, resp);
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("Entering doPost method"); // Log entry point

        // Log all parameters received
        System.out.println("Request Parameters:");
        req.getParameterMap().forEach((key, values) -> {
            System.out.println(key + ": " + String.join(", ", values));
        });

        String action = req.getParameter("action");

        if ("add".equals(action)) {
            try {
                System.out.println("Processing 'add' action"); // Log action

                // Retrieve parameters
                int menuId = Integer.parseInt(req.getParameter("menuId"));
                String name = req.getParameter("name");
                double price = Double.parseDouble(req.getParameter("price"));
                int quantity = Integer.parseInt(req.getParameter("quantity"));

                System.out.println("Received parameters - menuId: " + menuId + ", name: " + name + ", price: " + price + ", quantity: " + quantity); // Log parameters

                // Get or create the cart in the session
                HttpSession session = req.getSession();
                Cart cart = (Cart) session.getAttribute("cart");
                if (cart == null) {
                    System.out.println("Creating new cart"); // Log cart creation
                    cart = new Cart();
                    session.setAttribute("cart", cart);
                }

                cart.addCartItem(menuId, name, price, quantity);

                // Update the cart count in the session
                int cartCount = cart.getItems().values().stream().mapToInt(CartItem::getQuantity).sum();
                session.setAttribute("cartCount", cartCount);

                System.out.println("Item added to cart successfully"); // Log success

                // Send a JSON response indicating success
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                resp.getWriter().write("{\"success\": true}");

            } catch (NumberFormatException e) {
                System.err.println("NumberFormatException: " + e.getMessage()); // Log number format error
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid input format.");
            } catch (Exception e) {
                System.err.println("Unexpected error: " + e.getMessage()); // Log unexpected error
                e.printStackTrace();
                resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An unexpected error occurred.");
            }
        } else {
            System.err.println("Invalid action: " + action); // Log invalid action
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action.");
        }
    }
}
