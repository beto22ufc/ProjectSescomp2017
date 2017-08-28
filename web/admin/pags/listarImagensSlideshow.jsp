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
    Facade facade = new Facade();
    EventoBeans e = facade.getEvento(facade.getCodFromParameter(request.getParameter("e")));
    List<ImagemBeans> imagens = e.getSlideshow();
%>
<div class="col-xs-12">
    <div class="box">
  <div class="box-header">
    <h3 class="box-title">Imagens slideshow do evento <%=e.getNome().toUpperCase() %></h3>
    <p><a href="/<%=dir%>/painelUsuario/evento/adicionaImagemSlideshow/?e=<%=e.getNome().toLowerCase().replace(" ", "_")+"_"+e.getCodEvento()%>">Adicionar nova</a></p>
  </div>
  <!-- /.box-header -->
  <div class="box-body">
    <table id="example1" class="table table-bordered table-striped">
      <thead>
      <tr>
        <th>Código</th>
        <th>Arquivo</th>
        <th>Descrição</th>
        <th>Editar/Excluir</th>
      </tr>
      </thead>
      <tbody>
      <%
          for(int i=0;i<imagens.size();i++){
              ImagemBeans imagem = imagens.get(i);
      %>    
                <tr>
                  <td><%=imagem.getCodImagem() %></td>
                  <td><% if(imagem.getArquivo() != null){%>
                      <img src="<%=ImageManipulation.encodeImage(imagem.getArquivo()) %>" style="width: 200px; height: 200px;"/></td>
                  <%}else{out.print("Sem imagem");}%>
                  <td><%=imagem.getDescricao()%></td>
                  <td><a href="#">Editar</a>/<a href="#">Excluir</a></td>
                </tr>
      <%    
         } %>
      </tbody>
      <tfoot>
      <tr>
        <th>Código</th>
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
