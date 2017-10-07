
<%-- 
    Document   : listarEventos
    Created on : 31/07/2017, 18:44:27
    Author     : Wallison
--%>

<%@page import="artemis.beans.InstituicaoBeans"%>
<%@page import="java.util.List"%>
<%@page import="artemis.beans.EventoBeans"%>
<%@page import="artemis.model.Facade"%>
<%@page import="artemis.beans.UsuarioBeans"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String dir = config.getServletContext().getInitParameter("dir");
    UsuarioBeans u = ((UsuarioBeans) session.getAttribute("usuario"));
    Facade facade = new Facade();
    InstituicaoBeans instituicao = facade.getInstituicao(facade.getCodFromParameter(request.getParameter("i")));
    List<EventoBeans> eventos = instituicao.getEventos();
%>
<div class="col-xs-12">
    <div class="box">
  <div class="box-header">
    <h3 class="box-title">Eventos da instituição <%=instituicao.getNome().toUpperCase() %></h3>
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
      </tr>
      </thead>
      <tbody>
      <%
          for(int i=0;i<eventos.size();i++){
              EventoBeans evento = eventos.get(i);
      %>    
                <tr>
                  <td><a href="/<%=dir%>/evento/?e=<%=evento.getNome().toLowerCase().replace(" ", "_")+"_"+evento.getCodEvento() %>"><%=evento.getNome()%></a>
                  </td>
                  <td><%=evento.getCategoria()%></td>
                  <td><%=evento.getEmail()%></td>
                  <td><%=evento.getLocalizacao().getNome() %></td>
                </tr>
      <%    
         } %>
      </tbody>
      <tfoot>
      <tr>
        <th>Nome</th>
        <th>Categoria</th>
        <th>E-mail</th>
        <th>Localização</th>
      </tr>
      </tfoot>
    </table>
  </div>
  <!-- /.box-body -->
</div>
<!-- /.box -->
</div>
<!-- /.col -->
