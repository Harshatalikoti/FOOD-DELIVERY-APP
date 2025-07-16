package com.tap.dao;

import java.util.List;
import com.tap.model.*;

public interface orderItemdao {
	void orderItem(OrderItem orderItem);
	void addOrderItem(orderItem orderitem);
	orderItem getorderItem(int orderItemId);
	void updateorderItem(orderItem orderItem);
	void deleteOrderItem(int orderItemId);
	int insertOrderItem(OrderItem orderItem);
	OrderItem fetchOrderItem(int orderId);
	
	List<orderItem> getorderItemByOrder(int orderId);
}
