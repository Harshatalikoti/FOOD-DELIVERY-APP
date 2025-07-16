package com.tap.daoimplementation;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.Menudao;

import com.tap.model.menu;
import com.tap.utility.DBconnection;

public class menuDaoImpl implements Menudao {

    private static final String INSERT_MENU_QUERY = "INSERT INTO `menu`(`menuId`, `restaurantId`, `itemName`, `description`, `price`, `rating`, `isAvaliable`, `imagePath`) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String GET_MENU_QUERY = "SELECT * FROM `menu` WHERE `menuId` = ?";
    private static final String UPDATE_MENU_QUERY = "UPDATE `menu` SET `restaurantId` = ?, `itemName` = ?, `description` = ?, `price` = ?, `rating` = ?, `isAvaliable` = ?, `imagePath` = ? WHERE `menuId` = ?";
    private static final String DELETE_MENU_QUERY = "DELETE FROM `menu` WHERE `menuId` = ?";
    private static final String GET_ALL_MENU_QUERY = "SELECT * FROM `menu`";
    private static final String GET_MENU_BY_RESTAURANT_QUERY = "SELECT * FROM `menu` WHERE `restaurantId` = ?";

    @Override
    public void addMenu(menu menu) {
        try (Connection connection = DBconnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_MENU_QUERY)) {

            preparedStatement.setInt(1, menu.getMenuId());
            preparedStatement.setInt(2, menu.getRestaurantId());
            preparedStatement.setString(3, menu.getItemName());
            preparedStatement.setString(4, menu.getDescription());
            preparedStatement.setInt(5, menu.getPrice());
            preparedStatement.setFloat(6, menu.getRating());
            preparedStatement.setBoolean(7, menu.isAvaliable());
            preparedStatement.setString(8, menu.getImagePath());

            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public menu getMenu(int menuId) {
        menu menu = null;

        try (Connection connection = DBconnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_MENU_QUERY)) {

            preparedStatement.setInt(1, menuId);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                menu = extractMenu(resultSet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return menu;
    }

    @Override
    public void updateMenu(menu menu) {
        try (Connection connection = DBconnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_MENU_QUERY)) {

            preparedStatement.setInt(1, menu.getRestaurantId());
            preparedStatement.setString(2, menu.getItemName());
            preparedStatement.setString(3, menu.getDescription());
            preparedStatement.setInt(4, menu.getPrice());
            preparedStatement.setFloat(5, menu.getRating());
            preparedStatement.setBoolean(6, menu.isAvaliable());
            preparedStatement.setString(7, menu.getImagePath());
            preparedStatement.setInt(8, menu.getMenuId());

            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteMenu(int menuId) {
        try (Connection connection = DBconnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_MENU_QUERY)) {

            preparedStatement.setInt(1, menuId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<menu> getAllMenu() {
        List<menu> menuList = new ArrayList<>();

        try (Connection connection = DBconnection.getConnection();
             Statement statement = connection.createStatement()) {

            ResultSet resultSet = statement.executeQuery(GET_ALL_MENU_QUERY);

            while (resultSet.next()) {
                menu menu = extractMenu(resultSet);
                menuList.add(menu);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return menuList;
    }

    @Override
    public List<menu> getMenuByrestaurant(int restaurantId) {
        List<menu> menuList = new ArrayList<>();

        try (Connection connection = DBconnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_MENU_BY_RESTAURANT_QUERY)) {

            preparedStatement.setInt(1, restaurantId);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                menu menu = extractMenu(resultSet);
                menuList.add(menu);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return menuList;
    }

    private menu extractMenu(ResultSet resultSet) throws SQLException {
        int menuId = resultSet.getInt("menuId");
        int restaurantId = resultSet.getInt("restaurantId");
        String itemName = resultSet.getString("itemName");
        String description = resultSet.getString("description");
        int price = resultSet.getInt("price");
        float rating = resultSet.getFloat("rating");
        boolean isAvaliable = resultSet.getBoolean("isAvaliable");
        String imagePath = resultSet.getString("imagePath");

        return new menu(menuId, restaurantId, itemName, description, price, rating, isAvaliable, imagePath);
    }

    public static void main(String[] args) {
        menuDaoImpl menuDaoImpl = new menuDaoImpl();
        System.out.println("Menu DAO Implementation successful");
    }
}
