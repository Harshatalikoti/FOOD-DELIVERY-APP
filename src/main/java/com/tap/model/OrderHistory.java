package com.tap.model;

public class OrderHistory {
	
	private int orderHistoryId;
	private int userId;
	private int order1Id;
	private String date;
	private double total;
	private String status;
	
	
	public OrderHistory() {
		
	}


	public OrderHistory(int userId, int order1Id, double total, String status) {
		super();
		this.userId = userId;
		this.order1Id = order1Id;
		this.total = total;
		this.status = status;
	}


	public OrderHistory(int orderHistoryId, int userId, int order1Id, String date, double total, String status) {
		super();
		this.orderHistoryId = orderHistoryId;
		this.userId = userId;
		this.order1Id = order1Id;
		this.date = date;
		this.total = total;
		this.status = status;
	}


	public int getOrderHistoryId() {
		return orderHistoryId;
	}


	public void setOrderHistoryId(int orderHistoryId) {
		this.orderHistoryId = orderHistoryId;
	}


	public int getUserId() {
		return userId;
	}


	public void setUserId(int userId) {
		this.userId = userId;
	}


	public int getOrderId() {
		return order1Id;
	}


	public void setOrderId(int order1Id) {
		this.order1Id = order1Id;
	}


	public String getDate() {
		return date;
	}


	public void setDate(String date) {
		this.date = date;
	}


	public double getTotal() {
		return total;
	}


	public void setTotal(double total) {
		this.total = total;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	@Override
	public String toString() {
		return orderHistoryId + "  " + userId + "  " + order1Id + "  " + date + "  " + total + "  " + status;
	}
	
	

}
