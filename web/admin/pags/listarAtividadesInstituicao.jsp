<%-- 
    Document   : listarEventos
    Created on : 31/07/2017, 18:44:27
    Author     : Wallison
--%>

<%@page import="artemis.beans.InstituicaoBeans"%>
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
    InstituicaoBeans instituicao = facade.getInstituicao(facade.getCodFromParameter(request.getParameter("i")));
    List<AtividadeBeans> atividades = instituicao.getAtividades();
%>
<div class="col-xs-12">
    <div class="box">
  <div class="box-header">
    <h3 class="box-title">Atividades da instituição <%=instituicao.getNome().toUpperCase() %></h3>
    </div>
  <!-- /.box-header -->
  <div class="box-body">
    <table id="example1" class="table table-bordered table-striped">
      <thead>
      <tr>
        <th>Nome</th>
        <th>Categoria</th>
        <th>Ministrante</th>
        <th>Vagas</th>
        <th>Vagas internas</th>
        <th>Vagas externas</th>
        <th>Nível</th>
        <th>Pagamento</th>
      </tr>
      </thead>
      <tbody>
      <%
          for(int i=0;i<atividades.size();i++){
              AtividadeBeans atividade = atividades.get(i);
      %>    
                <tr>
                  <td><a href="/<%=dir%>/evento/?a=<%=atividade.getNome().toLowerCase().replace(" ", "_")+"_"+atividade.getCodAtividade()%>"><%=atividade.getNome()%></a>
                  </td>
                  <td><%=atividade.getCategoria()%></td>
                  <td><%
                        if(atividade.getMinistrante() != null){
                          out.println(atividade.getMinistrante().getNome());
                        }else{
                        %>
                        Sem ministrante
                      <%      
                        }
                  %></td>
                  <td><%=atividade.getLimiteVagas() %></td>
                  <td><%=atividade.getVagasInternas()%></td>
                  <td><%=atividade.getVagasPublicas()%></td>
                  <td><%
                        if(atividade.getNivel()==0){
                            out.println("Nenhum nível");
                        }else if(atividade.getNivel()==1){
                            out.println("Básico");
                        }else if(atividade.getNivel()==2){
                            out.println("Intermediário");
                        }else if(atividade.getNivel()==3){
                            out.println("Avançado");
                        }else{
                            out.println("Nível inválido!");
                        }
                      %></td>
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
                </tr>
      <% 
         } %>
      </tbody>
      <tfoot>
      <tr>
        <th>Nome</th>
        <th>Categoria</th>
        <th>Ministrante</th>
        <th>Vagas</th>
        <th>Vagas internas</th>
        <th>Vagas externas</th>
        <th>Nível</th>
        <th>Pagamento</th>
        <!--<th>Lista de espera</th>-->
      </tr>
      </tfoot>
    </table>
  </div>
  <!-- /.box-body -->
</div>
<!-- /.box -->
</div>
<!-- /.col -->
