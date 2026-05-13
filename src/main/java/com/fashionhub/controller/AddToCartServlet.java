package com.fashionhub.controller;

import java.io.IOException;

import com.fashionhub.dao.CartDAO;
import com.fashionhub.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/addToCart")
public class AddToCartServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        try {

            HttpSession session =
                    request.getSession();

            User user =
                    (User) session.getAttribute("loggedUser");

            if(user == null) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/jsp/login.jsp");

                return;
            }

            int productId =
                    Integer.parseInt(
                            request.getParameter("productId"));

            int userId =
                    user.getUserId();


            System.out.println("USER ID: " + userId);
            System.out.println("PRODUCT ID: " + productId);


            CartDAO dao =
                    new CartDAO();

            boolean status =
                    dao.addToCart(userId, productId);


            System.out.println("CART STATUS: " + status);


            if(status) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/jsp/cart.jsp");

            } else {

                response.getWriter()
                        .println("Add To Cart Failed");

            }

        } catch(Exception e) {

            e.printStackTrace();

        }

    }
}