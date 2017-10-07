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
    if(request.getParameter("ua") != null){
        UsuarioBeans administador = null;
        try{
            try{
                administador = facade.getUsuario(Long.parseLong(request.getParameter("ua")));
            }catch(NumberFormatException e){
                response.sendRedirect("/"+dir+"/404");
            }catch(NullPointerException e){
                response.sendRedirect("/"+dir+"/404");            
            }
            atividade.getAdministradores().remove(administador);
            facade.atualizaAtividade(atividade);
            request.setAttribute("msg", "Adminstrador removido com sucesso!");
        }catch(NumberFormatException e){
            request.setAttribute("msg", "Isso não é um número!");
        }catch(NullPointerException e){
            request.setAttribute("msg", e.getMessage());            
        }catch(IllegalArgumentException e){
            request.setAttribute("msg", e.getMessage());            
        }catch(Exception e){
            request.setAttribute("msg", e.getMessage());            
        }
    }
    List<UsuarioBeans> administradores = atividade.getAdministradores();
%>
<div class="col-xs-12">
    <div class="box">
  <div class="box-header">
    <h3 class="box-title">Administradores da atividade <%=atividade.getNome().toUpperCase() %></h3>
    <p><a href="/<%=dir%>/painelUsuario/atividade/novoAdministrador/?a=<%=atividade.getNome().toLowerCase().replace(" ", "_")+"_"+atividade.getCodAtividade()%>">Adicionar novo</a></p>
    <p><%=(request.getAttribute("msg") !=null) ? request.getAttribute("msg") : "" %></p>
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
        <th>Remover</th>
      </tr>
      </thead>
      <tbody>
      <%
          for(int i=0;i<administradores.size();i++){
              UsuarioBeans usuario = administradores.get(i);
              //if(evento.getAdministradores().contains(u)){
      %>    
                <tr>
                  <td><%=usuario.getNome()%></td>
                  <td><%=(usuario.getMatricula()!=null) ? usuario.getMatricula().getNumero() : "Sem matrícula" %></td>
                  <td><%=usuario.getEmail()%></td>
                  <td><%=usuario.getCpf().getSecretCpf() %></td>
                  <td><%=usuario.getTipo() %></td>
                  <td><%=(usuario.getStatus() != 1) ? "Inativo" : "Ativo" %></td>
                  <td><%=usuario.getNascimento()%></td>
                  <td><a href="<%=usuario.getLattes() %>">Lattes</a></td>
                  <td><%=usuario.getCadastro()%></td>
                  <td><a href="?a=<%=atividade.getNome().toLowerCase().replace(" ", "_")+"_"+atividade.getCodAtividade()%>&ua=<%=usuario.getCodUsuario()%>">Remover</a></td>
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
