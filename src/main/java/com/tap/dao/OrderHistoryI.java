package com.tap.dao;



import java.util.List;

import com.tap.model.OrderHistory;

public interface OrderHistoryI {
	OrderHistory fetchOrderOnId(int userId);
	int insertOrderHistory(OrderHistory orderHistory);
	int updateOrderHistory(int orderhistoryid, String status);
	List<OrderHistory> fechOnUserId(int userId);
	
}

