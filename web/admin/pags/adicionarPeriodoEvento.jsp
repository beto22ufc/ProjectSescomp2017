<%@page import="java.time.format.DateTimeParseException"%>
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
    EventoBeans evt = null;
    try{
        evt = facade.getEvento(facade.getCodFromParameter(request.getParameter("e")));
        if(!evt.getAdministradores().contains(u)){
            response.sendRedirect("/"+dir+"/404");
        }
    }catch(NumberFormatException e){
        response.sendRedirect("/"+dir+"/404");
    }catch(NullPointerException e){
        response.sendRedirect("/"+dir+"/404");            
    }
%>
<section class="content-header">
      <h1>
          ADICIONAR PERÍODO(S) PARA O EVENTO <b><%=evt.getNome().toUpperCase() %></b>
        <small>formulário</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="/Artemis/admin/"><i class="fa fa-dashboard"></i> Inicio</a></li>
        <li class="active">Cadastrar período(s)</li>
      </ol>
    </section>
    <%

        if(request.getParameter("cadastro") != null){
            try{
                String[] inicioDatas = request.getParameterValues("dataInicio[]"),
                inicioTempos = request.getParameterValues("tempoInicio[]"),
                terminoDatas = request.getParameterValues("dataTermino[]"),
                terminoTempos = request.getParameterValues("tempoTermino[]");
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
                for(int i=0;i<inicioTempos.length;i++){
                    if(inicioDatas[i] != null && inicioTempos[i] != null && terminoDatas[i] != null && terminoTempos[i] != null)
                        evt.getPeriodos().add(new PeriodoBeans(LocalDateTime.parse(inicioDatas[i].replace(" ", "")+" "+inicioTempos[i].replace(" ", ""), formatter), LocalDateTime.parse(terminoDatas[i].replace(" ", "")+" "+terminoTempos[i].replace(" ", ""), formatter)));
                }
                facade.atualizaEvento(evt);
                request.setAttribute("msg", "Períodos adicionados com sucesso!");
            }catch(IllegalAccessException e){
                request.setAttribute("msg", e.getMessage());
            }catch(NumberFormatException e){
                request.setAttribute("msg", e.getMessage());
            }catch(IllegalArgumentException e){
                request.setAttribute("msg", e.getMessage());
            }catch(NullPointerException e){
                request.setAttribute("msg", e.getMessage());
            }catch(DateTimeParseException e){
                request.setAttribute("msg","Formato de data inválido");
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
                <h3 class="box-title"><%=(request.getAttribute("msg") != null) ? request.getAttribute("msg") : "Registre novo(s) período(s)" %></h3>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
            <form action="" method="post">
              <div class="box-body">
                <div class="form-group periodos">
                    <label>Periodos: </label>

                  <div class="form-group">
                    <label for="dataInicio">Inicio</label>
                    <input type="text" class="form-control" id="dataInicio" placeholder="Data incio" name="dataInicio[]" maxlength="10" onkeypress="formatar('##/##/####',this)">
                    <br />
                    <input type="text" class="form-control" id="dataInicio" placeholder="Tempo inicio" name="tempoInicio[]" maxlength="5" onkeypress="formatar('##:##',this)">
                  </div>
                  <div class="form-group">
                    <label for="dataInicio">Termino</label>
                    <input type="text" class="form-control" id="dataInicio" placeholder="Data incio" name="dataTermino[]" maxlength="10" onkeypress="formatar('##/##/####',this)">
                    <br />
                    <input type="text" class="form-control" id="dataInicio" placeholder="Tempo inicio" name="tempoTermino[]" maxlength="5" onkeypress="formatar('##:##',this)">
                  </div>
                  <!-- /.input group -->
                </div>
              <!-- /.form group -->  
              </div>
              <!-- /.box-body -->

              <div class="box-footer">
                <button type="submit" class="btn btn-primary" name="cadastro" value="periodos">Adicionar período(s)</button>
              </div>
            </form>
          </div>
          <!-- /.box -->
        </div>
      </div>
    </section>