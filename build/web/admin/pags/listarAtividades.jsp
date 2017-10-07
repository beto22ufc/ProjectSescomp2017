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
    if(request.getParameter("ra") !=null){
        
        try{
            AtividadeBeans atv = null;
            EventoBeans event = null;
            try{
                atv = facade.getAtividade(Long.parseLong(request.getParameter("ra")));
                event = facade.getEventoVinculado(atv);
            }catch(NumberFormatException e){
                response.sendRedirect("/"+dir+"/404");
            }catch(NullPointerException e){
                response.sendRedirect("/"+dir+"/404");
            }catch(Exception e){
                response.sendRedirect("/"+dir+"/404");
            }
            facade.removeAtividade(event, atv);
            request.setAttribute("msg", "Atividade removida com sucesso! Foi comunicado a todos inscritos a sua atividade!");
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
    List<AtividadeBeans> atividades = facade.getAtividades();
%>
<div class="col-xs-12">
    <div class="box">
  <div class="box-header">
    <h3 class="box-title">Minhas atividades</h3>
    <p><%=(request.getParameter("msg") !=null) ? request.getParameter("msg") : "" %></p>
    </div>
  <!-- /.box-header -->
  <div class="box-body">
    <table id="example1" class="table table-bordered table-striped">
      <thead>
      <tr>
        <th>Nome</th>
        <th>Ministrante</th>
        <th>Vagas</th>
        <th>Pagamento</th>
        <th>Inscrições</th>
        <th>Administradores</th>
        <th>Organizadores</th>
        <th>Períodos</th>
        <!--<th>Lista de espera</th>-->
        <th>Editar/Remover</th>
      </tr>
      </thead>
      <tbody>
      <%
          for(AtividadeBeans atividade : atividades){
              if(atividade.getAdministradores().contains(u)){
      %>    
                <tr>
                  <td><a href="/<%=dir%>/atividade/?a=<%=atividade.getNome().toLowerCase().replace(" ", "_")+"_"+atividade.getCodAtividade()%>"><%=atividade.getNome()%></a>
                  </td>
                  <td><%
                        if(atividade.getMinistrante() != null){
                          out.println(atividade.getMinistrante().getNome());
                        }else{
                        %>
                        <a href="/<%=dir%>/painelUsuario/atividade/adicionarMinistrante/?a=<%=atividade.getNome().toLowerCase().replace(" ", "_")+"_"+atividade.getCodAtividade()%>">Adicionar ministrante</a>
                      <%      
                        }
                  %></td>
                  <td><%=atividade.getLimiteVagas() %></td>
                  <td><%
                        if(atividade.getTipoPagamento()==1){
                            out.println("Nenhum");
                        }else if(atividade.getNivel()==2){
                            out.println("Dinheiro");
                        }else if(atividade.getNivel()==3){
                            out.println("Alimento não perecível");
                        }else{
                            out.println("Pagamento inválido!");
                        }
                      %></td>
                  <td><a href="/<%=dir%>/painelUsuario/atividade/inscricoes/?a=<%=atividade.getNome().toLowerCase().replace(" ", "_")+"_"+atividade.getCodAtividade() %>">Inscrições</a></td>
                  <td><a href="/<%=dir%>/painelUsuario/atividade/administradores/?a=<%=atividade.getNome().toLowerCase().replace(" ", "_")+"_"+atividade.getCodAtividade() %>">Administradores</a></td>
                  <td><a href="/<%=dir%>/painelUsuario/atividade/organizadores/?a=<%=atividade.getNome().toLowerCase().replace(" ", "_")+"_"+atividade.getCodAtividade() %>">Organizadores</a></td>
                  <td><a href="/<%=dir%>/painelUsuario/atividade/periodos/?a=<%=atividade.getNome().toLowerCase().replace(" ", "_")+"_"+atividade.getCodAtividade() %>">Períodos</a></td>
                  <!--<td><a href="#">Lista de espera</a></td>-->
                  <td><a href="/<%=dir%>/painelUsuario/atividade/editar/?a=<%=atividade.getNome().toLowerCase().replace(" ", "_")+"_"+atividade.getCodAtividade() %>">Editar</a>/<a href="#">Remover</a></td>
                </tr>
      <%    }
         } %>
      </tbody>
      <tfoot>
      <tr>
        <th>Nome</th>
        <th>Ministrante</th>
        <th>Vagas</th>
        <th>Pagamento</th>
        <th>Inscrições</th>
        <th>Administradores</th>
        <th>Organizadores</th>
        <th>Períodos</th>
        <!--<th>Lista de espera</th>-->
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
