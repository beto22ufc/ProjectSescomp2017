<%@page import="artemis.beans.AtividadeBeans"%>
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
    AtividadeBeans atividade = facade.getAtividade(facade.getCodFromParameter(request.getParameter("a")));
    if(request.getParameter("cadastro") != null){
        try{
            atividade.setRecursosSolicitados(request.getParameter("recursos"));
            facade.atualizaAtividade(atividade);
            request.setAttribute("msg", "Recurso adicionado/atualizado com sucesso!");
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
        <%=(atividade.getRecursosSolicitados() !=null) ? "Atualizar".toUpperCase() : "Adicionar".toUpperCase()  %>  SOLICITAÇÃO DE RECURSOS DA ATIVIDADE <b><%=atividade.getNome().toUpperCase() %></b>
        <small>formulário</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="/Artemis/admin/"><i class="fa fa-dashboard"></i> Inicio</a></li>
        <li class="active">Solicitar recurso</li>
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
                <h3 class="box-title"><%=(request.getAttribute("msg") != null) ? request.getAttribute("msg") : "Registre os recursos necessários" %></h3>
                
            </div>
            <!-- /.box-header -->
            <!-- form start -->
            <form action="" method="post">
                <div class="box-body">
                    <div class="form-group">
                      <label>Recursos</label>
                      <textarea class="textarea" rows="3" name="recursos" placeholder="informe os recursos que você necessita para realizar esta atividade..." value="<%=(request.getParameter("recursos") != null) ? request.getParameter("recursos") : (atividade.getRecursosSolicitados() != null) ? atividade.getRecursosSolicitados() : "" %>" style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;"><%=(request.getParameter("recursos") != null) ? request.getParameter("recursos") : (atividade.getRecursosSolicitados() != null) ? atividade.getRecursosSolicitados() : "" %></textarea>
                    </div>
                    
              <!-- /.form group -->  
              </div>
                
              <!-- /.box-body -->

              <div class="box-footer">
                <button type="submit" class="btn btn-primary" name="cadastro" value="curso"><%=(atividade.getRecursosSolicitados() !=null) ? "Atualizar" : "Adicionar"  %> recursos</button>
              </div>
            </form>
          </div>
          <!-- /.box -->
        </div>
      </div>
    </section>