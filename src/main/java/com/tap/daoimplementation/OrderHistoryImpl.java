package com.tap.daoimplementation;

	import java.sql.Connection;
	import java.sql.DriverManager;
	import java.sql.PreparedStatement;
	import java.sql.ResultSet;
	import java.sql.SQLException;
	import java.sql.Statement;
	import java.util.ArrayList;
	import java.util.List;
	import com.tap.utility.*;

	import com.tap.dao.OrderHistoryI;
	import com.tap.model.OrderHistory;

	public class OrderHistoryImpl implements OrderHistoryI{
		
		private static Connection con;
		private static PreparedStatement pstmt;
		private static ResultSet res;
		private List<OrderHistory> list = new ArrayList<OrderHistory>();
		

		private static final String INSERT_ORDER_HISTORY = "INSERT INTO orderhistory (userId, order1Id, total, status) VALUES (?, ?, ?, ?)";
	    private static final String UPDATE_ORDER_HISTORY = "UPDATE orderhistory SET status = ? WHERE orderHistoryId = ?";
	    private static final String FETCH_ORDER_HISTORY_BY_ID = "SELECT * FROM orderhistory WHERE orderHistoryId = ?";
	    private static final String FETCH_ORDER_HISTORY_BY_USER_ID = "SELECT * FROM orderhistory WHERE userId = ?";

	    public int insertOrderHistory(OrderHistory orderHistory) {
	        try (Connection connection = DBconnection.getConnection();
	             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_ORDER_HISTORY)) {
	            
	            preparedStatement.setInt(1, orderHistory.getUserId());
	            preparedStatement.setInt(2, orderHistory.getOrderId());
	            preparedStatement.setDouble(3, orderHistory.getTotal());
	            preparedStatement.setString(4, orderHistory.getStatus());
	            preparedStatement.executeUpdate();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
			return 0;
	    }

	    public OrderHistory fetchOrderOnId(int orderHistoryId) {
	        OrderHistory orderHistory = null;
	        try (Connection connection = DBconnection.getConnection();
	             PreparedStatement preparedStatement = connection.prepareStatement(FETCH_ORDER_HISTORY_BY_ID)) {

	            preparedStatement.setInt(1, orderHistoryId);
	            ResultSet resultSet = preparedStatement.executeQuery();

	            if (resultSet.next()) {
	                orderHistory = extractOrderHistory(resultSet);
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return orderHistory;
	    }

	    public List<OrderHistory> fetchOnUserId(int userId) {
	        List<OrderHistory> orderHistories = new ArrayList<>();
	        try (Connection connection = DBconnection.getConnection();
	             PreparedStatement preparedStatement = connection.prepareStatement(FETCH_ORDER_HISTORY_BY_USER_ID)) {

	            preparedStatement.setInt(1, userId);
	            ResultSet resultSet = preparedStatement.executeQuery();

	            while (resultSet.next()) {
	                orderHistories.add(extractOrderHistory(resultSet));
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return orderHistories;
	    }

	    public int updateOrderHistory(int orderHistoryId, String status) {
	        try (Connection connection = DBconnection.getConnection();
	             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_ORDER_HISTORY)) {
	            
	            preparedStatement.setString(1, status);
	            preparedStatement.setInt(2, orderHistoryId);
	            preparedStatement.executeUpdate();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
			return orderHistoryId;
	    }

	    private OrderHistory extractOrderHistory(ResultSet resultSet) throws SQLException {
	        int orderHistoryId = resultSet.getInt("orderHistoryId");
	        int userId = resultSet.getInt("userId");
	        int orderId = resultSet.getInt("order1Id");
	        String status = resultSet.getString("status");
	        double total = resultSet.getDouble("total");

	        return new OrderHistory(orderHistoryId, userId, orderId, status, total, status);
	    }

		@Override
		public List<OrderHistory> fechOnUserId(int userId) {
			// TODO Auto-generated method stub
			return null;
		}

		
	}

