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
    List<EventoBeans> eventos = facade.getEventos();
    List<EventoBeans> vinculados = evt.getEventos();
%>
<section class="content-header">
      <h1>
          VINCULAR EVENTO AO EVENTO <b><%=evt.getNome().toUpperCase() %></b>
        <small>formulário</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="/Artemis/admin/"><i class="fa fa-dashboard"></i> Inicio</a></li>
        <li class="active">Vincular novo evento</li>
      </ol>
    </section>
    <%

        if(request.getParameter("vincular") != null){
            try{
                EventoBeans event = facade.getEvento(Long.parseLong(request.getParameter("evento")));
                evt.getEventos().add(event);
                facade.atualizaEvento(evt);
                request.setAttribute("msg", "Evento vinculado com sucesso!");
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
                <h3 class="box-title"><%=(request.getAttribute("msg") != null) ? request.getAttribute("msg") : "Vincule um novo evento" %></h3>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
            <form action="" method="post">
              <div class="box-body">
                <div class="form-group">
                <label>Evento</label>
                    <select class="form-control select2" style="width: 100%;" name="evento">
                        <option value="0">Selecione um evento</option>
                        <%
                            for(int i=0;i<eventos.size();i++){
                                EventoBeans e = eventos.get(i);
                                boolean vinculado = false;
                                if(e.getAdministradores().contains(u)){
                                    for(int j=0;j<vinculados.size();j++){
                                        EventoBeans  ev = vinculados.get(j);
                                        if(e.getCodEvento() == ev.getCodEvento()){
                                            vinculado = true;
                                            break;
                                        }
                                    }
                                    if(!vinculado && (e.getCodEvento()!= evt.getCodEvento())){
                        %>
                                    <option  value="<%=e.getCodEvento()%>"><%=e.getCodEvento()+" - "+e.getNome()%></option>
                        <%          }
                                }
                            }
                        %>
                    </select>
                </div>
              <!-- /.form group -->  
              </div>
              <!-- /.box-body -->

              <div class="box-footer">
                <button type="submit" class="btn btn-primary" name="vincular" value="evento">Vincular</button>
              </div>
            </form>
          </div>
          <!-- /.box -->
        </div>
      </div>
    </section>