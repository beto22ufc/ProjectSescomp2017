<%@page import="artemis.beans.CursoBeans"%>
<%@page import="artemis.beans.InstituicaoBeans"%>
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
    InstituicaoBeans instituicao = facade.getInstituicao(facade.getCodFromParameter(request.getParameter("i")));
    if(request.getParameter("cadastro") != null){
        try{
            CursoBeans curso = new CursoBeans();
            curso.setNome(request.getParameter("nome"));
            curso.setDescricao(request.getParameter("descricao"));
            curso.setDuracao(Integer.parseInt(request.getParameter("duracao")));
            instituicao.getCursos().add(curso);
            facade.atualizaInstituicao(instituicao);
            request.setAttribute("msg", "Curso adicionado com sucesso!");
        }catch(NumberFormatException e){
            request.setAttribute("msg", "Isso não é um número!");
        }catch(NullPointerException e){
            request.setAttribute("msg", e.getMessage()+" aqui");
        }catch(IllegalArgumentException e){
            request.setAttribute("msg", e.getMessage()+" aqui");
        }
    }
%>
<section class="content-header">
      <h1>
          ADICIONAR CURSO A INSTITUIÇÃO <b><%=instituicao.getNome().toUpperCase() %></b>
        <small>formulário</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="/Artemis/admin/"><i class="fa fa-dashboard"></i> Inicio</a></li>
        <li class="active">Cadastrar curso</li>
      </ol>
    </section>
    <%

       
    %>
    <!-- Main content -->
    <section class="content">
      <div class="row">
        <!-- left column -->
        <div class="col-md-6">
          <!-- general form elements -->
          <div class="box box-primary">
            <div class="box-header with-border">
                <h3 class="box-title"><%=(request.getAttribute("msg") != null) ? request.getAttribute("msg") : "Registre um novo curso" %></h3>
                
            </div>
            <!-- /.box-header -->
            <!-- form start -->
            <form action="" method="post">
                <div class="box-body">
                    <div class="form-group">
                        <label for="nome">Curso</label>
                        <input type="text" class="form-control" id="nome" placeholder="Nome do curso" name="nome" value="<%=(request.getParameter("nome") != null) ? request.getParameter("nome") : "" %>">                    
                    </div>
                    <div class="form-group">
                      <label>Descrição</label>
                      <textarea class="textarea" rows="3" name="descricao" placeholder="Uma descrição para esta imagem..." value="<%=(request.getParameter("descricao") != null) ? request.getParameter("descricao") : "" %>" style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;"><%=(request.getParameter("descricao") != null) ? request.getParameter("descricao") : "" %></textarea>
                    </div>
                    <div class="form-group">
                        <label for="duracao">Duração em anos</label>
                        <input type="number" class="form-control" id="duracao" placeholder="Duração do curso" name="duracao" value="<%=(request.getParameter("duracao") != null) ? request.getParameter("duracao") : "" %>">                    
                    </div>
              <!-- /.form group -->  
              </div>
                
              <!-- /.box-body -->

              <div class="box-footer">
                <button type="submit" class="btn btn-primary" name="cadastro" value="curso">Adicionar Curso</button>
              </div>
            </form>
          </div>
          <!-- /.box -->
        </div>
      </div>
    </section>