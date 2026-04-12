package com.drivektm.config;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConfig {
    private static final String URL = "jdbc:mysql://localhost:3306/drivektm";
    private static final String USER = "root"; // Your MySQL username
    private static final String PASSWORD = ""; // Your MySQL password

    public static Connection getConnection() {
        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return con;
    }
}