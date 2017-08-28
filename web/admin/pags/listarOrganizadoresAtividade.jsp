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
    AtividadeBeans atividade = facade.getAtividade(facade.getCodFromParameter(request.getParameter("a")));
    List<UsuarioBeans> organizadores = atividade.getOrganizadores();
%>
<div class="col-xs-12">
    <div class="box">
  <div class="box-header">
    <h3 class="box-title">Administradores da atividade <%=atividade.getNome().toUpperCase() %></h3>
    <p><a href="/<%=dir%>/painelUsuario/atividade/novoOrganizador/?a=<%=atividade.getNome().toLowerCase().replace(" ", "_")+"_"+atividade.getCodAtividade()%>">Adicionar novo</a></p>
  </div>
  <!-- /.box-header -->
  <div class="box-body">
    <table id="example1" class="table table-bordered table-striped">
      <thead>
      <tr>
        <th>Código</th>
        <th>Nome</th>
        <th>Matricula</th>
        <th>E-mail</th>
        <th>CPF</th>
        <th>Tipo</th>
        <th>Status</th>
        <th>Nascimento</th>
        <th>Lattes</th>
        <th>Cadastro</th>
        <th>Remover</th>
      </tr>
      </thead>
      <tbody>
      <%
          for(int i=0;i<organizadores.size();i++){
              UsuarioBeans usuario = organizadores.get(i);
              //if(evento.getAdministradores().contains(u)){
      %>    
                <tr>
                  <td><%=usuario.getCodUsuario() %></td>
                  <td><%=usuario.getNome()%></td>
                  <td><%=(usuario.getMatricula()!=null) ? usuario.getMatricula().getNumero() : "Sem matrícula" %></td>
                  <td><%=usuario.getEmail()%></td>
                  <td><%=usuario.getCpf().getSecretCpf() %></td>
                  <td><%=usuario.getTipo() %></td>
                  <td><%=(usuario.getStatus() != 1) ? "Inativo" : "Ativo" %></td>
                  <td><%=usuario.getNascimento()%></td>
                  <td><a href="<%=usuario.getLattes() %>">Lattes</a></td>
                  <td><%=usuario.getCadastro()%></td>
                  <td><a href="#">Remover</a></td>
                </tr>
      <%    //}
         } %>
      </tbody>
      <tfoot>
      <tr>
        <th>Código</th>
        <th>Nome</th>
        <th>Matricula</th>
        <th>E-mail</th>
        <th>CPF</th>
        <th>Tipo</th>
        <th>Status</th>
        <th>Nascimento</th>
        <th>Lattes</th>
        <th>Cadastro</th>
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
