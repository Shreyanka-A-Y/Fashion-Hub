package com.fashionhub.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.fashionhub.model.User;
import com.fashionhub.dao.UserDAO; // Ensure you have a UserDAO to handle the DB update

@WebServlet("/updateProfile")
public class UpdateProfileServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loggedUser");

        if (user != null) {
            // Get data from the JSP form
            String fullName = request.getParameter("fullName");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");

            // Update the object
            user.setFullName(fullName);
            user.setPhone(phone);
            user.setAddress(address);

            // Update the Database via DAO
            UserDAO dao = new UserDAO();
            boolean success = dao.updateUser(user);

            if (success) {
                session.setAttribute("loggedUser", user); // Update session with new data
                response.sendRedirect("jsp/profile.jsp?view=settings&success=1");
            } else {
                response.sendRedirect("jsp/profile.jsp?view=settings&error=1");
            }
        } else {
            response.sendRedirect("login.jsp");
        }
    }
}