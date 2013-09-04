package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

public class MySQLConnector {
	// this method implements mySQL actions. execute type includes: select,
	// update, delect
	public static HashMap<String, ArrayList<String>> executeMySQL(
			String executeType, String query) {
		HashMap<String, ArrayList<String>> map = new HashMap<String, ArrayList<String>>();
		Connection connection = null;
		System.out.println("Test ");
		try {
			// Loading the JDBC driver for MySql
			Class.forName("com.mysql.jdbc.Driver");
			// Getting a connection to the database. Change the URL parameters
			// My database
			//connection = DriverManager.getConnection(
					//"jdbc:mysql://127.0.0.1:3306/is480-matching", "root",
					//"lightningstrike480");
			//testing
			connection = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/is480-matching", "root",
					"lightningstrike480");
			System.out.println("Connection success");
			// Creating a statement object
			Statement stmt = connection.createStatement();
			if (executeType.equals("select")) {
				ResultSet rs = stmt.executeQuery(query);
				ResultSetMetaData rsmd = rs.getMetaData();
				int columnsNumber = rsmd.getColumnCount();
				while (rs.next()) {
					ArrayList<String> array = new ArrayList<String>();
					String id = rs.getString(1);
					for (int i = 1; i <= columnsNumber; i++) {
						String data = rs.getString(i);
						array.add(data);
					}
					map.put(id, array);
				}
				rs.close();
			} else if (executeType.equals("update")
					|| executeType.equals("delete")
					|| executeType.equals("insert")) {
				stmt.executeUpdate(query);
			}
			stmt.close();
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return map;
	}
}
