package com.fashionhub.controller;

import java.sql.Connection;

import com.fashionhub.util.DBConnection;

public class TestConnection {

    public static void main(String[] args) {

        Connection conn =
                DBConnection.getConnection();

        if(conn != null) {

            System.out.println("SUCCESS");

        } else {

            System.out.println("FAILED");
        }
    }
}