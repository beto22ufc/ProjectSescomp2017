<%-- 
    Document   : listarEventos
    Created on : 31/07/2017, 18:44:27
    Author     : Wallison
--%>

<%@page import="artemis.beans.AtividadeBeans"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="artemis.beans.PeriodoBeans"%>
<%@page import="java.util.List"%>
<%@page import="artemis.beans.EventoBeans"%>
<%@page import="artemis.model.Facade"%>
<%@page import="artemis.beans.UsuarioBeans"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String dir = config.getServletContext().getInitParameter("dir");
    UsuarioBeans u = ((UsuarioBeans) session.getAttribute("usuario"));
    Facade facade = new Facade(u);
    EventoBeans e = facade.getEvento(facade.getCodFromParameter(request.getParameter("e")));
%>
<div class="col-xs-12">
    <div class="box">
  <div class="box-header">
    <h3 class="box-title">Períodos do evento <%=e.getNome().toUpperCase() %></h3>
  </div>
  <!-- /.box-header -->
  <div class="box-body">
    <table id="example1" class="table table-bordered table-striped">
      <thead>
      <tr>
        <th>Inicio</th>
        <th>Termino</th>
      </tr>
      </thead>
      <tbody>
      <%
          List<PeriodoBeans> periodos = e.getPeriodos();
          DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd/MM/yyyy - hh:mm");
          for(PeriodoBeans p : periodos){
      %>    
                <tr>
                  <td><%=p.getInicio().format(dtf) %></td>
                  <td><%=p.getTermino().format(dtf) %></td>
                </tr>
      <%    
         } %>
      </tbody>
      <tfoot>
      <tr>
        <th>Inicio</th>
        <th>Termino</th>
      </tr>
      </tfoot>
    </table>
  </div>
  <!-- /.box-body -->
</div>
<!-- /.box -->
</div>
<!-- /.col -->
