package com.fashionhub.controller;

import java.io.IOException;

import com.fashionhub.dao.CartDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/removeCartItem")
public class RemoveCartServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int cartId =
                    Integer.parseInt(
                            request.getParameter("cartId"));

            System.out.println("REMOVE CART ID: " + cartId);

            CartDAO dao =
                    new CartDAO();

            boolean status =
                    dao.removeCartItem(cartId);

            System.out.println("REMOVE STATUS: " + status);

            if(status) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/jsp/cart.jsp");

            } else {

                response.getWriter()
                        .println("Remove Failed");

            }

        } catch(Exception e) {

            e.printStackTrace();

        }

    }

}