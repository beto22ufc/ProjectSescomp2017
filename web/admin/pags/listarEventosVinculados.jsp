<%-- 
    Document   : listarEventos
    Created on : 31/07/2017, 18:44:27
    Author     : Wallison
--%>

<%@page import="java.util.List"%>
<%@page import="artemis.beans.EventoBeans"%>
<%@page import="artemis.model.Facade"%>
<%@page import="artemis.beans.UsuarioBeans"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String dir = config.getServletContext().getInitParameter("dir");
    UsuarioBeans u = ((UsuarioBeans) session.getAttribute("usuario"));
    Facade facade = new Facade();
    EventoBeans e = facade.getEvento(facade.getCodFromParameter(request.getParameter("e")));
    List<EventoBeans> eventos = e.getEventos();
%>
<div class="col-xs-12">
    <div class="box">
  <div class="box-header">
    <h3 class="box-title">Eventos vinculados ao evento <%=e.getNome().toUpperCase() %></h3>
    <p><a href="/<%=dir%>/painelUsuario/evento/vincularEvento/?e=<%=e.getNome().toLowerCase().replace(" ", "_")+"_"+e.getCodEvento()%>">Vincular novo</a></p>
  </div>
  <!-- /.box-header -->
  <div class="box-body">
    <table id="example1" class="table table-bordered table-striped">
      <thead>
      <tr>
        <th>Código</th>
        <th>Nome</th>
        <th>Categoria</th>
        <th>E-mail</th>
        <th>Localização</th>
        <th>Galeria</th>
        <th>Slideshow</th>
        <th>Eventos</th>
        <th>Atividades</th>
        <th>Inscrições</th>
        <th>Periodos</th>
        <th>Administradores</th>
        <th>Organizadores</th>
        <th>Desvincular</th>
      </tr>
      </thead>
      <tbody>
      <%
          for(int i=0;i<eventos.size();i++){
              EventoBeans evento = eventos.get(i);
              if(evento.getAdministradores().contains(u)){
      %>    
                <tr>
                  <td><%=evento.getCodEvento() %></td>
                  <td><a href="/<%=dir%>/evento/?e=<%=evento.getNome().toLowerCase().replace(" ", "_")+"_"+evento.getCodEvento() %>"><%=evento.getNome()%></a>
                  </td>
                  <td><%=evento.getCategoria()%></td>
                  <td><%=evento.getEmail()%></td>
                  <td><%=evento.getLocalizacao().getNome() %></td>
                  <td><a href="/<%=dir%>/painelUsuario/evento/galeria/?e=<%=evento.getNome().toLowerCase().replace(" ", "_")+"_"+evento.getCodEvento() %>">Galeria</a></td>
                  <td><a href="/<%=dir%>/painelUsuario/evento/slideshow/?e=<%=evento.getNome().toLowerCase().replace(" ", "_")+"_"+evento.getCodEvento() %>">Slideshow</a></td>
                  <td><a href="/<%=dir%>/painelUsuario/evento/eventos/?e=<%=evento.getNome().toLowerCase().replace(" ", "_")+"_"+evento.getCodEvento() %>">Eventos</a></td>
                  <td><a href="/<%=dir%>/painelUsuario/evento/atividades/?e=<%=evento.getNome().toLowerCase().replace(" ", "_")+"_"+evento.getCodEvento() %>">Atividades</a></td>
                  <td><a href="/<%=dir%>/painelUsuario/evento/inscricoes/?e=<%=evento.getNome().toLowerCase().replace(" ", "_")+"_"+evento.getCodEvento() %>">Inscrições</a></td>
                  <td><a href="/<%=dir%>/painelUsuario/evento/periodos/?e=<%=evento.getNome().toLowerCase().replace(" ", "_")+"_"+evento.getCodEvento() %>">Períodos</a></td>
                  <td><a href="/<%=dir%>/painelUsuario/evento/administradores/?e=<%=evento.getNome().toLowerCase().replace(" ", "_")+"_"+evento.getCodEvento() %>">Administradores</a></td>
                  <td><a href="/<%=dir%>/painelUsuario/evento/organizadores/?e=<%=evento.getNome().toLowerCase().replace(" ", "_")+"_"+evento.getCodEvento() %>">Administradores</a></td>
                  <td><a href="#">Desvincular</a></td>
                </tr>
      <%    }
         } %>
      </tbody>
      <tfoot>
      <tr>
        <th>Código</th>
        <th>Nome</th>
        <th>Categoria</th>
        <th>E-mail</th>
        <th>Localização</th>
        <th>Galeria</th>
        <th>Slideshow</th>
        <th>Eventos</th>
        <th>Atividades</th>
        <th>Inscrições</th>
        <th>Periodos</th>
        <th>Administradores</th>
        <th>Organizadores</th>
        <th>Desvincular</th>
      </tr>
      </tfoot>
    </table>
  </div>
  <!-- /.box-body -->
</div>
<!-- /.box -->
</div>
<!-- /.col -->
