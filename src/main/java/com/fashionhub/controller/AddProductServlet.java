package com.fashionhub.controller;

import java.io.File;
import java.io.IOException;

import com.fashionhub.dao.ProductDAO;
import com.fashionhub.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/addProduct")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 50
)
public class AddProductServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            String productName = request.getParameter("productName");
            String brand = request.getParameter("brand");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            int stock = Integer.parseInt(request.getParameter("stock"));

            // ✅ CREATE PRODUCT FIRST
            Product product = new Product();

            // ✅ FILE UPLOAD
            Part filePart = request.getPart("image");
            String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();

            String uploadPath = "D:/fashionhub/products";

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            filePart.write(uploadPath + File.separator + fileName);

            // ✅ SET DATA
            product.setCategoryId(categoryId);
            product.setProductName(productName);
            product.setBrand(brand);
            product.setDescription(description);
            product.setPrice(price);
            product.setStock(stock);
            product.setImage(fileName);

            // ✅ DEBUG
            System.out.println("===== PRODUCT DEBUG =====");
            System.out.println("Image Saved As: " + fileName);

            ProductDAO dao = new ProductDAO();
            boolean status = dao.addProduct(product);

            if(status) {
                response.sendRedirect("jsp/products.jsp");
            } else {
                response.getWriter().println("Product Add Failed");
            }

        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}