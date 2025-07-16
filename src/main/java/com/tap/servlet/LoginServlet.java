package com.tap.servlet;



import java.io.IOException;

import com.tap.daoimplementation.userdaoimp;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.tap.daoimplementation.userdaoimp;
import com.tap.model.User;


@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Check if the username exists in the database
        userdaoimp userDAO = new userdaoimp();
        User user = userDAO.getUserByUsername(username);

        if (user != null && user.getPassword().equals(password)) {
            // Successful login, create session and store user details
            HttpSession session = request.getSession();
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("username", user.getUsername());
            session.setAttribute("role", user.getRole());
            
            // Update the last login date in the database
            user.setLastLoginDate(new java.util.Date());
            userDAO.updateUser(user);
            
            // Redirect to checkout page
            response.sendRedirect("checkout.jsp"); // Redirecting directly to the checkout page
        } else {
            // Invalid credentials
            response.sendRedirect("login.jsp?error=Invalid username or password");
        }
    }
}


