package com.fashionhub.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.fashionhub.model.UsedProduct;
import com.fashionhub.util.DBConnection;

public class UsedProductDAO {

    // 🔹 ADDED: GET PRODUCTS LISTED BY SELLER (For "My Listings" tab)
    public List<UsedProduct> getProductsBySeller(int userId) {
        List<UsedProduct> list = new ArrayList<>();
        String sql = "SELECT * FROM used_products WHERE seller_id = ?";
        try (Connection con = DBConnection.getConnection(); 
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                UsedProduct p = new UsedProduct();
                p.setUsedId(rs.getInt("used_id"));
                p.setProductName(rs.getString("product_name"));
                p.setImage(rs.getString("image"));
                p.setCoinPrice(rs.getInt("coin_price"));
                p.setApprovalStatus(rs.getString("approval_status")); // Used for isSold() logic
                list.add(p);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // 🔹 ADDED: GET PRODUCTS PURCHASED BY USER (For "Purchased Items" tab)
    public List<UsedProduct> getPurchasedProductsByUser(int userId) {
        List<UsedProduct> list = new ArrayList<>();
        String sql = "SELECT * FROM used_products WHERE buyer_id = ? AND approval_status = 'SOLD'";
        try (Connection con = DBConnection.getConnection(); 
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                UsedProduct p = new UsedProduct();
                p.setUsedId(rs.getInt("used_id"));
                p.setProductName(rs.getString("product_name"));
                p.setImage(rs.getString("image"));
                p.setCoinPrice(rs.getInt("coin_price"));
                p.setApprovalStatus(rs.getString("approval_status"));
                list.add(p);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // 🔹 ADD USED PRODUCT
    public boolean addUsedProduct(UsedProduct up) {
        boolean status = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "INSERT INTO used_products(seller_id, category_id, product_name, description, product_condition, coin_price, image, approval_status) VALUES(?,?,?,?,?,?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, up.getSellerId());
            ps.setInt(2, up.getCategoryId());
            ps.setString(3, up.getProductName());
            ps.setString(4, up.getDescription());
            ps.setString(5, up.getProductCondition());
            ps.setInt(6, up.getCoinPrice());
            ps.setString(7, up.getImage());
            ps.setString(8, "PENDING");
            int rows = ps.executeUpdate();
            if(rows > 0) status = true;
        } catch(Exception e){ e.printStackTrace(); }
        return status;
    }

    // 🔹 GET APPROVED PRODUCTS
    public List<UsedProduct> getApprovedProducts() {
        List<UsedProduct> list = new ArrayList<>();
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM used_products WHERE approval_status='APPROVED' AND buyer_id IS NULL";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                UsedProduct up = new UsedProduct();
                up.setUsedId(rs.getInt("used_id"));
                up.setSellerId(rs.getInt("seller_id"));
                up.setCategoryId(rs.getInt("category_id"));
                up.setProductName(rs.getString("product_name"));
                up.setDescription(rs.getString("description"));
                up.setProductCondition(rs.getString("product_condition"));
                up.setCoinPrice(rs.getInt("coin_price"));
                up.setImage(rs.getString("image"));
                up.setApprovalStatus(rs.getString("approval_status"));
                list.add(up);
            }
        } catch(Exception e){ e.printStackTrace(); }
        return list;
    }

    // 🔹 GET PRODUCT BY ID (WITH CONNECTION)
    public UsedProduct getUsedProductById(Connection conn, int usedId) {
        UsedProduct up = null;
        try {
            String sql = "SELECT * FROM used_products WHERE used_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, usedId);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                up = new UsedProduct();
                up.setUsedId(rs.getInt("used_id"));
                up.setSellerId(rs.getInt("seller_id"));
                up.setBuyerId(rs.getInt("buyer_id"));
                up.setCategoryId(rs.getInt("category_id"));
                up.setProductName(rs.getString("product_name"));
                up.setDescription(rs.getString("description"));
                up.setProductCondition(rs.getString("product_condition"));
                up.setCoinPrice(rs.getInt("coin_price"));
                up.setImage(rs.getString("image"));
                up.setApprovalStatus(rs.getString("approval_status"));
            }
        } catch(Exception e){ e.printStackTrace(); }
        return up;
    }

