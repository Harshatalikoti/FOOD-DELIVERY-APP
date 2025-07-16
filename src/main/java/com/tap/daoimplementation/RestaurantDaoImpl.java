package com.tap.daoimplementation;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.restaurantdao;
import com.tap.model.restaurant;
import com.tap.utility.DBconnection;

public class RestaurantDaoImpl implements restaurantdao {

    private static final String INSERT_RESTAURANT_QUERY = "INSERT INTO `restaurant`(`name`, `address`, `phone`, `rating`, `cusineType`, `isActive`, `eta`, `adminUserId`, `imagePath`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String GET_RESTAURANT_QUERY = "SELECT * FROM `restaurant` WHERE `restaurantId` = ?";
    private static final String UPDATE_RESTAURANT_QUERY = "UPDATE `restaurant` SET `name` = ?, `address` = ?, `phone` = ?, `rating` = ?, `cusineType` = ?, `isActive` = ?, `eta` = ?, `adminUserId` = ?, `imagePath` = ? WHERE `restaurantId` = ?";
    private static final String DELETE_RESTAURANT_QUERY = "DELETE FROM `restaurant` WHERE `restaurantId` = ?";
    private static final String GET_ALL_RESTAURANTS_QUERY = "SELECT * FROM `restaurant`";

    @Override
    public void addRestaurant(restaurant restaurant) {
        try (Connection connection = DBconnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_RESTAURANT_QUERY)) {

            preparedStatement.setString(1, restaurant.getName());
            preparedStatement.setString(2, restaurant.getAddress());
            preparedStatement.setString(3, restaurant.getPhone());
            preparedStatement.setFloat(4, restaurant.getRating());
            preparedStatement.setString(5, restaurant.getCusineType());
            preparedStatement.setBoolean(6, restaurant.isActive());
            preparedStatement.setDate(7, restaurant.getEta());
            preparedStatement.setInt(8, restaurant.getAdminUserId());
            preparedStatement.setString(9, restaurant.getImagePath());

            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public restaurant getRestaurant(int restaurantId) {
        restaurant restaurant = null;

        try (Connection connection = DBconnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_RESTAURANT_QUERY)) {

            preparedStatement.setInt(1, restaurantId);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                restaurant = extractRestaurant(resultSet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return restaurant;
    }

    @Override
    public void updateRestaurant(restaurant restaurant) {
        try (Connection connection = DBconnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_RESTAURANT_QUERY)) {

            preparedStatement.setString(1, restaurant.getName());
            preparedStatement.setString(2, restaurant.getAddress());
            preparedStatement.setString(3, restaurant.getPhone());
            preparedStatement.setFloat(4, restaurant.getRating());
            preparedStatement.setString(5, restaurant.getCusineType());
            preparedStatement.setBoolean(6, restaurant.isActive());
            preparedStatement.setDate(7, restaurant.getEta());
            preparedStatement.setInt(8, restaurant.getAdminUserId());
            preparedStatement.setString(9, restaurant.getImagePath());
            preparedStatement.setInt(10, restaurant.getRestaurantId());

            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteRestaurant(int restaurantId) {
        try (Connection connection = DBconnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_RESTAURANT_QUERY)) {

            preparedStatement.setInt(1, restaurantId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<restaurant> getAllRestaurants() {
        List<restaurant> restaurantList = new ArrayList<>();

        try (Connection connection = DBconnection.getConnection();
             Statement statement = connection.createStatement()) {

            ResultSet resultSet = statement.executeQuery(GET_ALL_RESTAURANTS_QUERY);

            while (resultSet.next()) {
                restaurant restaurant = extractRestaurant(resultSet);
                restaurantList.add(restaurant);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

       return restaurantList;
    }

    private restaurant extractRestaurant(ResultSet resultSet) throws SQLException {
        int restaurantId = resultSet.getInt("restaurantId");
        String name = resultSet.getString("name");
        String address = resultSet.getString("address");
        String phone = resultSet.getString("phone");
        float rating = resultSet.getFloat("rating");
        String cusineType = resultSet.getString("cusineType");
        boolean isActive = resultSet.getBoolean("isActive");
        Date eta = resultSet.getDate("eta");
        int adminUserId = resultSet.getInt("adminUserId");
        String imagePath = resultSet.getString("imagePath");

        return new restaurant(restaurantId, name, address, phone, rating, cusineType, isActive, eta, adminUserId, imagePath);
    }

    public static void main(String[] args) {
        RestaurantDaoImpl restaurantDAOImp = new RestaurantDaoImpl();
        System.out.println("Implementation successful");
    }
   

	
	

	

	

	

	
}
