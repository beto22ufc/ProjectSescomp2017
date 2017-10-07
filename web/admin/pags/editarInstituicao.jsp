<%@page import="artemis.beans.InstituicaoBeans"%>
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
    Facade facade = new Facade(u);
    InstituicaoBeans instituicao = null;
    try{
        instituicao = facade.getInstituicao(facade.getCodFromParameter(request.getParameter("i")));
    }catch(NumberFormatException e){
        response.sendRedirect("/"+dir+"/404");
    }catch(NullPointerException e){
        response.sendRedirect("/"+dir+"/404");
    }catch(Exception e){
        response.sendRedirect("/"+dir+"/404");
    }
%>
<section class="content-header">
      <h1>
          ATUALIZAR INSTITUI��O
        <small>formul�rio</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="/Artemis/admin/"><i class="fa fa-dashboard"></i> Inicio</a></li>
        <li class="active">Atualizar institui��o</li>
      </ol>
    </section>
    <%

        if(request.getParameter("atualiza") != null){
            try{
                instituicao.setNome(request.getParameter("nome"));
                facade.atualizaInstituicao(instituicao);
                request.setAttribute("msg", "Institui��o atualizada com sucesso!");
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
                <h3 class="box-title"><%=(request.getAttribute("msg") != null) ? request.getAttribute("msg") : "Atualize essa isntitui��o" %></h3>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
            <form action="" method="post">
              <div class="box-body">
                <div class="form-group">
                <label>Nome</label>
                    <input type="text" class="form-control" id="nome" placeholder="Nome da institui��o" name="nome" value="<%=(request.getParameter("nome") != null) ? request.getParameter("nome") : (instituicao != null && instituicao.getNome() != null) ? instituicao.getNome() : ""%>">
                </div>
              <!-- /.form group -->  
              </div>
              <!-- /.box-body -->

              <div class="box-footer">
                <button type="submit" class="btn btn-primary" name="atualiza" value="instituicao">Atualizar institui��o</button>
              </div>
            </form>
          </div>
          <!-- /.box -->
        </div>
      </div>
    </section>