    // 🔥 BUY USED PRODUCT (Rest of your existing code remains the same...)
    public boolean buyUsedProduct(int buyerId, int usedId) {
        boolean status = false;
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            if(conn == null) return false;
            conn.setAutoCommit(false);

            UsedProduct up = getUsedProductById(conn, usedId);
            if(up == null || !"APPROVED".equals(up.getApprovalStatus())) return false;

            int sellerId = up.getSellerId();
            int coinPrice = up.getCoinPrice();
            if(buyerId == sellerId) return false;

            String buyerSql = "SELECT coins FROM users WHERE user_id=?";
            PreparedStatement buyerPs = conn.prepareStatement(buyerSql);
            buyerPs.setInt(1, buyerId);
            ResultSet buyerRs = buyerPs.executeQuery();
            int buyerCoins = 0;
            if(buyerRs.next()) buyerCoins = buyerRs.getInt("coins");

            if(buyerCoins < coinPrice) return false;

            // DEDUCT BUYER
            String deductSql = "UPDATE users SET coins = coins - ? WHERE user_id=?";
            PreparedStatement deductPs = conn.prepareStatement(deductSql);
            deductPs.setInt(1, coinPrice);
            deductPs.setInt(2, buyerId);
            deductPs.executeUpdate();

            // CREDIT SELLER
            String creditSql = "UPDATE users SET coins = coins + ? WHERE user_id=?";
            PreparedStatement creditPs = conn.prepareStatement(creditSql);
            creditPs.setInt(1, coinPrice);
            creditPs.setInt(2, sellerId);
            creditPs.executeUpdate();

            // UPDATE PRODUCT
            String updateSql = "UPDATE used_products SET buyer_id=?, approval_status='SOLD' WHERE used_id=?";
            PreparedStatement updatePs = conn.prepareStatement(updateSql);
            updatePs.setInt(1, buyerId);
            updatePs.setInt(2, usedId);
            updatePs.executeUpdate();

            // TRANSACTION LOGS (Abbreviated for space)
            String txnSql = "INSERT INTO wallet_transactions(user_id, coins, txn_type, reason) VALUES(?,?,?,?)";
            PreparedStatement bTxn = conn.prepareStatement(txnSql);
            bTxn.setInt(1, buyerId); bTxn.setInt(2, coinPrice); bTxn.setString(3, "DEBIT"); bTxn.setString(4, "Bought Used Product");
            bTxn.executeUpdate();

            PreparedStatement sTxn = conn.prepareStatement(txnSql);
            sTxn.setInt(1, sellerId); sTxn.setInt(2, coinPrice); sTxn.setString(3, "CREDIT"); sTxn.setString(4, "Sold Used Product");
            sTxn.executeUpdate();

            conn.commit();
            status = true;
        } catch(Exception e){
            try { if(conn != null) conn.rollback(); } catch(Exception ex){}
            e.printStackTrace();
        }
        return status;
    }

    // 🔹 ADMIN METHODS
    public List<UsedProduct> getPendingProducts() {
        List<UsedProduct> list = new ArrayList<>();
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM used_products WHERE approval_status='PENDING'";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                UsedProduct up = new UsedProduct();
                up.setUsedId(rs.getInt("used_id"));
                up.setProductName(rs.getString("product_name"));
                up.setDescription(rs.getString("description"));
                list.add(up);
            }
        } catch(Exception e){ e.printStackTrace(); }
        return list;
    }

    public boolean approveProduct(int usedId) {
        boolean status = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "UPDATE used_products SET approval_status='APPROVED' WHERE used_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, usedId);
            if(ps.executeUpdate() > 0) status = true;
        } catch(Exception e){ e.printStackTrace(); }
        return status;
    }

    public boolean rejectProduct(int usedId) {
        boolean status = false;
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "UPDATE used_products SET approval_status='REJECTED' WHERE used_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, usedId);
            if(ps.executeUpdate() > 0) status = true;
        } catch(Exception e){ e.printStackTrace(); }
        return status;
    }
}