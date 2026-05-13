package com.fashionhub.controller;

import java.io.IOException;

import com.fashionhub.dao.OrderDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/cancelOrder")
public class CancelOrderServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        int orderId =
                Integer.parseInt(
                        request.getParameter("orderId"));

        OrderDAO dao =
                new OrderDAO();

        boolean status =
                dao.cancelOrder(orderId);

        if(status){

            response.sendRedirect(
                    request.getContextPath()
                    + "/jsp/my-orders.jsp");

        } else {

            response.getWriter()
                    .println("Order Cancel Failed");
        }
    }
}