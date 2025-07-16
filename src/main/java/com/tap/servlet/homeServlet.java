package com.tap.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.tap.daoimplementation.RestaurantDaoImpl;
import com.tap.model.restaurant;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/homeServlet") // URL mapping for the servlet
public class homeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L; // Optional but recommended for serialization

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RestaurantDaoImpl restaurantDao = new RestaurantDaoImpl();

        List<restaurant> restaurants = restaurantDao.getAllRestaurants(); // Fetch restaurant data
		req.setAttribute("restaurants", restaurants); // Store data in request scope
//		System.out.println(restaurants);
		RequestDispatcher dispatcher = req.getRequestDispatcher("homee.jsp");
		dispatcher.forward(req, resp); // Forward to JSP

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        service(req, resp); // Reuse service logic for POST requests
    }
}
