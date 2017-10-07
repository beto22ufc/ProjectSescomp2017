<%-- 
    Document   : listarEventos
    Created on : 31/07/2017, 18:44:27
    Author     : Wallison
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Collections"%>
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
    if(request.getParameter("i") != null && request.getParameter("e") != null){
        try{
            InscricaoBeans inscricao = facade.getInscricao(Long.parseLong(request.getParameter("i")));
            EventoBeans evt = facade.getEvento(Long.parseLong(request.getParameter("e")));
            facade.removerInscricaoEvento(evt, inscricao);
            request.setAttribute("msg", "Inscrição desfeita com sucesso!");
        }catch(NumberFormatException e){
            request.setAttribute("msg", "Inscrição e/ou evento inválido!");
        }catch(NullPointerException e){
            request.setAttribute("msg", e.getMessage());
        }catch(IllegalArgumentException e){
            request.setAttribute("msg", e.getMessage());
        }catch(Exception e){
            request.setAttribute("msg", e.getMessage());
        }
    }
    List<EventoBeans> eventos = facade.getInscricoesEvento(u);
%>
<div class="col-xs-12">
    <div class="box">
  <div class="box-header">
    <h3 class="box-title">Inscrições em eventos</h3>
    
  </div>
  <!-- /.box-header -->
  <div class="box-body">
    <table id="example1" class="table table-bordered table-striped">
      <thead>
      <tr>
        <th>Evento</th>
        <th>Data</th>
        <th>Validada</th>
        <th>Presente</th>
        <th>Certificado</th>
        <th>Desfazer</th>
      </tr>
      </thead>
      <tbody>
      <%
          for(EventoBeans evento : eventos){
              float participacao = facade.getParticipacao(evento, u)*100;
      %>    
                <tr>
                  <td><a href="/<%=dir%>/evento/?e=<%=evento.getNome().toLowerCase().replace(" ", "_")+"_"+evento.getCodEvento() %>"><%=evento.getNome()%></a></td>
                  <td><%=evento.getInscricoes().get(0).getData().toString() %></a></td>
                  <td><%=(evento.getInscricoes().get(0).isValida()) ? "Validada" : "Não validada" %></td>
                  <td><%=(evento.getInscricoes().get(0).isPresente()) ? "Presente" : "Ausente" %></td>
                  <td><% if(participacao>=evento.getPorcentagemMinimaGerarCertifciado()){%><a href="javascript:void(0);">Certificado</a><%}else{%>Não atingiu <%=evento.getPorcentagemMinimaGerarCertifciado() %>% de participação no evento<br >Sua participação é <%=participacao %>%<%}%></td>
                  <td><a href="?i=<%=evento.getInscricoes().get(0).getCodInscricao() %>&e=<%=evento.getCodEvento() %>">Desfazer</a></td>
                </tr>
      <%    
         } %>
      </tbody>
      <tfoot>
      <tr>
        <th>Evento</th>
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
