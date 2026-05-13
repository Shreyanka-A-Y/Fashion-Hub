package com.fashionhub.controller;

import java.io.IOException;

import com.fashionhub.dao.UserDAO;
import com.fashionhub.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        System.out.println("Email: " + email);
        System.out.println("Password: " + password);

        UserDAO dao = new UserDAO();

        User user = dao.loginUser(email, password);

        if(user != null) {

            System.out.println("Login Success");

            HttpSession session = request.getSession();

            session.setAttribute("loggedUser", user);

            response.sendRedirect(
                request.getContextPath() + "/jsp/index.jsp"
            );

        } else {

            System.out.println("Login Failed");

            response.sendRedirect(
                request.getContextPath() + "/jsp/login.jsp"
            );
        }
    }
}