<%-- 
    Document   : listarEventos
    Created on : 31/07/2017, 18:44:27
    Author     : Wallison
--%>

<%@page import="java.util.List"%>
<%@page import="artemis.beans.EventoBeans"%>
<%@page import="artemis.model.Facade"%>
<%@page import="artemis.beans.UsuarioBeans"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String dir = config.getServletContext().getInitParameter("dir");
    UsuarioBeans u = ((UsuarioBeans) session.getAttribute("usuario"));
    Facade facade = new Facade(u);
    if(request.getParameter("re") !=null){
        
        try{
            EventoBeans event = null;
            try{
                event = facade.getEvento(Long.parseLong(request.getParameter("re")));
            }catch(NumberFormatException e){
                response.sendRedirect("/"+dir+"/404");
            }catch(NullPointerException e){
                response.sendRedirect("/"+dir+"/404");
            }catch(Exception e){
                response.sendRedirect("/"+dir+"/404");
            }
            facade.removeEvento(event);
            request.setAttribute("msg", "Evento removido com sucesso! Foi comunicado a todos inscritos no evento e em suas atividades!");
        }catch(NullPointerException e){
            request.setAttribute("msg", e.getMessage());
        }catch(NumberFormatException e){
            request.setAttribute("msg", "Isso não é um número!");
        }catch(IllegalArgumentException e){
            request.setAttribute("msg", e.getMessage());
        }catch(IllegalAccessException e){
            request.setAttribute("msg", e.getMessage());
        }catch(Exception e){
            request.setAttribute("msg", e.getMessage());
        }
        
    }
    List<EventoBeans> eventos = facade.getEventos();
%>
<div class="col-xs-12">
    <div class="box">
  <div class="box-header">
    <h3 class="box-title">Meus eventos</h3>
    <p><%=(request.getParameter("msg") !=null) ? request.getParameter("msg") : "" %></p>
  </div>
  <!-- /.box-header -->
  <div class="box-body">
    <table id="example1" class="table table-bordered table-striped">
      <thead>
      <tr>
        <th>Nome</th>
        <th>Categoria</th>
        <th>Galeria</th>
        <th>Slideshow</th>
        <th>Eventos</th>
        <th>Atividades</th>
        <th>Inscrições</th>
        <th>Periodos</th>
        <th>Administradores</th>
        <th>Organizadores</th>
        <th>Editar/Remover</th>
      </tr>
      </thead>
      <tbody>
      <%
          for(int i=0;i<eventos.size();i++){
              EventoBeans evento = eventos.get(i);
              if(evento.getAdministradores().contains(u)){
      %>    
                <tr>
                  <td><a href="/<%=dir%>/evento/?e=<%=evento.getNome().toLowerCase().replace(" ", "_")+"_"+evento.getCodEvento() %>"><%=evento.getNome()%></a>
                  </td>
                  <td><%=evento.getCategoria()%></td>
                  <td><a href="/<%=dir%>/painelUsuario/evento/galeria/?e=<%=evento.getNome().toLowerCase().replace(" ", "_")+"_"+evento.getCodEvento() %>">Galeria</a></td>
                  <td><a href="/<%=dir%>/painelUsuario/evento/slideshow/?e=<%=evento.getNome().toLowerCase().replace(" ", "_")+"_"+evento.getCodEvento() %>">Slideshow</a></td>
                  <td><a href="/<%=dir%>/painelUsuario/evento/eventos/?e=<%=evento.getNome().toLowerCase().replace(" ", "_")+"_"+evento.getCodEvento() %>">Eventos</a></td>
                  <td><a href="/<%=dir%>/painelUsuario/evento/atividades/?e=<%=evento.getNome().toLowerCase().replace(" ", "_")+"_"+evento.getCodEvento() %>">Atividades</a></td>
                  <td><a href="/<%=dir%>/painelUsuario/evento/inscricoes/?e=<%=evento.getNome().toLowerCase().replace(" ", "_")+"_"+evento.getCodEvento() %>">Inscrições</a></td>
                  <td><a href="/<%=dir%>/painelUsuario/evento/periodos/?e=<%=evento.getNome().toLowerCase().replace(" ", "_")+"_"+evento.getCodEvento() %>">Períodos</a></td>
                  <td><a href="/<%=dir%>/painelUsuario/evento/administradores/?e=<%=evento.getNome().toLowerCase().replace(" ", "_")+"_"+evento.getCodEvento() %>">Administradores</a></td>
                  <td><a href="/<%=dir%>/painelUsuario/evento/organizadores/?e=<%=evento.getNome().toLowerCase().replace(" ", "_")+"_"+evento.getCodEvento() %>">Organizadores</a></td>
                  <td><a href="/<%=dir%>/painelUsuario/editarEvento/?e=<%=evento.getNome().toLowerCase().replace(" ", "_")+"_"+evento.getCodEvento() %>">Editar</a>/<a href="?re=<%=evento.getCodEvento() %>">Remover</a></td>
                </tr>
      <%    }
         } %>
      </tbody>
      <tfoot>
      <tr>
        <th>Nome</th>
        <th>Categoria</th>
        <th>Galeria</th>
        <th>Slideshow</th>
        <th>Eventos</th>
        <th>Atividades</th>
        <th>Inscrições</th>
        <th>Periodos</th>
        <th>Administradores</th>
        <th>Organizadores</th>
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
