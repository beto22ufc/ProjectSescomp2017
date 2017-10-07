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
    if(request.getParameter("rev") != null){
        EventoBeans vinculado = null;
        try{
            try{
                vinculado = facade.getEvento(Long.parseLong(request.getParameter("rev")));
            }catch(NumberFormatException ex){
                response.sendRedirect("/"+dir+"/404");
            }catch(NullPointerException ex){
                response.sendRedirect("/"+dir+"/404");            
            }
            for(int i=0;i<e.getEventos().size();i++){
                EventoBeans evt = e.getEventos().get(i);
                if(evt.getCodEvento() == vinculado.getCodEvento()){
                    e.getEventos().remove(i);
                }
            }
            facade.atualizaEvento(e);
            e = facade.getEvento(facade.getCodFromParameter(request.getParameter("e")));
            request.setAttribute("msg", "Evento desvinculado com sucesso!");
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
    if(request.getParameter("re") !=null){
        
        try{
            EventoBeans event = null;
            try{
                event = facade.getEvento(Long.parseLong(request.getParameter("re")));
            }catch(NumberFormatException ex){
                response.sendRedirect("/"+dir+"/404");
            }catch(NullPointerException ex){
                response.sendRedirect("/"+dir+"/404");
            }catch(Exception ex){
                response.sendRedirect("/"+dir+"/404");
            }
            facade.removeEvento(event);
            request.setAttribute("msg", "Evento removido com sucesso! Foi comunicado a todos inscritos no evento e em suas atividades!");
        }catch(NullPointerException ex){
            request.setAttribute("msg", ex.getMessage());
        }catch(NumberFormatException ex){
            request.setAttribute("msg", "Isso não é um número!");
        }catch(IllegalArgumentException ex){
            request.setAttribute("msg", ex.getMessage());
        }catch(IllegalAccessException ex){
            request.setAttribute("msg", ex.getMessage());
        }catch(Exception ex){
            request.setAttribute("msg", ex.getMessage());
        }
        
    }
    List<EventoBeans> eventos = e.getEventos();
    
%>
<div class="col-xs-12">
    <div class="box">
  <div class="box-header">
    <h3 class="box-title">Eventos vinculados ao evento <%=e.getNome().toUpperCase() %></h3>
    <p><a href="/<%=dir%>/painelUsuario/evento/vincularEvento/?e=<%=e.getNome().toLowerCase().replace(" ", "_")+"_"+e.getCodEvento()%>">Vincular novo</a></p>
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
        <th>Desvincular</th>
        <th>Editar/Excluir</th>
      </tr>
      </thead>
      <tbody>
      <%
          for(EventoBeans evento : e.getEventos()){
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
                  <td><a href="?e=<%=evento.getNome().toLowerCase().replace(" ", "_")+"_"+evento.getCodEvento() %>&?rev=<%=evento.getCodEvento() %>">Desvincular</a></td>
                  <td><a href="/<%=dir%>/painelUsuario/editarEvento/?e=<%=evento.getNome().toLowerCase().replace(" ", "_")+"_"+evento.getCodEvento() %>">Editar</a>/<a href="?e=<%=evento.getNome().toLowerCase().replace(" ", "_")+"_"+evento.getCodEvento() %>&re=<%=evento.getCodEvento() %>">Remover</a></td>
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
        <th>Desvincular</th>
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
