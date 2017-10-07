<%-- 
    Document   : listarEventos
    Created on : 31/07/2017, 18:44:27
    Author     : Wallison
--%>

<%@page import="artemis.beans.InstituicaoBeans"%>
<%@page import="java.util.List"%>
<%@page import="artemis.beans.EventoBeans"%>
<%@page import="artemis.model.Facade"%>
<%@page import="artemis.beans.UsuarioBeans"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String dir = config.getServletContext().getInitParameter("dir");
    UsuarioBeans u = ((UsuarioBeans) session.getAttribute("usuario"));
    Facade facade = new Facade();
    if(request.getParameter("ri") != null){
        InstituicaoBeans ins = null;
        try{
            try{
                ins = facade.getInstituicao(Long.parseLong(request.getParameter("ri")));
            }catch(NumberFormatException e){
                response.sendRedirect("/"+dir+"/404");
            }catch(NullPointerException e){
                response.sendRedirect("/"+dir+"/404");            
            }
            facade.removeInstituicao(ins);
            request.setAttribute("msg", "Instituição removida com sucesso!");
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
    List<InstituicaoBeans> instituicoes = facade.getInstituicoes();
%>
<div class="col-xs-12">
    <div class="box">
  <div class="box-header">
    <h3 class="box-title">Instituições cadastradas</h3>
    <p><%=(request.getAttribute("msg") !=null) ? request.getAttribute("msg") : "" %></p>
  </div>
  <!-- /.box-header -->
  <div class="box-body">
    <table id="example1" class="table table-bordered table-striped">
      <thead>
      <tr>
        <th>Nome</th>
        <th>Cursos</th>
        <th>Associados</th>
        <th>Eventos</th>
        <th>Atividades</th>
        <th>Editar/Remover</th>
      </tr>
      </thead>
      <tbody>
      <%
          for(InstituicaoBeans instituicao : instituicoes){
      %>    
                <tr>
                  <td><%=instituicao.getNome()%></td>
                  <td><a href="/<%=dir%>/painelUsuario/instituicao/cursos/?i=<%=instituicao.getNome().toLowerCase().replace(" ", "_")+"_"+instituicao.getCodInstituicao() %>">Cursos</a></td>
                  <td><a href="/<%=dir%>/painelUsuario/instituicao/associados/?i=<%=instituicao.getNome().toLowerCase().replace(" ", "_")+"_"+instituicao.getCodInstituicao() %>">Associados</a></td>
                  <td><a href="/<%=dir%>/painelUsuario/instituicao/eventos/?i=<%=instituicao.getNome().toLowerCase().replace(" ", "_")+"_"+instituicao.getCodInstituicao() %>">Eventos</a></td>
                  <td><a href="/<%=dir%>/painelUsuario/instituicao/atividades/?i=<%=instituicao.getNome().toLowerCase().replace(" ", "_")+"_"+instituicao.getCodInstituicao() %>">Atividades</a></td>
                  <td><a href="/<%=dir%>/painelUsuario/instituicao/editar/?i=<%=instituicao.getNome().toLowerCase().replace(" ", "_")+"_"+instituicao.getCodInstituicao() %>"">Editar</a>/<a href="?ri=<%=instituicao.getCodInstituicao() %>">Remover</a></td>
                </tr>
      <%    
         } %>
      </tbody>
      <tfoot>
      <tr>
        <th>Nome</th>
        <th>Cursos</th>
        <th>Associados</th>
        <th>Eventos</th>
        <th>Atividades</th>
        <th>Editar/Remover</th>
      </tr>
      </tfoot>
    </table>
  </div>
  <!-- /.box-body -->
</div>
<!-- /.box -->
</div>
<!-- /.col -->
