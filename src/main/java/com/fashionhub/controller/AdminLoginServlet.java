package com.fashionhub.controller;

import java.io.IOException;

import com.fashionhub.dao.AdminDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/adminLogin")
public class AdminLoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        AdminDAO dao = new AdminDAO();

        if(dao.login(username, password)) {

            HttpSession session = request.getSession();
            session.setAttribute("admin", username);

            response.sendRedirect(
                request.getContextPath() + "/jsp/admin-dashboard.jsp");

        } else {

            response.getWriter().println("Invalid Admin Credentials");
        }
    }
}