<%-- 
    Document   : header-top
    Created on : 13/09/2017, 22:37:49
    Author     : Wallison
--%>

<%@page import="artemis.beans.UsuarioBeans"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String dir = config.getServletContext().getInitParameter("dir");
%>
<div class="w3ls-header"><!--header-one--> 
    <div class="w3ls-header-right">
        <ul>
            <%
                if(session.getAttribute("usuario") !=null){
            %>
            <li class="dropdown head-dpdn">
                <a href="/<%=dir%>/painelUsuario" aria-expanded="false"><i class="fa fa-user" aria-hidden="true"></i> <%=((UsuarioBeans) session.getAttribute("usuario")).getNome() %></a>
            </li>
            <li class="dropdown head-dpdn">
                <a href="/<%=dir%>/sair" aria-expanded="false"><i class="fa fa-sign-out" aria-hidden="true"></i> Sair</a>
            </li>
            <%  }else{%>
            <li class="dropdown head-dpdn">
                <a href="/<%=dir%>/login" aria-expanded="false"><i class="fa fa-user" aria-hidden="true"></i> Login</a>
            </li>

            <li class="dropdown head-dpdn">
                    <a href="/<%=dir%>/cadastro"><i class="fa fa-user-plus" aria-hidden="true"></i> Cadastro</a>
            </li>
            <%  }%>
        </ul>
    </div>
</div>
