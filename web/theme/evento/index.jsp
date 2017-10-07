<%-- 
    Document   : index
    Created on : 28/08/2017, 09:20:13
    Author     : Wallison
--%>

<%@page import="artemis.beans.EventoBeans"%>
<%@page import="artemis.beans.UsuarioBeans"%>
<%@page import="artemis.model.Facade"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String dir = config.getServletContext().getInitParameter("dir");
    UsuarioBeans user = null;
    if(session.getAttribute("usuario") != null ){
        user = (UsuarioBeans) session.getAttribute("usuario"); 
    }
    if(request.getParameter("e") != null){
        Facade f = new Facade(user);
        EventoBeans event = null;
        try{
            event = f.getEvento(f.getCodFromParameter(request.getParameter("e")));
            RequestDispatcher rd = request.getRequestDispatcher("/theme/evento/"+event.getTema()+"/index.jsp");
            rd.include(request, response);
        }catch(NumberFormatException e){
            response.sendRedirect("/"+dir+"/404");
        }catch(NullPointerException e){
            response.sendRedirect("/"+dir+"/404");            
        }catch(Exception e){
            response.sendRedirect("/"+dir+"/404");             
        }
    }
%>