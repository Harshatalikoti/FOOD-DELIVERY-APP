package com.tap.daoimplementation;


import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.tap.model.order;
import com.tap.utility.DBconnection;

public class OrderDaoImpl {
    private static final String INSERT_ORDER_QUERY = "INSERT INTO `order`(`userId`, `restaurantId`, `orderDate`, `totalAmount`, `status`, `paymentMode`) VALUES (?, ?, ?, ?, ?, ?)";
    private static final String GET_ORDER_QUERY = "SELECT * FROM `order` WHERE `orderId` = ?";
    private static final String UPDATE_ORDER_QUERY = "UPDATE `order` SET `userId` = ?, `restaurantId` = ?, `orderDate` = ?, `totalAmount` = ?, `status` = ?, `paymentMode` = ? WHERE `orderId` = ?";
    private static final String DELETE_ORDER_QUERY = "DELETE FROM `order` WHERE `orderId` = ?";
    private static final String GET_ALL_ORDERS_BY_USER_QUERY = "SELECT * FROM `order` WHERE `userId` = ?";

    public int addOrder(order order) {
        int generatedOrderId = -1;
        try (Connection connection = DBconnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_ORDER_QUERY, Statement.RETURN_GENERATED_KEYS)) {

            preparedStatement.setInt(1, order.getUserId());
            preparedStatement.setInt(2, order.getRestaurantId());
            preparedStatement.setDate(3, new Date(order.getOrderDate().getTime()));
            preparedStatement.setDouble(4, order.getTotalAmount());
            preparedStatement.setString(5, order.getStatus());
            preparedStatement.setString(6, order.getPaymentMode());

            int rowsAffected = preparedStatement.executeUpdate();
            
            if (rowsAffected > 0) {
                ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    generatedOrderId = generatedKeys.getInt(1); // Get the generated orderId
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return generatedOrderId;
    }


    public order getOrder(int orderId) {
        order order = null;
        try (Connection connection = DBconnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_ORDER_QUERY)) {
            preparedStatement.setInt(1, orderId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                order = extractOrder(resultSet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return order;
    }

    public void updateOrder(order order) {
        try (Connection connection = DBconnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_ORDER_QUERY)) {
            preparedStatement.setInt(1, order.getUserId());
            preparedStatement.setInt(2, order.getRestaurantId());
            preparedStatement.setDate(3, new Date(order.getOrderDate().getTime()));
            preparedStatement.setDouble(4, order.getTotalAmount());
            preparedStatement.setString(5, order.getStatus());
            preparedStatement.setString(6, order.getPaymentMode());
            preparedStatement.setInt(7, order.getOrderId());

            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteOrder(int orderId) {
        try (Connection connection = DBconnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_ORDER_QUERY)) {
            preparedStatement.setInt(1, orderId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<order> getAllOrdersByUser(int userId) {
        List<order> orders = new ArrayList<>();
        try (Connection connection = DBconnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_ALL_ORDERS_BY_USER_QUERY)) {
            preparedStatement.setInt(1, userId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                orders.add(extractOrder(resultSet));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    private order extractOrder(ResultSet resultSet) throws SQLException {
        int orderId = resultSet.getInt("orderId");
        int userId = resultSet.getInt("userId");
        int restaurantId = resultSet.getInt("restaurantId");
        Date orderDate = resultSet.getDate("orderDate");
        int totalAmount = resultSet.getInt("totalAmount");
        String status = resultSet.getString("status");
        String paymentMode = resultSet.getString("paymentMode");

        return new order(orderId, userId, restaurantId, orderDate, totalAmount, status, paymentMode);
    }
}

