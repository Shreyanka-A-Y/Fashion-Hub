package com.fashionhub.controller;

import java.io.IOException;

import com.fashionhub.dao.CartDAO;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/updateCart")
public class UpdateCartServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response) throws IOException {

        int cartId = Integer.parseInt(request.getParameter("cartId"));
        String action = request.getParameter("action");

        CartDAO dao = new CartDAO();

        if(action.equals("increase")) {
            dao.updateQuantity(cartId, 1);
        } else if(action.equals("decrease")) {
            dao.updateQuantity(cartId, -1);
        }

        response.sendRedirect(
            request.getContextPath() + "/jsp/cart.jsp"
        );
    }
}