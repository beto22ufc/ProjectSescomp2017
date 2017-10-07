<%@page import="java.time.format.DateTimeParseException"%>
<%@page import="artemis.beans.AtividadeBeans"%>
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
    DateTimeFormatter dtfd = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    DateTimeFormatter dtfh = DateTimeFormatter.ofPattern("HH:mm");
    Facade facade = new Facade(u);
    AtividadeBeans atividade = null;
    PeriodoBeans periodo = null;
    try{
        atividade = facade.getAtividade(facade.getCodFromParameter(request.getParameter("a")));
        if(atividade.getAdministradores().contains(u)){
            response.sendRedirect("/"+dir+"/404");
        }
        periodo = facade.getPeriodo(Long.parseLong(request.getParameter("p")));
    }catch(NumberFormatException e){
        response.sendRedirect("/"+dir+"/404");
    }catch(NullPointerException e){
        response.sendRedirect("/"+dir+"/404");            
    }
%>
<section class="content-header">
      <h1>
          ATUALIZAR PERÍODO DA ATIVIDADE <b><%=atividade.getNome().toUpperCase() %></b>
        <small>formulário</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="/Artemis/admin/"><i class="fa fa-dashboard"></i> Inicio</a></li>
        <li class="active">Atualizar período</li>
      </ol>
    </section>
    <%

        if(request.getParameter("atualiza") != null){
            try{
                String inicioDatas = request.getParameter("dataInicio"),
                inicioTempos = request.getParameter("tempoInicio"),
                terminoDatas = request.getParameter("dataTermino"),
                terminoTempos = request.getParameter("tempoTermino");
                atividade.getPeriodoBeanses().remove(periodo);
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
                periodo.setInicio(LocalDateTime.parse(inicioDatas+" "+inicioTempos, formatter));
                periodo.setTermino(LocalDateTime.parse(terminoDatas+" "+terminoTempos, formatter));
                atividade.getPeriodoBeanses().add(periodo);
                facade.atualizaAtividade(atividade);
                request.setAttribute("msg", "Período atualizado com sucesso!");
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
                <h3 class="box-title"><%=(request.getAttribute("msg") != null) ? request.getAttribute("msg") : "Edite o período" %></h3>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
            <form action="" method="post">
              <div class="box-body">
                <div class="form-group periodos">
                    <label>Periodo: </label>
                  <div class="form-group">
                    <label for="dataInicio">Inicio</label>
                    <input type="text" class="form-control" id="dataInicio" placeholder="Data incio" name="dataInicio" maxlength="10" onkeypress="formatar('##/##/####',this)" value="<%=(request.getParameter("dataInicio") != null) ? request.getParameter("dataInicio") : periodo.getInicio().format(dtfd) %>">
                    <br />
                    <input type="text" class="form-control" id="dataInicio" placeholder="Tempo inicio" name="tempoInicio" maxlength="5" onkeypress="formatar('##:##',this)" value="<%=(request.getParameter("tempoInicio") != null) ? request.getParameter("tempoInicio") : periodo.getInicio().format(dtfh) %>">
                  </div>
                  <div class="form-group">
                    <label for="dataInicio">Termino</label>
                    <input type="text" class="form-control" id="dataInicio" placeholder="Data incio" name="dataTermino" maxlength="10" onkeypress="formatar('##/##/####',this)" value="<%=(request.getParameter("dataTermino") != null) ? request.getParameter("dataTermino") : periodo.getTermino().format(dtfd) %>">
                    <br />
                    <input type="text" class="form-control" id="dataInicio" placeholder="Tempo inicio" name="tempoTermino" maxlength="5" onkeypress="formatar('##:##',this)" value="<%=(request.getParameter("tempoTermino") != null) ? request.getParameter("tempoTermino") : periodo.getTermino().format(dtfh) %>">
                  </div>
                  <!-- /.input group -->
                </div>
              <!-- /.form group -->  
              </div>
              <!-- /.box-body -->

              <div class="box-footer">
                <button type="submit" class="btn btn-primary" name="atualiza" value="periodos">Atualizar período</button>
              </div>
            </form>
          </div>
          <!-- /.box -->
        </div>
      </div>
    </section>