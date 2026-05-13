package com.fashionhub.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.fashionhub.model.Cart;
import com.fashionhub.util.DBConnection;

public class OrderDAO {


    public boolean placeOrder(int userId,
                              String address,
                              String paymentMode,
                              double totalAmount,
                              List<Cart> cartList) {

        boolean status = false;

        Connection conn = null;

        try {

            conn =
                    DBConnection.getConnection();

            conn.setAutoCommit(false);


            /*
             * STEP 1
             * INSERT ORDER
             */

            String orderSql =
                    "INSERT INTO orders(user_id, total_amount, payment_mode, shipping_address) VALUES(?,?,?,?)";

            PreparedStatement orderPs =
                    conn.prepareStatement(orderSql,
                            PreparedStatement.RETURN_GENERATED_KEYS);

            orderPs.setInt(1, userId);

            orderPs.setDouble(2, totalAmount);

            orderPs.setString(3, paymentMode);

            orderPs.setString(4, address);

            int orderRows =
                    orderPs.executeUpdate();


            int orderId = 0;


            if(orderRows > 0) {

                ResultSet rs =
                        orderPs.getGeneratedKeys();

                if(rs.next()) {

                    orderId =
                            rs.getInt(1);
                }
            }


            /*
             * STEP 2
             * INSERT ORDER ITEMS
             */

            String itemSql =
                    "INSERT INTO order_items(order_id, product_id, quantity, price) VALUES(?,?,?,?)";

            PreparedStatement itemPs =
                    conn.prepareStatement(itemSql);


            for(Cart c : cartList) {

                itemPs.setInt(1, orderId);

                itemPs.setInt(2, c.getProductId());

                itemPs.setInt(3, c.getQuantity());

                itemPs.setDouble(4, c.getPrice());

                itemPs.addBatch();
            }

            itemPs.executeBatch();


            /*
             * STEP 3
             * CLEAR CART
             */

            String clearSql =
                    "DELETE FROM cart WHERE user_id=?";

            PreparedStatement clearPs =
                    conn.prepareStatement(clearSql);

            clearPs.setInt(1, userId);

            clearPs.executeUpdate();


            /*
             * STEP 4
             * ADD COINS
             */

            int earnedCoins =
                    (int) (totalAmount / 10);


            String coinSql =
                    "UPDATE users SET coins = coins + ? WHERE user_id=?";

            PreparedStatement coinPs =
                    conn.prepareStatement(coinSql);

            coinPs.setInt(1, earnedCoins);

            coinPs.setInt(2, userId);

            coinPs.executeUpdate();


            /*
             * STEP 5
             * WALLET TRANSACTION
             */

            String walletSql =
                    "INSERT INTO wallet_transactions(user_id, coins, txn_type, reason) VALUES(?,?,?,?)";

            PreparedStatement walletPs =
                    conn.prepareStatement(walletSql);

            walletPs.setInt(1, userId);

            walletPs.setInt(2, earnedCoins);

            walletPs.setString(3, "CREDIT");

            walletPs.setString(4, "Order Reward");

            walletPs.executeUpdate();


            conn.commit();

            status = true;


        } catch(Exception e) {

            e.printStackTrace();

            try {

                conn.rollback();

            } catch(Exception ex) {

                ex.printStackTrace();
            }

        }

        return status;
    }
    
    public List<String[]> getUserOrders(int userId) {

        List<String[]> list = new ArrayList<>();

        try {

            Connection conn = DBConnection.getConnection();

            String sql = "SELECT * FROM orders WHERE user_id=? ORDER BY order_id DESC";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while(rs.next()) {

                String[] order = new String[5];

                order[0] = rs.getString("order_id");
                order[1] = rs.getString("total_amount");
                order[2] = rs.getString("payment_mode");
                order[3] = rs.getString("order_status");
                order[4] = rs.getString("created_at");

                list.add(order);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public List<Cart> getOrderItems(int orderId) {

        List<Cart> list = new java.util.ArrayList<>();

        try {

            Connection conn = DBConnection.getConnection();

            String sql =
                    "SELECT p.product_name, p.image, oi.quantity, oi.price " +
                    "FROM order_items oi " +
                    "JOIN products p ON oi.product_id = p.product_id " +
                    "WHERE oi.order_id=?";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, orderId);

            ResultSet rs = ps.executeQuery();

            while(rs.next()) {

                Cart c = new Cart();

                c.setProductName(rs.getString("product_name"));
                c.setImage(rs.getString("image"));
                c.setQuantity(rs.getInt("quantity"));
                c.setPrice(rs.getDouble("price"));

                list.add(c);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    /*
     * CANCEL ORDER
     */

    public boolean cancelOrder(int orderId){

        boolean status = false;

        try{

            Connection conn =
                    DBConnection.getConnection();

            String sql =
                    "UPDATE orders SET order_status='CANCELLED' WHERE order_id=?";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ps.setInt(1, orderId);

            int rows =
                    ps.executeUpdate();

            if(rows > 0){

                status = true;
            }

        } catch(Exception e){

            e.printStackTrace();
        }

        return status;
    }
}