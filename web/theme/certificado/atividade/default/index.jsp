<%-- 
    Document   : index
    Created on : 05/09/2017, 16:13:02
    Author     : Wallison
--%>

<%@page import="artemis.beans.UsuarioBeans"%>
<%@page import="artemis.model.Facade"%>
<%@page import="artemis.beans.AtividadeBeans"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String dir = config.getServletContext().getInitParameter("dir");
    AtividadeBeans atividade = null;
    UsuarioBeans usuario = (UsuarioBeans) session.getAttribute("usuario");
    Facade facade = new Facade(usuario);
    try{
        atividade = facade.getAtividade(facade.getCodFromParameter(request.getParameter("a")));
    }catch(NumberFormatException e){
        response.sendRedirect("/"+dir+"/404");
    }catch(NullPointerException e){
        response.sendRedirect("/"+dir+"/404");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
