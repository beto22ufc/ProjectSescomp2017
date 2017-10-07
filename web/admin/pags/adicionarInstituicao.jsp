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

%>
<section class="content-header">
      <h1>
          ADICIONAR INSTITUIÇÃO
        <small>formulário</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="/Artemis/admin/"><i class="fa fa-dashboard"></i> Inicio</a></li>
        <li class="active">Cadastrar instituição</li>
      </ol>
    </section>
    <%

        if(request.getParameter("cadastro") != null){
            try{
                InstituicaoBeans instituicao = new InstituicaoBeans();
                instituicao.setNome(request.getParameter("nome"));
                facade.criarInstituicao(instituicao);
                request.setAttribute("msg", "Instituição adicionada com sucesso!");
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
                <h3 class="box-title"><%=(request.getAttribute("msg") != null) ? request.getAttribute("msg") : "Registre uma nova isntituição" %></h3>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
            <form action="" method="post">
              <div class="box-body">
                <div class="form-group">
                <label>Nome</label>
                    <input type="text" class="form-control" id="nome" placeholder="Nome da instituição" name="nome" value="<%=(request.getParameter("nome") != null) ? request.getParameter("nome") : ""%>">
                </div>
              <!-- /.form group -->  
              </div>
              <!-- /.box-body -->

              <div class="box-footer">
                <button type="submit" class="btn btn-primary" name="cadastro" value="instituicao">Adicionar instituição</button>
              </div>
            </form>
          </div>
          <!-- /.box -->
        </div>
      </div>
    </section>