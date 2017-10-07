<%-- 
    Document   : listarEventos
    Created on : 31/07/2017, 18:44:27
    Author     : Wallison
--%>

<%@page import="artemis.beans.AtividadeBeans"%>
<%@page import="java.util.List"%>
<%@page import="artemis.beans.EventoBeans"%>
<%@page import="artemis.model.Facade"%>
<%@page import="artemis.beans.UsuarioBeans"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String dir = config.getServletContext().getInitParameter("dir");
    UsuarioBeans u = ((UsuarioBeans) session.getAttribute("usuario"));
    Facade facade = new Facade(u);
    List<AtividadeBeans> atividades = facade.getAtividades();
%>
<div class="col-xs-12">
    <div class="box">
  <div class="box-header">
    <h3 class="box-title">Atividades Ministradas</h3>
    <p><%=(request.getParameter("msg") !=null) ? request.getParameter("msg") : "" %></p>
  </div>
  <!-- /.box-header -->
  <div class="box-body">
    <table id="example1" class="table table-bordered table-striped">
      <thead>
      <tr>
        <th>Nome</th>
        <th>Categoria</th>
        <th>Ministrante</th>
        <th>Períodos</th>
        <th>Solicitar recursos</th>
        <th>Deixar de ministrar</th>
      </tr>
      </thead>
      <tbody>
      <%
          for(int i=0;i<atividades.size();i++){
              AtividadeBeans atividade = atividades.get(i);
              if(atividade.getMinistrante() != null && atividade.getMinistrante().equals(u)){
      %>    
                <tr>
                  <td><a href="/<%=dir%>/atividade/?a=<%=atividade.getNome().toLowerCase().replace(" ", "_")+"_"+atividade.getCodAtividade()%>"><%=atividade.getNome()%></a>
                  </td>
                  <td><%=atividade.getCategoria()%></td>
                  <td><%
                        if(atividade.getMinistrante() != null){
                          out.println(atividade.getMinistrante().getNome());
                        }
                  %></td>
                  <td><a href="/<%=dir%>/painelUsuario/atividade/periodosVisualizar/?a=<%=atividade.getNome().toLowerCase().replace(" ", "_")+"_"+atividade.getCodAtividade() %>">Períodos</a></td>
                  <!--<td><a href="#">Lista de espera</a></td>-->
                  <td><a href="/<%=dir%>/painelUsuario/ministrante/atividade/solicitarRecurso/?a=<%=atividade.getNome().toLowerCase().replace(" ", "_")+"_"+atividade.getCodAtividade() %>">Solicitar recursos</a></td>
                  <td><a href="/<%=dir%>/painelUsuario/ministrante/atividade/deixarDeMinistrar/?a=<%=atividade.getNome().toLowerCase().replace(" ", "_")+"_"+atividade.getCodAtividade() %>">Deixar de ministrar</a></td>
                </tr>
      <%    }
         } %>
      </tbody>
      <tfoot>
      <tr>
        <th>Nome</th>
        <th>Categoria</th>
        <th>Ministrante</th>
        <th>Períodos</th>
        <th>Solicitar recursos</th>
        <th>Deixar de ministrar</th>
      </tr>
      </tfoot>
    </table>
  </div>
  <!-- /.box-body -->
</div>
<!-- /.box -->
</div>
<!-- /.col -->
