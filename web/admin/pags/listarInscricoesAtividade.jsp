<%-- 
    Document   : listarEventos
    Created on : 31/07/2017, 18:44:27
    Author     : Wallison
--%>

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
    AtividadeBeans atividade = null;
    try{
        atividade = facade.getAtividade(facade.getCodFromParameter(request.getParameter("a")));
        if(!atividade.getAdministradores().contains(u)){
            response.sendRedirect("/"+dir+"/404");
        }
    }catch(NumberFormatException e){
        response.sendRedirect("/"+dir+"/404");
    }catch(NullPointerException e){
        response.sendRedirect("/"+dir+"/404");            
    }
    if(request.getParameter("i") != null && request.getParameter("a") != null){
        try{
            InscricaoBeans inscricao = facade.getInscricao(Long.parseLong(request.getParameter("i")));
            facade.removerInscricaoAtividade(atividade, inscricao);
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
    List<InscricaoBeans> inscricoes = atividade.getInscricoes();
%>
<div class="col-xs-12">
    <div class="box">
  <div class="box-header">
    <h3 class="box-title">Inscrições da atividade <%=atividade.getNome().toUpperCase() %></h3>
    <p><%=(request.getParameter("msg") !=null) ? request.getParameter("msg") : "" %></p>
  </div>
  <!-- /.box-header -->
  <div class="box-body">
    <table id="example1" class="table table-bordered table-striped">
      <thead>
      <tr>
        <th>Participante</th>
        <th>Data</th>
        <th>QRCode</th>
        <th>Remover</th>
      </tr>
      </thead>
      <tbody>
      <%
          for(InscricaoBeans inscricao : inscricoes){
      %>    
                <tr>
                  <td><%=inscricao.getParticipante().getNome() %></td>
                  <td><%=inscricao.getData().toString() %></a></td>
                  <td><a href="/<%=dir %>/painelUsuario/evento/geraQRCodeParticipante/?u=<%=inscricao.getParticipante().getNome().toLowerCase().replace(" ", "_")+"_"+inscricao.getParticipante().getCodUsuario()%>">Gerar QRCode</a></td>
                  <td><a href="?a=<%=atividade.getNome().toLowerCase().replace(" ", "_")+"_"+atividade.getCodAtividade() %>&i=<%=atividade.getInscricoes().get(0).getCodInscricao()%>">Remover</a></td>
                </tr>
      <%    
         } %>
      </tbody>
      <tfoot>
      <tr>
        <th>Participante</th>
        <th>Data</th>
        <th>QRCode</th>
        <th>Remover</th>
      </tr>
      </tfoot>
    </table>
  </div>
  <!-- /.box-body -->
</div>
<!-- /.box -->
</div>
<!-- /.col -->
