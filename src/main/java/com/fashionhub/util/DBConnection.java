package com.fashionhub.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private static Connection conn;

    public static Connection getConnection() {

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/fashion_coin_store",
                    "root",
                    "");

            System.out.println("Database Connected Successfully!");

        } catch (Exception e) {

            System.out.println("Database Connection Failed!");

            e.printStackTrace();
        }

        return conn;
    }
}