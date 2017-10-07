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
    AtividadeBeans a = null;
    try{
        a = facade.getAtividade(facade.getCodFromParameter(request.getParameter("a")));
        if(!a.getAdministradores().contains(u)){
            response.sendRedirect("/"+dir+"/404");
        }
    }catch(NumberFormatException e){
        response.sendRedirect("/"+dir+"/404");
    }catch(NullPointerException e){
        response.sendRedirect("/"+dir+"/404");            
    }
    if(request.getParameter("rp") != null){
        PeriodoBeans periodo = null;
        try{    
            periodo = facade.getPeriodo(Long.parseLong(request.getParameter("rp")));
            facade.removePeriodoAtividade(a, periodo);
            a = facade.getAtividade(a.getCodAtividade());
            request.setAttribute("msg", "Período removido com sucesso");
        }catch(IllegalAccessException e){
            request.setAttribute("msg", e.getMessage());
        }catch(NumberFormatException e){
            request.setAttribute("msg", "Código de período inválido!");
        }catch(IllegalArgumentException e){
            request.setAttribute("msg", e.getMessage());
        }catch(NullPointerException e){
            request.setAttribute("msg", "Código de período inválido!");            
        }
    }
%>
<div class="col-xs-12">
    <div class="box">
  <div class="box-header">
    <h3 class="box-title">Períodos da atividade <%=a.getNome().toUpperCase() %></h3>
    <p><a href="/<%=dir%>/painelUsuario/atividade/adicionarPeriodo/?a=<%=a.getNome().toLowerCase().replace(" ", "_")+"_"+a.getCodAtividade()%>">Adicionar novo período</a></p>
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
          List<PeriodoBeans> periodos = a.getPeriodoBeanses();
          DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd/MM/yyyy - hh:mm");
          for(PeriodoBeans p : periodos){
      %>    
                <tr>
                  <td><%=p.getInicio().format(dtf) %></td>
                  <td><%=p.getTermino().format(dtf) %></td>
                  <td><a href="/<%=dir%>/painelUsuario/atividade/editarPeriodo/?a=<%=a.getNome().toLowerCase().replace(" ", "_")+"_"+a.getCodAtividade()%>&p=<%=p.getCodPeriodo() %>">Editar</a>/<a href="?a=<%=a.getNome().toLowerCase().replace(" ", "_")+"_"+a.getCodAtividade()%>&rp=<%=p.getCodPeriodo() %>">Remover</a></td>
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
