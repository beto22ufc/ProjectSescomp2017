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
    EventoBeans evento = null;
    try{
        evento = facade.getEvento(facade.getCodFromParameter(request.getParameter("e")));
        if(!evento.getAdministradores().contains(u) && !evento.getOrganizadores().contains(u)){
            response.sendRedirect("/"+dir+"/404");
        }
    }catch(NumberFormatException e){
        response.sendRedirect("/"+dir+"/404");
    }catch(NullPointerException e){
        response.sendRedirect("/"+dir+"/404");            
    }
    if(request.getParameter("pi") != null){
        InscricaoBeans i = null;
        try{
            i = facade.getInscricao(Long.parseLong(request.getParameter("vi")));
            facade.marcaPresencaInscricaoEvento(evento, i);
            request.setAttribute("msg", "Presença marcada com sucesso!");
        }catch(NumberFormatException e){
            request.setAttribute("msg", "Inscrição e/ou evento inválido!");
        }catch(NullPointerException e){
            request.setAttribute("msg",e.getMessage());         
        }catch(IllegalArgumentException e){
            request.setAttribute("msg",e.getMessage());         
        }catch(IllegalAccessException e){
            request.setAttribute("msg",e.getMessage());         
        }catch(Exception e){
            request.setAttribute("msg",e.getMessage());         
        }
        
    }
    if(request.getParameter("vi") != null){
        InscricaoBeans i = null;
        try{
            i = facade.getInscricao(Long.parseLong(request.getParameter("vi")));
            facade.validaInscricaoEvento(evento, i);
            request.setAttribute("msg", "Inscrição validada com sucesso!");
        }catch(NumberFormatException e){
            request.setAttribute("msg", "Inscrição e/ou evento inválido!");
        }catch(NullPointerException e){
            request.setAttribute("msg",e.getMessage());         
        }catch(IllegalArgumentException e){
            request.setAttribute("msg",e.getMessage());         
        }catch(IllegalAccessException e){
            request.setAttribute("msg",e.getMessage());         
        }catch(Exception e){
            request.setAttribute("msg",e.getMessage());         
        }
        
    }
    List<InscricaoBeans> inscricoes = evento.getInscricoes();
%>
<div class="col-xs-12">
    <div class="box">
  <div class="box-header">
    <h3 class="box-title">Inscrições do evento <%=evento.getNome().toUpperCase() %></h3>
    <p><a href="/<%=dir%>/painelUsuario/evento/inscricoes/presencaQRCode/?e=<%=evento.getNome().toLowerCase().replace(" ", "_")+"_"+evento.getCodEvento()%>">Marcar presença QRCode</a></p>
    <p><%=(request.getAttribute("msg") !=null) ? request.getAttribute("msg") : "" %></p>
  </div>
  <!-- /.box-header -->
  <div class="box-body">
    <table id="example1" class="table table-bordered table-striped">
      <thead>
      <tr>
        <th>Participante</th>
        <th>Data</th>
        <th>Validar</th>
        <th>Marcar presença</th>
      </tr>
      </thead>
      <tbody>
      <%
          for(InscricaoBeans inscricao : inscricoes){
      %>    
                <tr>
                  <td><%=inscricao.getParticipante().getNome() %></td>
                  <td><%=inscricao.getData().toString() %></a></td>
                  <td><%if(inscricao.isValida()){%>Validada<%}else{%><a href="?e=<%=evento.getNome().toLowerCase().replace(" ", "_")+"_"+evento.getCodEvento() %>&vi=<%=inscricao.getCodInscricao() %>">Validar</a><%}%></td>
                  <td><% if(inscricao.isPresente()){%>Presente<%}else{%><a href="?e=<%=evento.getNome().toLowerCase().replace(" ", "_")+"_"+evento.getCodEvento() %>&pi=<%=inscricao.getCodInscricao() %>">Marcar presença</a><%}%></td>
                </tr>
      <%    
         } %>
      </tbody>
      <tfoot>
      <tr>
        <th>Participante</th>
        <th>Data</th>
        <th>Validar</th>
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
