package com.fashionhub.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.fashionhub.model.Cart;
import com.fashionhub.util.DBConnection;

public class CartDAO {


    public boolean addToCart(int userId,
                             int productId) {

        boolean status = false;

        try {

            Connection conn =
                    DBConnection.getConnection();

            String sql =
                    "INSERT INTO cart(user_id, product_id, quantity) VALUES(?,?,1)";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ps.setInt(1, userId);
            ps.setInt(2, productId);

            int rows =
                    ps.executeUpdate();

            if(rows > 0) {

                status = true;

            }

        } catch(Exception e) {

            e.printStackTrace();

        }

        return status;
    }



    public List<Cart> getCartByUser(int userId) {

        List<Cart> list =
                new ArrayList<>();

        try {

            Connection conn =
                    DBConnection.getConnection();

            String sql =
                    "SELECT c.cart_id, c.quantity, p.product_id, p.product_name, p.price, p.image " +
                    "FROM cart c " +
                    "JOIN products p " +
                    "ON c.product_id = p.product_id " +
                    "WHERE c.user_id=?";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ps.setInt(1, userId);

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()) {

                Cart cart =
                        new Cart();

                cart.setCartId(
                        rs.getInt("cart_id"));

                cart.setQuantity(
                        rs.getInt("quantity"));

                cart.setProductId(
                        rs.getInt("product_id"));

                cart.setProductName(
                        rs.getString("product_name"));

                cart.setPrice(
                        rs.getDouble("price"));

                cart.setImage(
                        rs.getString("image"));

                list.add(cart);

            }

        } catch(Exception e) {

            e.printStackTrace();

        }

        return list;
    }
    
    public boolean removeCartItem(int cartId) {

        boolean status = false;

        try {

            Connection conn =
                    DBConnection.getConnection();

            String sql =
                    "DELETE FROM cart WHERE cart_id=?";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ps.setInt(1, cartId);

            int rows =
                    ps.executeUpdate();

            if(rows > 0) {

                status = true;

            }

        } catch(Exception e) {

            e.printStackTrace();

        }

        return status;
    }

    public void updateQuantity(int cartId, int change) {

        try {

            Connection conn = DBConnection.getConnection();

            // Prevent quantity going below 1
            String sql =
                "UPDATE cart SET quantity = GREATEST(quantity + ?, 1) WHERE cart_id=?";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, change);
            ps.setInt(2, cartId);

            ps.executeUpdate();

        } catch(Exception e){
            e.printStackTrace();
        }
    }

}