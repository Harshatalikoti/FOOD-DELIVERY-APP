package com.tap.servlet;

import java.io.IOException;
import java.sql.Date;
import java.util.Calendar;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.tap.daoimplementation.userdaoimp;
import com.tap.model.User;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String role = request.getParameter("role");

        // Validate if the username already exists
        userdaoimp userDAO = new userdaoimp();
        User existingUser = userDAO.getUserByUsername(username);

        if (existingUser != null) {
            // Username already exists
            response.sendRedirect("signup.jsp?error=Username already exists");
            return;
        }

        // Create a new user object and set details
        User newUser = new User();
        newUser.setName(name);
        newUser.setUsername(username);
        newUser.setPassword(password);
        newUser.setEmail(email);
        newUser.setPhone(phone);
        newUser.setAddress(address);
        newUser.setRole(role);
        newUser.setCreatedDate(new java.util.Date());
        newUser.setLastLoginDate(null); // Initial login date is null

        // Add the new user to the database
        userDAO.addUser(newUser);

        // Redirect to login page after successful signup
        response.sendRedirect("login.jsp?signup=success");
    }
}
