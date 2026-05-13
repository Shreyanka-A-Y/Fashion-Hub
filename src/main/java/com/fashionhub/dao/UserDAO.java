package com.fashionhub.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.fashionhub.model.User;
import com.fashionhub.util.DBConnection;

public class UserDAO {

    public boolean registerUser(User user) {

        boolean status = false;

        try {

            Connection conn = DBConnection.getConnection();

            String sql =
                    "INSERT INTO users(full_name,email,password,phone) VALUES(?,?,?,?)";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getPhone());

            int rows = ps.executeUpdate();

            if(rows > 0) {

                status = true;

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return status;
    }
    
    
    public User loginUser(String email, String password) {

        User user = null;

        try {

            Connection conn = DBConnection.getConnection();

            String sql =
                "SELECT * FROM users WHERE email=? AND password=?";

            PreparedStatement ps =
                conn.prepareStatement(sql);

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {

                user = new User();

                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setCoins(rs.getInt("coins"));

                System.out.println("User Found");

            } else {

                System.out.println("No User Found");
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return user;
    }
    

public User getUserById(int userId) {

    User user = null;

    try {

        Connection conn =
                DBConnection.getConnection();

        String sql =
                "SELECT * FROM users WHERE user_id=?";

        PreparedStatement ps =
                conn.prepareStatement(sql);

        ps.setInt(1, userId);

        ResultSet rs =
                ps.executeQuery();

        if(rs.next()) {

            user = new User();

            user.setUserId(
                    rs.getInt("user_id"));

            user.setFullName(
                    rs.getString("full_name"));

            user.setEmail(
                    rs.getString("email"));

            user.setCoins(
                    rs.getInt("coins"));

        }

    } catch(Exception e) {

        e.printStackTrace();
    }

    return user;
}

public List<String[]> getWalletTransactions(int userId) {

    List<String[]> list = new ArrayList<>();

    try {

        Connection conn = DBConnection.getConnection();

        String sql = "SELECT coins, txn_type, reason, created_at FROM wallet_transactions WHERE user_id=? ORDER BY txn_id DESC";

        PreparedStatement ps = conn.prepareStatement(sql);

        ps.setInt(1, userId);

        ResultSet rs = ps.executeQuery();

        while(rs.next()) {

            String[] txn = new String[4];

            txn[0] = rs.getString("coins");
            txn[1] = rs.getString("txn_type");
            txn[2] = rs.getString("reason");
            txn[3] = rs.getString("created_at");

            list.add(txn);
        }

    } catch(Exception e) {
        e.printStackTrace();
    }

    return list;
}

public List<User> getAllUsers(){

    List<User> list = new ArrayList<>();

    try{

        Connection conn =
                DBConnection.getConnection();

        String sql =
                "SELECT * FROM users";

        PreparedStatement ps =
                conn.prepareStatement(sql);

        ResultSet rs =
                ps.executeQuery();

        while(rs.next()){

            User u = new User();

            u.setUserId(
                    rs.getInt("user_id"));

            u.setFullName(
                    rs.getString("full_name"));

            u.setEmail(
                    rs.getString("email"));

            u.setCoins(
                    rs.getInt("coins"));

            list.add(u);
        }

    }catch(Exception e){

        e.printStackTrace();
    }

    return list;
}

public boolean updateUser(User user) {
    boolean f = false;
    try {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE users SET full_name=?, phone=?, address=? WHERE user_id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, user.getFullName());
        ps.setString(2, user.getPhone());
        ps.setString(3, user.getAddress());
        ps.setInt(4, user.getUserId());

        if (ps.executeUpdate() == 1) {
            f = true;
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return f;
}

}
