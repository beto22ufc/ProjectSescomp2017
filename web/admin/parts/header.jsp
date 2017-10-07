<%-- 
    Document   : header
    Created on : 02/08/2017, 15:39:55
    Author     : Wallison
--%>

<%@page import="artemis.model.ImageManipulation"%>
<%@page import="artemis.beans.UsuarioBeans"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String dir = config.getServletContext().getInitParameter("dir");
%>
<header class="main-header">
    <!-- Logo -->
    <a href="/<%=dir%>/painelUsuario" class="logo">
      <!-- mini logo for sidebar mini 50x50 pixels -->
      <span class="logo-mini"><b>A</b>RT</span>
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg"><b>Artemis</b></span>
    </a>
    <!-- Header Navbar: style can be found in header.less -->
    <nav class="navbar navbar-static-top">
      <!-- Sidebar toggle button-->
      <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
        <span class="sr-only">Toggle navigation</span>
      </a>

      <div class="navbar-custom-menu">
        <ul class="nav navbar-nav">
          <!-- User Account: style can be found in dropdown.less -->
          <li class="dropdown user user-menu">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                <%
                    if (((UsuarioBeans) session.getAttribute("usuario")).getImagemPerfil() == null) {
                %>
               <img src="/<%=dir%>/static/img/avatar-default.png" class="img-circle" alt="User Image" style="width: 25px; height: 25px;">
                <%
                } else {
                %>
                <img src="<%=ImageManipulation.encodeImage(((UsuarioBeans) session.getAttribute("usuario")).getImagemPerfil())%>" class="img-circle" alt="User Image" style="width: 25px; height: 25px;">
                <%  }%>
              <span class="hidden-xs"><%= ((UsuarioBeans) session.getAttribute("usuario")).getNome()  %> </span>
            </a>
            <ul class="dropdown-menu">
              <!-- User image -->
              <li class="user-header">
                <%
                    if (((UsuarioBeans) session.getAttribute("usuario")).getImagemPerfil() == null) {
                %>
               <img src="/<%=dir%>/static/img/avatar-default.png" class="img-circle" alt="User Image">
                <%
                } else {
                %>
                <img src="<%=ImageManipulation.encodeImage(((UsuarioBeans) session.getAttribute("usuario")).getImagemPerfil())%>" class="img-circle" alt="User Image" />
                <%  }%>
                <p>
                    <%= ((UsuarioBeans) session.getAttribute("usuario")).getNome()  %> 
                    <small>Usuário desde <%= ((UsuarioBeans) session.getAttribute("usuario")).getCadastro()%> </small>
                </p>
              </li>
              <!-- Menu Footer-->
              <li class="user-footer">
                <div class="pull-left">
                  <a href="/<%=dir%>/painelUsuario/conta" class="btn btn-default btn-flat">Conta</a>
                </div>
                <div class="pull-right">
                  <a href="/<%=dir%>/sair" class="btn btn-default btn-flat">Sair</a>
                </div>
              </li>
            </ul>
          </li>
          <!-- Control Sidebar Toggle Button 
          <li>
            <a href="#" data-toggle="control-sidebar"><i class="fa fa-gears"></i></a>
          </li>-->
        </ul>
      </div>
    </nav>
  </header>
