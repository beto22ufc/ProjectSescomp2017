<%-- 
    Document   : listarEventos
    Created on : 31/07/2017, 18:44:27
    Author     : Wallison
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.Collection"%>
<%@page import="artemis.beans.InscricaoBeans"%>
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
    if(request.getParameter("i") != null && request.getParameter("a") != null){
        try{
            InscricaoBeans inscricao = facade.getInscricao(Long.parseLong(request.getParameter("i")));
            AtividadeBeans a = facade.getAtividade(Long.parseLong(request.getParameter("a")));
            facade.removerInscricaoAtividade(a, inscricao);
            request.setAttribute("msg", "Inscrição desfeita com sucesso!");
        }catch(NumberFormatException e){
            request.setAttribute("msg", "Inscrição e/ou atividade inválida!");
        }catch(NullPointerException e){
            request.setAttribute("msg", e.getMessage());
        }catch(IllegalArgumentException e){
            request.setAttribute("msg", e.getMessage());
        }catch(Exception e){
            request.setAttribute("msg", e.getMessage());
        }
    }
    List<AtividadeBeans> atividades = facade.getInscricoesAtividade(u);
    
%>
<div class="col-xs-12">
    <div class="box">
  <div class="box-header">
    <h3 class="box-title">Inscrições em atividades</h3>
    <p><%=(request.getAttribute("msg") !=null) ? request.getAttribute("msg") : "" %></p>
  </div>
  <!-- /.box-header -->
  <div class="box-body">
    <table id="example1" class="table table-bordered table-striped">
      <thead>
      <tr>
        <th>Atividade</th>
        <th>Data</th>
        <th>Validada</th>
        <th>Presente</th>
        <th>Certificado</th>
        <th>Desfazer</th>
      </tr>
      </thead>
      <tbody>
      <%
          for(AtividadeBeans atividade : atividades){
      %>    
                <tr>
                  <td><%=atividade.getNome() %></td>
                  <td><%=atividade.getInscricoes().get(0).getData().toString() %></a></td>
                  <td><%=(atividade.getInscricoes().get(0).isValida()) ? "Validada" : "Não validada" %></td>
                  <td><%=(atividade.getInscricoes().get(0).isPresente()) ? "Presente" : "Ausente" %></td>
                  <td>
                      <%
                            EventoBeans vinculado = facade.getEventoVinculado(atividade);
                            if(vinculado !=null){
                              
                                float participacao =  facade.getParticipacao(vinculado, u)*100;
                                if(participacao>=vinculado.getPorcentagemMinimaGerarCertifciado()){
                          
                      %>
                            <a href="#">Certificado</a></td>
                       <%       }else{%>
                                Não atingiu <%=vinculado.getPorcentagemMinimaGerarCertifciado() %>% de participação no evento<br >Sua participação é <%=participacao %>%
                       <%       }
                            }else{
                       %>
                            <a href="#">Certificado</a></td>
                        <%  }%>
                  <td><a href="?i=<%=atividade.getInscricoes().get(0).getCodInscricao()%>&a=<%=atividade.getCodAtividade() %>">Desfazer</a></td>
                </tr>
      <%    
         } %>
      </tbody>
      <tfoot>
      <tr>
        <th>Atividade</th>
        <th>Data</th>
        <th>Validada</th>
        <th>Presente</th>
        <th>Certificado</th>
        <th>Desfazer</th>
      </tr>
      </tfoot>
    </table>
  </div>
  <!-- /.box-body -->
</div>
<!-- /.box -->
</div>
<!-- /.col -->
