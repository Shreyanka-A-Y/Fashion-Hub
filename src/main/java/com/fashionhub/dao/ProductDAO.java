package com.fashionhub.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.fashionhub.model.Product;
import com.fashionhub.util.DBConnection;

public class ProductDAO {

   public boolean addProduct(Product product) {

    boolean status = false;

    try {

        Connection conn =
                DBConnection.getConnection();

        String sql =
                "INSERT INTO products(category_id, product_name, brand, description, price, stock, image) VALUES (?, ?, ?, ?, ?, ?, ?)";

        PreparedStatement ps =
                conn.prepareStatement(sql);

        ps.setInt(1, product.getCategoryId());
        ps.setString(2, product.getProductName());
        ps.setString(3, product.getBrand());
        ps.setString(4, product.getDescription());
        ps.setDouble(5, product.getPrice());
        ps.setInt(6, product.getStock());
        ps.setString(7, product.getImage());

        int rows = ps.executeUpdate();

        System.out.println("Rows Inserted: " + rows);

        if(rows > 0) {

            status = true;

        }

    } catch(Exception e) {

        System.out.println("DAO ERROR");
        e.printStackTrace();

    }

    return status;
}



    public List<Product> getAllProducts() {

        List<Product> list =
                new ArrayList<>();

        try {

            Connection conn =
                    DBConnection.getConnection();

            String sql =
                    "SELECT * FROM products WHERE status='ACTIVE'";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()) {

                Product p =
                        new Product();

                p.setProductId(
                        rs.getInt("product_id"));

                p.setCategoryId(
                        rs.getInt("category_id"));

                p.setProductName(
                        rs.getString("product_name"));

                p.setBrand(
                        rs.getString("brand"));

                p.setDescription(
                        rs.getString("description"));

                p.setPrice(
                        rs.getDouble("price"));

                p.setStock(
                        rs.getInt("stock"));

                p.setImage(
                        rs.getString("image"));

                list.add(p);

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return list;
    }
    
    public Product getProductById(int productId) {

        Product p = null;

        try {

            Connection conn =
                    DBConnection.getConnection();

            String sql =
            		"SELECT * FROM products " +
            		"WHERE product_id=? " +
            		"AND status='ACTIVE'";
            
            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ps.setInt(1, productId);

            ResultSet rs =
                    ps.executeQuery();

            if(rs.next()) {

                p = new Product();

                p.setProductId(
                        rs.getInt("product_id"));

                p.setCategoryId(
                        rs.getInt("category_id"));

                p.setProductName(
                        rs.getString("product_name"));

                p.setBrand(
                        rs.getString("brand"));

                p.setDescription(
                        rs.getString("description"));

                p.setPrice(
                        rs.getDouble("price"));

                p.setStock(
                        rs.getInt("stock"));

                p.setImage(
                        rs.getString("image"));

            }

        } catch(Exception e) {

            e.printStackTrace();

        }

        return p;
    }
    
    public List<Product> searchProducts(String keyword) {

        List<Product> list = new ArrayList<>();

        try {
            Connection conn = DBConnection.getConnection();

            String sql =
            		"SELECT * FROM products " +
            		"WHERE status='ACTIVE' " +
            		"AND (product_name LIKE ? OR brand LIKE ?)";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");

            ResultSet rs = ps.executeQuery();

            while(rs.next()) {

                Product p = new Product();

                p.setProductId(rs.getInt("product_id"));
                p.setCategoryId(rs.getInt("category_id"));
                p.setProductName(rs.getString("product_name"));
                p.setBrand(rs.getString("brand"));
                p.setDescription(rs.getString("description"));
                p.setPrice(rs.getDouble("price"));
                p.setStock(rs.getInt("stock"));
                p.setImage(rs.getString("image"));

                list.add(p);
            }

        } catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }
    
    public List<Product> getProductsByCategory(int categoryId) {

        List<Product> list = new ArrayList<>();

        try {
            Connection conn = DBConnection.getConnection();

            String sql =
            		"SELECT * FROM products " +
            		"WHERE category_id=? " +
            		"AND status='ACTIVE'";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, categoryId);

            ResultSet rs = ps.executeQuery();

            while(rs.next()) {

                Product p = new Product();

                p.setProductId(rs.getInt("product_id"));
                p.setCategoryId(rs.getInt("category_id"));
                p.setProductName(rs.getString("product_name"));
                p.setBrand(rs.getString("brand"));
                p.setDescription(rs.getString("description"));
                p.setPrice(rs.getDouble("price"));
                p.setStock(rs.getInt("stock"));
                p.setImage(rs.getString("image"));

                list.add(p);
            }

        } catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }
    

}

