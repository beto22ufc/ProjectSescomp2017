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
    <h3 class="box-title">Minhas atividades</h3>
    <p><%=(request.getParameter("msg") !=null) ? request.getParameter("msg") : "" %></p>
    </div>
  <!-- /.box-header -->
  <div class="box-body">
    <table id="example1" class="table table-bordered table-striped">
      <thead>
      <tr>
        <th>Nome</th>
        <th>Ministrante</th>
        <th>Vagas</th>
        <th>Pagamento</th>
        <th>Períodos</th>
        <th>Validar inscrições</th>
        <th>Marcar presença</th>
      </tr>
      </thead>
      <tbody>
      <%
          for(AtividadeBeans atividade : atividades){
              if(atividade.getAdministradores().contains(u) || atividade.getOrganizadores().contains(u)){
      %>    
                <tr>
                  <td><a href="/<%=dir%>/evento/?a=<%=atividade.getNome().toLowerCase().replace(" ", "_")+"_"+atividade.getCodAtividade()%>"><%=atividade.getNome()%></a>
                  </td>
                  <td><%
                        if(atividade.getMinistrante() != null){
                          out.println(atividade.getMinistrante().getNome());
                        }else{
                        %>
                        <a href="/<%=dir%>/painelUsuario/atividade/adicionarMinistrante/?a=<%=atividade.getNome().toLowerCase().replace(" ", "_")+"_"+atividade.getCodAtividade()%>">Adicionar ministrante</a>
                      <%      
                        }
                  %></td>
                  <td><%=atividade.getLimiteVagas() %></td>
                  <td><%
                        if(atividade.getTipoPagamento()==1){
                            out.println("Nenhum");
                        }else if(atividade.getNivel()==2){
                            out.println("Dinheiro");
                        }else if(atividade.getNivel()==3){
                            out.println("Alimento não perecível");
                        }else{
                            out.println("Pagamento inválido!");
                        }
                      %></td>
                  <td><a href="/<%=dir%>/painelUsuario/atividade/periodosVisualizar/?a=<%=atividade.getNome().toLowerCase().replace(" ", "_")+"_"+atividade.getCodAtividade() %>">Períodos</a></td>
                  <td><a href="/<%=dir%>/painelUsuario/organizador/atividade/inscricoes/?a=<%=atividade.getNome().toLowerCase().replace(" ", "_")+"_"+atividade.getCodAtividade() %>">Validar inscrições</a></td>
                  <td><a href="/<%=dir%>/painelUsuario/organizador/atividade/inscricoes/?a=<%=atividade.getNome().toLowerCase().replace(" ", "_")+"_"+atividade.getCodAtividade() %>">Marcar presença</a></td>                  
                </tr>
      <%    }
         } %>
      </tbody>
      <tfoot>
      <tr>
        <th>Nome</th>
        <th>Ministrante</th>
        <th>Vagas</th>
        <th>Pagamento</th>
        <th>Períodos</th>
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
