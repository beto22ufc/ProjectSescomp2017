<%-- 
    Document   : listarEventos
    Created on : 31/07/2017, 18:44:27
    Author     : Wallison
--%>

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
    if(request.getParameter("ri") != null){
        ImagemBeans imagem = null;
        try{
            try{
                imagem = facade.getImagem(Long.parseLong(request.getParameter("ri")));
            }catch(NumberFormatException ex){
                response.sendRedirect("/"+dir+"/404");
            }catch(NullPointerException ex){
                response.sendRedirect("/"+dir+"/404");            
            }
            facade.removeImagemGaleria(e, imagem);
            e = facade.getEvento(facade.getCodFromParameter(request.getParameter("e")));
            request.setAttribute("msg", "Imagem removida com sucesso!");
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
    List<ImagemBeans> imagens = e.getGaleria();
%>
<div class="col-xs-12">
    <div class="box">
  <div class="box-header">
    <h3 class="box-title">Imagens galeria do evento <%=e.getNome().toUpperCase() %></h3>
    <p><a href="/<%=dir%>/painelUsuario/evento/adicionaImagemGaleria/?e=<%=e.getNome().toLowerCase().replace(" ", "_")+"_"+e.getCodEvento()%>">Adicionar nova</a></p>
    <p><%=(request.getParameter("msg") !=null) ? request.getParameter("msg") : "" %></p>
  </div>
  <!-- /.box-header -->
  <div class="box-body">
    <table id="example1" class="table table-bordered table-striped">
      <thead>
      <tr>
        <th>Arquivo</th>
        <th>Descrição</th>
        <th>Editar/Excluir</th>
      </tr>
      </thead>
      <tbody>
      <%
          for(ImagemBeans imagem : imagens){
      %>    
                <tr>
                  <td><img src="<%=ImageManipulation.encodeImage(imagem.getArquivo()) %>" style="width: 200px; height: 200px;"/></td>
                  <td><%=imagem.getDescricao()%></td>
                  <td><a href="/<%=dir %>/painelUsuario/evento/editarImagem/?e=<%=e.getNome().toLowerCase().replace(" ", "_")+"_"+e.getCodEvento()%>&i=<%=imagem.getCodImagem() %>">Editar</a>/<a href="?e=<%=e.getNome().toLowerCase().replace(" ", "_")+"_"+e.getCodEvento()%>&ri=<%=imagem.getCodImagem() %>">Excluir</a></td>
                </tr>
      <%    
         } %>
      </tbody>
      <tfoot>
      <tr>
        <th>Arquivo</th>
        <th>Descrição</th>
        <th>Editar/Excluir</th>
      </tr>
      </tfoot>
    </table>
  </div>
  <!-- /.box-body -->
</div>
<!-- /.box -->
</div>
<!-- /.col -->
