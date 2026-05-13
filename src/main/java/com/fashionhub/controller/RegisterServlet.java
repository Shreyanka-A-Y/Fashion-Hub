package com.fashionhub.controller;

import java.io.IOException;

import com.fashionhub.dao.UserDAO;
import com.fashionhub.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String fullName =
                request.getParameter("fullName");

        String email =
                request.getParameter("email");

        String password =
                request.getParameter("password");

        String phone =
                request.getParameter("phone");

        User user = new User();

        user.setFullName(fullName);
        user.setEmail(email);
        user.setPassword(password);
        user.setPhone(phone);

        UserDAO dao = new UserDAO();

        boolean status = dao.registerUser(user);

        if(status) {

            response.sendRedirect(
                request.getContextPath() + "/jsp/login.jsp"
            );

        } else {

            response.sendRedirect(
                request.getContextPath() + "/jsp/register.jsp"
            );
        }
    }
}