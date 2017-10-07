<%-- 
    Document   : listarEventos
    Created on : 31/07/2017, 18:44:27
    Author     : Wallison
--%>

<%@page import="artemis.beans.InstituicaoBeans"%>
<%@page import="artemis.beans.CursoBeans"%>
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
    InstituicaoBeans instituicao = null;
    try{
        instituicao = facade.getInstituicao(facade.getCodFromParameter(request.getParameter("i")));
    }catch(NumberFormatException e){
        response.sendRedirect("/"+dir+"/404");
    }catch(NullPointerException e){
        response.sendRedirect("/"+dir+"/404");            
    }
    if(request.getParameter("rc") != null){
        CursoBeans c = null;
        try{
            try{
                c = facade.getCurso(Long.parseLong(request.getParameter("rc")));
            }catch(NumberFormatException e){
                response.sendRedirect("/"+dir+"/404");
            }catch(NullPointerException e){
                response.sendRedirect("/"+dir+"/404");            
            }
            facade.removeCurso(instituicao, c);
            request.setAttribute("msg", "Curso removido com sucesso!");
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
    List<CursoBeans> cursos = instituicao.getCursos();
%>
<div class="col-xs-12">
    <div class="box">
  <div class="box-header">
    <h3 class="box-title">Cursos da instituição <%=instituicao.getNome().toUpperCase() %></h3>
    <p><a href="/<%=dir%>/painelUsuario/instituicao/novoCurso/?i=<%=instituicao.getNome().toLowerCase().replace(" ", "_")+"_"+instituicao.getCodInstituicao()%>">Adicionar novo</a></p>
    <p><%=(request.getAttribute("msg") !=null) ? request.getAttribute("msg") : "" %></p>
  </div>
  <!-- /.box-header -->
  <div class="box-body">
    <table id="example1" class="table table-bordered table-striped">
      <thead>
      <tr>
        <th>Nome</th>
        <th>Descrição</th>
        <th>Duração</th>
        <th>Editar/Remover</th>
      </tr>
      </thead>
      <tbody>
      <%
          for(CursoBeans curso : cursos){
              //if(evento.getAdministradores().contains(u)){
      %>    
                <tr>
                  <td><%=curso.getNome()%></td>
                  <td><%=curso.getDescricao()%></td>
                  <td><%=curso.getDuracao() %></td>
                  <td><a href="/<%=dir %>/painelUsuario/instituicao/curso/editar/?i=<%=instituicao.getNome().toLowerCase().replace(" ", "_")+"_"+instituicao.getCodInstituicao()%>&c=<%=curso.getCodCurso() %>">Editar</a>/<a href="?i=<%=instituicao.getNome().toLowerCase().replace(" ", "_")+"_"+instituicao.getCodInstituicao()%>&rc=<%=curso.getCodCurso() %>">Remover</a></td>
                </tr>
      <%    //}
         } %>
      </tbody>
      <tfoot>
      <tr>
        <th>Nome</th>
        <th>Descrição</th>
        <th>Duração</th>
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
