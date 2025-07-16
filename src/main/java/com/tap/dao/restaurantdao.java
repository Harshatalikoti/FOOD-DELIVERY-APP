package com.tap.dao;

import java.util.List;

import com.tap.daoimplementation.RestaurantDaoImpl;
import com.tap.model.restaurant;

public interface restaurantdao { 
	
	void addRestaurant(restaurant restaurant);
	
	 restaurant getRestaurant(int restaurantId);
	
	 void updateRestaurant(restaurant restaurant);
	
	 void deleteRestaurant(int restaurantId);

	List<restaurant> getAllRestaurants();

	

}
