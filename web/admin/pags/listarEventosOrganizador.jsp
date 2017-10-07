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
    List<EventoBeans> eventos = facade.getEventos();
%>
<div class="col-xs-12">
    <div class="box">
  <div class="box-header">
    <h3 class="box-title">Meus eventos</h3>
  </div>
  <!-- /.box-header -->
  <div class="box-body">
    <table id="example1" class="table table-bordered table-striped">
      <thead>
      <tr>
        <th>Nome</th>
        <th>Categoria</th>
        <th>E-mail</th>
        <th>Localização</th>
        <th>Periodos</th>
        <th>Validar inscrições</th>
        <th>Marcar presença</th>
      </tr>
      </thead>
      <tbody>
      <%
          for(int i=0;i<eventos.size();i++){
              EventoBeans evento = eventos.get(i);
              if(evento.getAdministradores().contains(u)){
      %>    
                <tr>
                  <td><a href="/<%=dir%>/evento/?e=<%=evento.getNome().toLowerCase().replace(" ", "_")+"_"+evento.getCodEvento() %>"><%=evento.getNome()%></a>
                  </td>
                  <td><%=evento.getCategoria()%></td>
                  <td><%=evento.getEmail()%></td>
                  <td><%=evento.getLocalizacao().getNome() %></td>
                  <td><a href="/<%=dir%>/painelUsuario/evento/periodosVisualizar/?e=<%=evento.getNome().toLowerCase().replace(" ", "_")+"_"+evento.getCodEvento() %>">Períodos</a></td>
                  <td><a href="/<%=dir%>/painelUsuario/organizador/evento/inscricoes/?e=<%=evento.getNome().toLowerCase().replace(" ", "_")+"_"+evento.getCodEvento() %>">Validar inscrições</a></td>
                  <td><a href="/<%=dir%>/painelUsuario/organizador/evento/inscricoes/?e=<%=evento.getNome().toLowerCase().replace(" ", "_")+"_"+evento.getCodEvento() %>">Marcar presença</a></td>
                </tr>
      <%    }
         } %>
      </tbody>
      <tfoot>
      <tr>
        <th>Nome</th>
        <th>Categoria</th>
        <th>E-mail</th>
        <th>Localização</th>
        <th>Periodos</th>
        <th>Validar inscrições</th>
        <th>Marcar presença</th>
      </tr>
      </tfoot>
    </table>
  </div>
  <!-- /.box-body -->
</div>
<!-- /.box -->
</div>
<!-- /.col -->
