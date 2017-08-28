<%@page import="artemis.model.ImageManipulation"%>
<%@page import="artemis.beans.UsuarioBeans"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String dir2 = config.getServletContext().getInitParameter("dir");
%>
<aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
      <!-- Sidebar user panel -->
      <div class="user-panel">
        <div class="pull-left image">
            <%
                if (((UsuarioBeans) session.getAttribute("usuario")).getImagemPerfil() == null) {
            %>
           <img src="/<%=dir2%>/static/img/avatar-default.png" class="img-circle" alt="User Image">
            <%
            } else {
            %>
            <img src="<%=ImageManipulation.encodeImage(((UsuarioBeans) session.getAttribute("usuario")).getImagemPerfil())%>" class="img-circle" alt="User Image" style="width: 50px; height: 50px;"/>
            <%  }%>
        </div>
        <div class="pull-left info">
            <p><%= ((UsuarioBeans) session.getAttribute("usuario")).getNome()  %></p>
          <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
        </div>
      </div>
      <!-- search form -->
      <form action="#" method="get" class="sidebar-form">
        <div class="input-group">
          <input type="text" name="q" class="form-control" placeholder="Search...">
              <span class="input-group-btn">
                <button type="submit" name="search" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i>
                </button>
              </span>
        </div>
      </form>
      <!-- /.search form -->
      <!-- sidebar menu: : style can be found in sidebar.less -->
      <ul class="sidebar-menu">
        <li class="header">Negação principal</li>
        <li class="treeview">
            <a href="/<%=dir2%>/painelUsuario">
            <i class="fa fa-dashboard"></i> <span>Dashboard</span>
            
          </a>
        </li>
        <li>
          <a href="/<%=dir2%>/painelUsuario/usuarios">
            <i class="fa fa-users"></i> <span>Usuários</span>
          </a>
        </li>
        
        <% if(((UsuarioBeans) session.getAttribute("usuario")).getTipo() != null){ %>
        <li class="treeview">
          <a href="#">
            <i class="fa fa-users"></i>
            <span>Usuários</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
              <li>
                <a href="/<%=dir2%>/painelUsuario/usuarios">
                  <i class="fa fa-bars"></i> <span>Usuários</span>
                </a>
              </li>
            <li><a href="/<%=dir2%>/painelUsuario/adicionarNivelUsuario"><i class="fa fa-plus"></i> Adicionar nível</a></li>
            <li><a href="/<%=dir2%>/painelUsuario/removerNivelUsuario"><i class="fa fa-minus-circle"></i> Remover nível</a></li>
          </ul>
        </li>
        <% } %>
        
        <% if(((UsuarioBeans) session.getAttribute("usuario")).getTipo() != null && ((UsuarioBeans) session.getAttribute("usuario")).getTipo().contains("adminEvento")){ %>
        <li class="treeview">
          <a href="#">
            <i class="fa fa-calendar"></i>
            <span>Evento</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
              <li><a href="/<%=dir2%>/painelUsuario/criarEvento"><i class="fa fa-plus"></i> Criar Evento</a></li>
            <li><a href="/<%=dir2%>/painelUsuario/listarEventos"><i class="fa fa-bars"></i> Listar Eventos</a></li>
          </ul>
        </li>
        <% } %>
        <% if(((UsuarioBeans) session.getAttribute("usuario")).getTipo() != null && ((UsuarioBeans) session.getAttribute("usuario")).getTipo().contains("adminEvento")){ %>
        <li class="treeview">
          <a href="#">
            <i class="fa fa-puzzle-piece"></i>
            <span>Atividade</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
              <li><a href="/<%=dir2%>/painelUsuario/novaAtividade"><i class="fa fa-plus"></i> Criar Atividade</a></li>
            <li><a href="/<%=dir2%>/painelUsuario/listarAtividades"><i class="fa fa-bars"></i> Listar Atividades</a></li>
          </ul>
        </li>
        <% } %>
      </ul>
    </section>
    <!-- /.sidebar -->
  </aside>