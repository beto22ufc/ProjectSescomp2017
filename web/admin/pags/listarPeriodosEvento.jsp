<%-- 
    Document   : listarEventos
    Created on : 31/07/2017, 18:44:27
    Author     : Wallison
--%>

<%@page import="org.apache.commons.mail.EmailException"%>
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
    EventoBeans e = null;
    try{
        e = facade.getEvento(facade.getCodFromParameter(request.getParameter("e")));
        if(!e.getAdministradores().contains(u)){
            response.sendRedirect("/"+dir+"/404");
        }
    }catch(NumberFormatException ex){
        response.sendRedirect("/"+dir+"/404");
    }catch(NullPointerException ex){
        response.sendRedirect("/"+dir+"/404");            
    }catch(Exception ex){
        response.sendRedirect("/"+dir+"/404");            
    }
    if(request.getParameter("rp") != null){
        PeriodoBeans periodo = null;
        try{    
            periodo = facade.getPeriodo(Long.parseLong(request.getParameter("rp")));
            facade.removePeriodoEvento(e, periodo);
            e = facade.getEvento(e.getCodEvento());
            request.setAttribute("msg", "Período removido com sucesso");
        }catch(IllegalAccessException ex){
            request.setAttribute("msg", ex.getMessage());
        }catch(EmailException ex){
            request.setAttribute("msg", ex.getMessage());
        }catch(NumberFormatException ex){
            request.setAttribute("msg", "Código de período inválido!");
        }catch(IllegalArgumentException ex){
            request.setAttribute("msg", ex.getMessage());
        }catch(NullPointerException ex){
            request.setAttribute("msg", "Código de período inválido!");            
        }
    }
%>
<div class="col-xs-12">
    <div class="box">
  <div class="box-header">
    <h3 class="box-title">Períodos do evento <%=e.getNome().toUpperCase() %></h3>
    <p><a href="/<%=dir%>/painelUsuario/evento/adicionarPeriodo?e=<%=e.getNome().toLowerCase().replace(" ", "_")+"_"+e.getCodEvento() %>">Adicionar novo período</a></p>
    <p><%=(request.getAttribute("msg") != null) ? request.getAttribute("msg") : "" %></p>
  </div>
  <!-- /.box-header -->
  <div class="box-body">
    <table id="example1" class="table table-bordered table-striped">
      <thead>
      <tr>
        <th>Inicio</th>
        <th>Termino</th>
        <th>Editar/Remover</th>
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
                  <td><a href="/<%=dir%>/painelUsuario/evento/editarPeriodo/?e=<%=e.getNome().toLowerCase().replace(" ", "_")+"_"+e.getCodEvento() %>&p=<%=p.getCodPeriodo() %>">Editar</a>/<a href="?e=<%=e.getNome().toLowerCase().replace(" ", "_")+"_"+e.getCodEvento() %>&rp=<%=p.getCodPeriodo() %>">Remover</a></td>
                </tr>
      <%    
         } %>
      </tbody>
      <tfoot>
      <tr>
        <th>Inicio</th>
        <th>Termino</th>
        <th>Editar/Remover</th>
      </tr>
      </tfoot>
    </table>
  </div>
  <!-- /.box-body -->
</div>
<!-- /.box -->
</div>
<!-- /.col -->
