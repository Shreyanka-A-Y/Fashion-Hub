package com.fashionhub.controller;

import java.io.IOException;

import com.fashionhub.dao.UsedProductDAO;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/rejectUsed")
public class RejectUsedServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response) throws IOException {

        int usedId = Integer.parseInt(request.getParameter("usedId"));

        UsedProductDAO dao = new UsedProductDAO();

        dao.rejectProduct(usedId);

        response.sendRedirect(
            request.getContextPath() + "/jsp/approve-products.jsp"
        );
    }
}