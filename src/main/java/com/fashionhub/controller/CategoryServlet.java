package com.fashionhub.controller;

import java.io.IOException;
import java.util.List;

import com.fashionhub.dao.ProductDAO;
import com.fashionhub.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/category")
public class CategoryServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        int catId = Integer.parseInt(request.getParameter("catId"));

        ProductDAO dao = new ProductDAO();

        List<Product> list = dao.getProductsByCategory(catId);

        request.setAttribute("products", list);
        request.setAttribute("catId", catId);

        request.getRequestDispatcher("jsp/category-products.jsp")
               .forward(request, response);
    }
}