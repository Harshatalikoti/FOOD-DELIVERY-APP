package com.tap.dao;

import java.util.List;

import com.tap.model.menu;

public interface Menudao {
	void addMenu(menu menu);
	menu getMenu(int menuId);
	void updateMenu(menu menu);
	void deleteMenu(int menuId);
	List<menu> getAllMenu();
	List<menu> getMenuByrestaurant(int restaurantId);
	
}
