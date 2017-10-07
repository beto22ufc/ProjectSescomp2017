<%-- 
    Document   : listarEventos
    Created on : 31/07/2017, 18:44:27
    Author     : Wallison
--%>

<%@page import="java.io.File"%>
<%@page import="artemis.model.Constantes"%>
<%@page import="artemis.model.FileManipulation"%>
<%@page import="artemis.beans.TemaBeans"%>
<%@page import="artemis.model.ImageManipulation"%>
<%@page import="artemis.beans.ImagemBeans"%>
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
    }
    if(request.getParameter("tema") != null){
        String theme = request.getParameter("tema");
        try{
            if(facade.getTemas().contains(theme)){
                e.setTema(theme);
                facade.atualizaEvento(e);
                request.setAttribute("msg", "Tema atualizado com sucesso!");
            }else{
               request.setAttribute("msg", "Tema inválido!");    
            }            
        }catch(NumberFormatException ex){
            request.setAttribute("msg", "Isso não é um número!");
        }catch(NullPointerException ex){
            request.setAttribute("msg", ex.getMessage());            
        }catch(IllegalArgumentException ex){
            request.setAttribute("msg", ex.getMessage());            
        }catch(Exception ex){
            request.setAttribute("msg", ex.getMessage());            
        }
    }
    List<String> temas = facade.getTemas();
%>
<div class="col-xs-12">
    <div class="box">
  <div class="box-header">
    <h3 class="box-title">Temas para eventos</h3>
    <p><%=(request.getParameter("msg") !=null) ? request.getParameter("msg") : "" %></p>
  </div>
  <!-- /.box-header -->
  <div class="box-body">
    <table id="example1" class="table table-bordered table-striped">
      <thead>
      <tr>
        <th>Código</th>
        <th>Nome</th>
        <th>Screenshot</th>
        <th>Versão</th>
        <th>Selecionar</th>
      </tr>
      </thead>
      <tbody>
      <%
          for(String t : temas){
              TemaBeans tema = facade.getTema(t);
              File banner = FileManipulation.getFileStream(FileManipulation.getStreamFromURL(Constantes.URL+"/theme/evento/"+tema.getNome()+"/banner.jpg"), "jpg");
      %>    
                <tr>
                  <td><%=tema.getCodTema()%></td>
                  <td><%=tema.getNome() %></td>
                  <td><img src="<%=ImageManipulation.encodeImage(banner) %>" style="width: 200px; height: 200px;"/></td>
                  <td><%=tema.getVersao() %></td>
                  <td><% if(tema.getNome().equals(e.getTema())){out.println("Selecionado");}else{%><a href="?e=<%=e.getNome().toLowerCase().replace(" ", "_")+"_"+e.getCodEvento()%>&tema=<%=tema.getNome()%>">Selecionar</a><%}%></td>
                </tr>
      <%    
         } %>
      </tbody>
      <tfoot>
      <tr>
        <th>Código</th>
        <th>Nome</th>
        <th>Screenshot</th>
        <th>Versão</th>
        <th>Secção</th>
        <th>Selecionar</th>
      </tr>
      </tfoot>
    </table>
  </div>
  <!-- /.box-body -->
</div>
<!-- /.box -->
</div>
<!-- /.col -->
