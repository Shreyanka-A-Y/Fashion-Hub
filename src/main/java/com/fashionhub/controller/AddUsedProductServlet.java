package com.fashionhub.controller;

import java.io.IOException;

import com.fashionhub.dao.UsedProductDAO;
import com.fashionhub.model.UsedProduct;
import com.fashionhub.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/addUsedProduct")
public class AddUsedProductServlet extends HttpServlet {

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


        UsedProduct up =
                new UsedProduct();

        up.setSellerId(
                user.getUserId());

        up.setCategoryId(1);

        up.setProductName(
                request.getParameter("productName"));

        up.setDescription(
                request.getParameter("description"));

        up.setProductCondition(
                request.getParameter("condition"));

        up.setCoinPrice(
                Integer.parseInt(
                        request.getParameter("coinPrice")));

        up.setImage(
                request.getParameter("image"));


        UsedProductDAO dao =
                new UsedProductDAO();

        boolean status =
                dao.addUsedProduct(up);


        if(status) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/jsp/used-market.jsp");

        } else {

            response.getWriter()
                    .println("Upload Failed");

        }

    }

}