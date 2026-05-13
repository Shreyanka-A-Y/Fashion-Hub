package com.fashionhub.controller;

import java.io.IOException;
import java.util.List;

import com.fashionhub.dao.CartDAO;
import com.fashionhub.dao.OrderDAO;
import com.fashionhub.model.Cart;
import com.fashionhub.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/placeOrder")
public class PlaceOrderServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;


    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {


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


        String address =
                request.getParameter("address");

        String paymentMode =
                request.getParameter("paymentMode");


        CartDAO cartDAO =
                new CartDAO();

        List<Cart> cartList =
                cartDAO.getCartByUser(
                        user.getUserId());


        double totalAmount = 0;


        for(Cart c : cartList) {

            totalAmount +=
                    c.getPrice()
                    * c.getQuantity();
        }


        OrderDAO orderDAO =
                new OrderDAO();

        boolean status =
                orderDAO.placeOrder(
                        user.getUserId(),
                        address,
                        paymentMode,
                        totalAmount,
                        cartList);


        if(status) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/jsp/order-success.jsp");

        } else {

            response.getWriter()
                    .println("Order Failed");

        }

    }

}