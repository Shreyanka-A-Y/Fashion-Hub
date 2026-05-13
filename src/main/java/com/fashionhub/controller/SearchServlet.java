package com.fashionhub.controller;

import java.io.IOException;
import java.util.List;

import com.fashionhub.dao.ProductDAO;
import com.fashionhub.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");

        ProductDAO dao = new ProductDAO();

        List<Product> list = dao.searchProducts(keyword);

        request.setAttribute("products", list);
        request.setAttribute("keyword", keyword);

        request.getRequestDispatcher("jsp/search-results.jsp")
               .forward(request, response);
    }
}