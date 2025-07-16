package com.tap.dao;

import java.util.List;

import com.tap.model.order;

public interface Orderdao {
	void addOrder(order order);
	order getOrder(int orderId);
	void updateOrder(order order);
	void deleteOrder(int orderId);
	List<order>getAllOrdersByUser(int userId);
	
	
}
