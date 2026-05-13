package com.fashionhub.controller;

import java.io.IOException;

import com.fashionhub.dao.UsedProductDAO;
import com.fashionhub.model.User;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/buyUsedProduct")
public class BuyUsedProductServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response) throws IOException {

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

        int usedId =
                Integer.parseInt(
                        request.getParameter("usedId"));

        UsedProductDAO dao =
                new UsedProductDAO();

        boolean status =
                dao.buyUsedProduct(
                        user.getUserId(),
                        usedId);

        if(status) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/jsp/purchase-success.jsp");

        } else {

            response.sendRedirect(
                    request.getContextPath()
                    + "/jsp/purchase-failed.jsp");
        }
    }
}