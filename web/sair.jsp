<%-- 
    Document   : sair
    Created on : 03/08/2017, 08:42:00
    Author     : Wallison
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String dir = config.getServletContext().getInitParameter("dir");
    session.removeAttribute("usuario");
    response.sendRedirect("/"+dir+"/login");
%>
