package com.tap.utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;

public class DBconnection {
	private static String url="jdbc:mysql://localhost:3306/food_web_app";
	private static String username = "root";
	private static String password = "root";

	
//	static Statement statement = null;
//	private static PreparedStatement prepareStatement;
//	private static ResultSetMetaData stmd;
//	public static void main(String[] args) {
//		System.out.println(getConnection());
//	}
	
	public final static  Connection getConnection() {
		
		Connection connection = null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			 connection = DriverManager.getConnection(url,username,password);
//			 System.out.println("connection established");
	}
		catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return connection;
	}


	

}
