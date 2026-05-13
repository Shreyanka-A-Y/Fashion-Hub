package com.fashionhub.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.fashionhub.model.WalletTransaction;
import com.fashionhub.util.DBConnection;

public class WalletDAO {


    public List<WalletTransaction>
    getTransactionsByUser(int userId) {

        List<WalletTransaction> list =
                new ArrayList<>();

        try {

            Connection conn =
                    DBConnection.getConnection();

            String sql =
                    "SELECT * FROM wallet_transactions WHERE user_id=? ORDER BY txn_id DESC";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ps.setInt(1, userId);

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()) {

                WalletTransaction wt =
                        new WalletTransaction();

                wt.setTxnId(
                        rs.getInt("txn_id"));

                wt.setUserId(
                        rs.getInt("user_id"));

                wt.setCoins(
                        rs.getInt("coins"));

                wt.setTxnType(
                        rs.getString("txn_type"));

                wt.setReason(
                        rs.getString("reason"));

                wt.setCreatedAt(
                        rs.getString("created_at"));

                list.add(wt);
            }

        } catch(Exception e) {

            e.printStackTrace();
        }

        return list;
    }

}