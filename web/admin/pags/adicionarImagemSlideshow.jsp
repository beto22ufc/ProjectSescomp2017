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
    session.setAttribute("eventoUpadate", evt);
%>
<section class="content-header">
      <h1>
          ADICIONAR IMAGEM PARA SLIDESHOW DO EVENTO <b><%=evt.getNome().toUpperCase() %></b>
        <small>formulário</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="/Artemis/admin/"><i class="fa fa-dashboard"></i> Inicio</a></li>
        <li class="active">Cadastrar imagem</li>
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
                <h3 class="box-title"><%=(request.getAttribute("msg") != null) ? request.getAttribute("msg") : "Registre uma nova imagem" %></h3>
                <p><small>Caso o tema do evento não contenha um slideshow na estrutura do site, será mostrada uma imagem aleatória a cada vez que a página for carregada ou recarregada. E se existir um sobre que contenha uma imagem de exemplo, será a primeira imagem da lista do slideshow.</small></p>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
            <form action="/<%=dir%>/ImagemSlideshowUpload" method="post" enctype="multipart/form-data">
              
                <div class="box-body">
                    <div class="form-group">
                      <label>Descrição</label>
                      <textarea class="textarea" rows="3" name="descricao" placeholder="Uma descrição para esta imagem..." style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;"></textarea>
                    </div>
                    <div class="form-group">
                        <label for="arquivo">Imagem</label>
                        <input type="file" class="form-control" id="arquivo" placeholder="Selecione uma imagem" name="arquivo">                    
                    </div>
              <!-- /.form group -->  
              </div>
              <!-- /.box-body -->

              <div class="box-footer">
                <button type="submit" class="btn btn-primary" >Adicionar imagem</button>
              </div>
            </form>
          </div>
          <!-- /.box -->
        </div>
      </div>
    </section>