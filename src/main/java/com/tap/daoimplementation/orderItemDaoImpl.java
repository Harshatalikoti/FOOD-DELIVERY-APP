package com.tap.daoimplementation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tap.model.OrderItem;
import com.tap.utility.DBconnection;

public class orderItemDaoImpl {

    private static final String INSERT_ORDER_ITEM_QUERY = "INSERT INTO `order_item`(`orderId`, `menuId`, `quantity`, `totalPrice`) VALUES (?, ?, ?, ?)";
    private static final String GET_ORDER_ITEM_QUERY = "SELECT * FROM `order_item` WHERE `orderItemId` = ?";
    private static final String UPDATE_ORDER_ITEM_QUERY = "UPDATE `order_item` SET `orderId` = ?, `menuId` = ?, `quantity` = ?, `totalPrice` = ? WHERE `orderItemId` = ?";
    private static final String DELETE_ORDER_ITEM_QUERY = "DELETE FROM `order_item` WHERE `orderItemId` = ?";
    private static final String GET_ORDER_ITEMS_BY_ORDER_QUERY = "SELECT * FROM `order_item` WHERE `orderId` = ?";
    
    private Connection con;

    public orderItemDaoImpl() {
        con = DBconnection.getConnection();
        if (con == null) {
            throw new RuntimeException("Database connection failed.");
        }
    }

    // ✅ Insert a new order item (returns boolean instead of int)
    public boolean insertOrderItem(OrderItem orderItem) {
        try (PreparedStatement pstmt = con.prepareStatement(INSERT_ORDER_ITEM_QUERY, PreparedStatement.RETURN_GENERATED_KEYS)) {
            pstmt.setInt(1, orderItem.getOrder1Id()); // ✅ Ensure correct field name
            pstmt.setInt(2, orderItem.getMenuId());
            pstmt.setInt(3, orderItem.getQuantity());
            pstmt.setDouble(4, orderItem.getTotalPrice());

            int rowsAffected = pstmt.executeUpdate();

            // ✅ Return true if the item was inserted
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ✅ Fetch an order item by its ID
    public OrderItem fetchOrderItem(int orderItemId) {
        try (PreparedStatement pstmt = con.prepareStatement(GET_ORDER_ITEM_QUERY)) {
            pstmt.setInt(1, orderItemId);
            try (ResultSet res = pstmt.executeQuery()) {
                if (res.next()) {
                    return new OrderItem(res.getInt("orderItemId"), res.getInt("orderId"), 
                        res.getInt("menuId"), res.getInt("quantity"), res.getDouble("totalPrice"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ✅ Update an existing order item
    public boolean updateOrderItem(OrderItem orderItem) {
        try (PreparedStatement pstmt = con.prepareStatement(UPDATE_ORDER_ITEM_QUERY)) {
            pstmt.setInt(1, orderItem.getOrder1Id());
            pstmt.setInt(2, orderItem.getMenuId());
            pstmt.setInt(3, orderItem.getQuantity());
            pstmt.setDouble(4, orderItem.getTotalPrice());
            pstmt.setInt(5, orderItem.getOrderItemId());

            int rowsUpdated = pstmt.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ✅ Delete an order item
    public boolean deleteOrderItem(int orderItemId) {
        try (PreparedStatement pstmt = con.prepareStatement(DELETE_ORDER_ITEM_QUERY)) {
            pstmt.setInt(1, orderItemId);
            int rowsDeleted = pstmt.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ✅ Fetch all order items for a specific order
    public List<OrderItem> getOrderItemsByOrder(int orderId) {
        List<OrderItem> orderItems = new ArrayList<>();
        try (PreparedStatement pstmt = con.prepareStatement(GET_ORDER_ITEMS_BY_ORDER_QUERY)) {
            pstmt.setInt(1, orderId);
            try (ResultSet res = pstmt.executeQuery()) {
                while (res.next()) {
                    OrderItem orderItem = new OrderItem(
                        res.getInt("orderItemId"), 
                        res.getInt("orderId"), 
                        res.getInt("menuId"), 
                        res.getInt("quantity"), 
                        res.getDouble("totalPrice")
                    );
                    orderItems.add(orderItem);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderItems;
    }

    public static void main(String[] args) {
        orderItemDaoImpl dao = new orderItemDaoImpl();
        System.out.println("DAO Implementation Loaded Successfully");
    }
}
