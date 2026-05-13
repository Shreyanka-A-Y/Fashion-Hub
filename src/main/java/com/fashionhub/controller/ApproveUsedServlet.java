package com.fashionhub.controller;

import java.io.IOException;

import com.fashionhub.dao.UsedProductDAO;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/approveUsed")
public class ApproveUsedServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response) throws IOException {

        int usedId = Integer.parseInt(request.getParameter("usedId"));

        UsedProductDAO dao = new UsedProductDAO();

        dao.approveProduct(usedId);

        response.sendRedirect(
            request.getContextPath() + "/jsp/approve-products.jsp"
        );
    }
}