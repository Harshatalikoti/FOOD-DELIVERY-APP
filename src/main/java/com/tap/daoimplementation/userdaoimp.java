package com.tap.daoimplementation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.userdao;
import com.tap.model.User;
import com.tap.utility.DBconnection;

public class userdaoimp implements userdao{
	private static final  String INSERT_USER_QUERY = "Insert into `user`(`name`,`username`,`password`,`email`,`phone`,`role`,)values(?,?,?,?,?,?,?)";
	private static final  String GET_USER_QUERY = "SELECT * from `user` where `userId`=?";
	private static final  String UPDATE_USERS_QUERY = "UPDATE `user` set `name` = ? `password` = ? `phone`=? `address`=? `role` = ?";
	private static final  String DELETE_USERS_QUERY = "DELETE from user where `userId` = ?";
	private static final  String GET_ALL_USERS_QUERY = "SELECT * from `user`";
	int x;


	public User getUserByUsername(String username) {
	    User user = null;

	    String query = "SELECT * FROM `user` WHERE `username` = ?";

	    try (Connection connection = DBconnection.getConnection();
	         PreparedStatement prepareStatement = connection.prepareStatement(query)) {

	        prepareStatement.setString(1, username);
	        ResultSet res = prepareStatement.executeQuery();

	        if (res.next()) {
	            user = extractUser(res);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return user;
	}

	@Override
	public int addUser(User user) {
	    int userId = -1; // Default to failure
	    try {
	        Connection con = DBconnection.getConnection();
	        String query = "INSERT INTO users (name, username, password, email, phone, address, role, createdDate) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
	        PreparedStatement ps = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
	        ps.setString(1, user.getName());
	        ps.setString(2, user.getUsername());
	        ps.setString(3, user.getPassword());
	        ps.setString(4, user.getEmail());
	        ps.setString(5, user.getPhone());
	        ps.setString(6, user.getAddress());
	        ps.setString(7, user.getRole());
	        ps.setTimestamp(8, new Timestamp(user.getCreatedDate().getTime()));

	        int rowsAffected = ps.executeUpdate();
	        if (rowsAffected > 0) {
	            ResultSet rs = ps.getGeneratedKeys();
	            if (rs.next()) {
	                userId = rs.getInt(1); // Get generated user ID
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return userId;
	}


	@Override
	public User getUser(int userId) {
		User user = null;
		
		try(Connection connection = DBconnection.getConnection();
				PreparedStatement prepareStatement = connection.prepareStatement(GET_USER_QUERY)) {
				prepareStatement.setInt(1, userId);
				ResultSet res = prepareStatement.executeQuery();
				
				user = extractUser(res);
				
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
			return user;
		}
		

	@Override
	public void updateUser(User user) {
		try (	Connection connection = DBconnection.getConnection();	
				PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_USERS_QUERY)){
			
			preparedStatement.setString(0,user.getName());
			preparedStatement.setString(1,user.getPassword());
			preparedStatement.setString(2, user.getPhone());
			preparedStatement.setString(3, user.getAddress());
			preparedStatement.setString(4, user.getRole());
			
			preparedStatement.executeUpdate();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		
	}

	@Override
	public void deleteUser(int userId) {
		try (	Connection connection = DBconnection.getConnection();	
				PreparedStatement preparedStatement = connection.prepareStatement(DELETE_USERS_QUERY)){
				preparedStatement.setInt(1, userId);
				preparedStatement.executeUpdate();
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		
		
	}

	@Override
	public List<User> getAllUsers() {
		List<User> userList = new ArrayList<User>();
		try (	Connection connection = DBconnection.getConnection();	
				Statement Statement = connection.createStatement()){
			ResultSet res = Statement.executeQuery(GET_ALL_USERS_QUERY);
			while(res.next())
			{
				User user = extractUser(res);
				userList.add(user);
			}
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		
		return userList;
	}

	User extractUser(ResultSet res) throws SQLException
	{
		int userId = res.getInt("userId");
		String name = res.getString("name");
		String username = res.getString("username");
		String password = res.getString("password");
		String email = res.getString("email");
		String phone =res.getString("phone");
		String address = res.getString("address");
		String role = res.getString("role");
		 User user = new User(userId, name,username,password,email,phone,address,role, null, null);
		  return user;
	}
	public static void main(String[] args) {
		userdaoimp userdaoimp = new userdaoimp();
		System.out.println("successfull");
	}
	}
