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
    List<UsuarioBeans> usuarios = facade.getUsuarios();
%>
<div class="col-xs-12">
    <div class="box">
  <div class="box-header">
    <h3 class="box-title">Usuários</h3>
    
  </div>
  <!-- /.box-header -->
  <div class="box-body">
    <table id="example1" class="table table-bordered table-striped">
      <thead>
      <tr>
        <th>Nome</th>
        <th>Matricula</th>
        <th>E-mail</th>
        <th>CPF</th>
        <th>Tipo</th>
        <th>Status</th>
        <th>Nascimento</th>
        <th>Lattes</th>
        <th>Cadastro</th>
      </tr>
      </thead>
      <tbody>
      <%
          for(int i=0;i<usuarios.size();i++){
              UsuarioBeans usuario = usuarios.get(i);
              //if(evento.getAdministradores().contains(u)){
      %>    
                <tr>
                  <td><a href="/<%=dir%>/perfil/?u=<%=usuario.getNome().toLowerCase().replace(" ", "_")+"_"+usuario.getCodUsuario()%>"><%=usuario.getNome()%></a></td>
                  <td><%=(usuario.getMatricula()!=null) ? usuario.getMatricula().getNumero() : "Sem matrícula" %></td>
                  <td><%=usuario.getEmail()%></td>
                  <td><%=usuario.getCpf().getSecretCpf() %></td>
                  <td><%=usuario.getTipo() %></td>
                  <td><%=(usuario.getStatus() != 1) ? "Inativo" : "Ativo" %></td>
                  <td><%=usuario.getNascimento()%></td>
                  <td><a href="<%=usuario.getLattes() %>">Lattes</a></td>
                  <td><%=usuario.getCadastro()%></td>
                </tr>
      <%    //}
         } %>
      </tbody>
      <tfoot>
      <tr>
        <th>Nome</th>
        <th>Matricula</th>
        <th>E-mail</th>
        <th>CPF</th>
        <th>Tipo</th>
        <th>Status</th>
        <th>Nascimento</th>
        <th>Lattes</th>
        <th>Cadastro</th>
      </tr>
      </tfoot>
    </table>
  </div>
  <!-- /.box-body -->
</div>
<!-- /.box -->
</div>
<!-- /.col -->
