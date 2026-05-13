package com.fashionhub.controller;

import java.io.File;
import java.io.IOException;

import com.fashionhub.dao.UsedProductDAO;
import com.fashionhub.model.UsedProduct;
import com.fashionhub.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/sellUsedProduct")
@MultipartConfig
public class SellUsedProductServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        try {

            User user = (User) request.getSession().getAttribute("loggedUser");

            if(user == null){
                response.sendRedirect("jsp/login.jsp");
                return;
            }

            int sellerId = user.getUserId();

            String productName = request.getParameter("productName");
            String description = request.getParameter("description");
            String condition = request.getParameter("condition");
            
            String coinParam = request.getParameter("coinPrice");

            if(coinParam == null || coinParam.isEmpty()){
                response.getWriter().println("Coin price is required");
                return;
            }

            int coinPrice = Integer.parseInt(coinParam);

            // 🔥 NEW: CATEGORY
            String catParam = request.getParameter("categoryId");

            if(catParam == null || catParam.isEmpty()){
                response.getWriter().println("Category is required");
                return;
            }

            int categoryId = Integer.parseInt(catParam);

            
            // 📸 IMAGE UPLOAD
            Part filePart = request.getPart("image");
            String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();

            String uploadPath = getServletContext().getRealPath("") + "assets/images/products";

            File uploadDir = new File(uploadPath);
            if(!uploadDir.exists()){
                uploadDir.mkdirs();
            }

            filePart.write(uploadPath + File.separator + fileName);

            // 📦 CREATE OBJECT
            UsedProduct product = new UsedProduct();

            product.setSellerId(sellerId);
            product.setCategoryId(categoryId);   // 🔥 IMPORTANT
            product.setProductName(productName);
            product.setDescription(description);
            product.setProductCondition(condition);
            product.setCoinPrice(coinPrice);
            product.setImage(fileName);

            product.setApprovalStatus("PENDING"); // 🔥 IMPORTANT
            product.setBuyerId(0);                // 🔥 default

            // 💾 SAVE
            UsedProductDAO dao = new UsedProductDAO();
            boolean status = dao.addUsedProduct(product);

            if(status){
                response.sendRedirect("jsp/used-market.jsp");
            } else {
                response.getWriter().println("Upload Failed");
            }

        } catch(Exception e){
            e.printStackTrace();
        }
    }
}