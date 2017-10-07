<%@page import="artemis.model.ImageManipulation"%>
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
    AtividadeBeans atividade = null;
    try{
        atividade = facade.getAtividade(facade.getCodFromParameter(request.getParameter("a")));
    }catch(NumberFormatException e){
        response.sendRedirect("/"+dir+"/404");
    }catch(NullPointerException e){
        response.sendRedirect("/"+dir+"/404");            
    }
%>
<section class="content-header">
      <h1>
          MARCAR PRESENÇA EM <b><%=atividade.getNome().toUpperCase() %></b>
        <small>formulário</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="/Artemis/admin/"><i class="fa fa-dashboard"></i> Inicio</a></li>
        <li class="active">Marcar presença</li>
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
                <h3 class="box-title"><%=(request.getAttribute("msg") != null) ? request.getAttribute("msg") : "Marque uma nova presença" %></h3>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
              <div class="box-body">
                    <div class="form-group">
                        <label for="bg">Scan QRCode</label>
                        <video autoplay></video>
                    </div>                    
              <!-- /.form group -->  
              </div>
              <!-- /.box-body -->

              <div class="box-footer">
                <button class="btn btn-primary" name="gerar" value="qrcode" id="reset" >Restaurar</button>
                <button class="btn btn-default" name="gerar" value="qrcode" id="stop" >Parar</button>
              </div>
          </div>
          <!-- /.box -->
        </div>
      </div>
    </section>
