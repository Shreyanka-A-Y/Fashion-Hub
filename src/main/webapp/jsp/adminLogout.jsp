<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 1. Clear the admin attribute from the session
    session.removeAttribute("admin");
    
    // 2. Kill the entire session to be safe
    session.invalidate(); 
    
    // 3. Redirect to the login page
    response.sendRedirect("admin-login.jsp");
%>