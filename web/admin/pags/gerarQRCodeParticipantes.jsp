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
    UsuarioBeans usuario = null;
    try{
        usuario = facade.getUsuario(facade.getCodFromParameter(request.getParameter("u")));
    }catch(NumberFormatException e){
        response.sendRedirect("/"+dir+"/404");
    }catch(NullPointerException e){
        response.sendRedirect("/"+dir+"/404");            
    }
%>
<section class="content-header">
      <h1>
          GERAR QRCODE DE <b><%=usuario.getNome().toUpperCase() %></b>
        <small>formulário</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="/Artemis/admin/"><i class="fa fa-dashboard"></i> Inicio</a></li>
        <li class="active">Gerar QRCode</li>
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
                <h3 class="box-title"><%=(request.getAttribute("msg") != null) ? request.getAttribute("msg") : "Gere um novo QRCode" %></h3>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
              <div class="box-body">
                    <div class="form-group">
                        <label for="bg">Background</label>
                        <input type="text" class="form-control" id="bg" placeholder="Background" value="#C2C">
                    </div>
                    <div class="form-group">
                        <label for="size">Tamanho</label>
                        <input type="number" class="form-control" id="size" placeholder="Tamanho" value="195">
                    </div>
                    <div class="form-group">
                        <label for="version">Versão</label>
                        <input type="number" class="form-control" id="version" placeholder="Versão" value="10">
                    </div>
                    <div class="form-group">
                        <label for="version">Tipo preenchimento</label>
                        <select id='fillType' name="fillType" class="form-control">
                            <option>scale_to_fit</option>
                            <option>fill</option>
                        </select>
                    </div>
                    <div class="form-group">
                        Threshold: <input type="radio" value="threshold" name="filter" >
                        Color: <input type="radio" value="color" name="filter" checked>
                    </div>
                    <div class="form-group">
                        <div id="qr"></div>
                        <div id="image">
                        <%
                        if (usuario.getImagemPerfil() == null) {
                        %>
                       <img src="/<%=dir%>/static/img/avatar-default.png" alt="User Image" id="image_test" style="width: 171px; height: 171px;">
                        <%
                        } else {
                        %>
                        <img src="<%=ImageManipulation.encodeImage(usuario.getImagemPerfil())%>" id="image_test"alt="User Image" style="width: 171px; height: 171px;">
                        <%  }%></div>
                    </div>
                    <div class="form-group">
                        <label for="version">QRCode</label>
                        <div id="combine"></div>
                        <canvas id="crachar" style="width: 100%;height: 200px;border: 1px solid #000;display:none">
                            
                        </canvas>
                    </div>
              <!-- /.form group -->  
              </div>
              <!-- /.box-body -->

              <div class="box-footer">
                <button class="btn btn-primary" name="gerar" value="qrcode" id="gerarQRCode" >Gerar QRCode</button>
              </div>
          </div>
          <!-- /.box -->
        </div>
      </div>
    </section>
