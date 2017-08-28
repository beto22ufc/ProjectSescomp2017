<%@page import="artemis.beans.LocalizacaoBeans"%>
<%@page import="artemis.beans.UsuarioBeans"%>
<%@page import="artemis.model.Facade"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="artemis.beans.PeriodoBeans"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="artemis.beans.EventoBeans"%>
<%
    String dir = config.getServletContext().getInitParameter("dir");
    UsuarioBeans u = ((UsuarioBeans) session.getAttribute("usuario"));
    Facade facade = new Facade(u);
    EventoBeans evt = facade.getEvento(facade.getCodFromParameter(request.getParameter("e")));
    List<UsuarioBeans> usuarios = facade.getUsuarios();
    List<UsuarioBeans> organizadores = evt.getOrganizadores();
%>
<section class="content-header">
      <h1>
          ADICIONAR ORGANIZADOR PARA O EVENTO <b><%=evt.getNome().toUpperCase() %></b>
        <small>formulário</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="/Artemis/admin/"><i class="fa fa-dashboard"></i> Inicio</a></li>
        <li class="active">Cadastrar organizador</li>
      </ol>
    </section>
    <%

        if(request.getParameter("cadastro") != null){
            try{
                UsuarioBeans usuario = facade.getUsuario(Long.parseLong(request.getParameter("organizador")));
                evt.getOrganizadores().add(usuario);
                facade.atualizaEvento(evt);
                facade.adicionaNivelUsuario(usuario, "adminEvento");
                request.setAttribute("msg", "Organizador adicionado com sucesso!");
            }catch(IllegalAccessException e){
                request.setAttribute("msg", e.getMessage());
            }catch(NumberFormatException e){
                request.setAttribute("msg", e.getMessage());
            }catch(IllegalArgumentException e){
                request.setAttribute("msg", e.getMessage());
            }catch(NullPointerException e){
                request.setAttribute("msg", e.getMessage());
            }
        }
    %>
    <!-- Main content -->
    <section class="content">
      <div class="row">
        <!-- left column -->
        <div class="col-md-6">
          <!-- general form elements -->
          <div class="box box-primary">
            <div class="box-header with-border">
                <h3 class="box-title"><%=(request.getAttribute("msg") != null) ? request.getAttribute("msg") : "Registre um novo organizador" %></h3>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
            <form action="" method="post">
              <div class="box-body">
                <div class="form-group">
                <label>Organizador</label>
                    <select class="form-control select2" style="width: 100%;" name="organizador">
                        <option value="0">Selecione um administrador</option>
                        <%
                            for(int i=0;i<usuarios.size();i++){
                                UsuarioBeans user = usuarios.get(i);
                                if(!organizadores.contains(user)){
                        %>
                        <option  value="<%=user.getCodUsuario() %>"><%=user.getNome()+" - "+user.getCpf().getSecretCpf() %></option>
                        <%      }
                            }
                        %>
                    </select>
                </div>
              <!-- /.form group -->  
              </div>
              <!-- /.box-body -->

              <div class="box-footer">
                <button type="submit" class="btn btn-primary" name="cadastro" value="organizador">Adicionar organizador</button>
              </div>
            </form>
          </div>
          <!-- /.box -->
        </div>
      </div>
    </section>