<%@page import="artemis.model.ImageManipulation"%>
<%@page import="artemis.beans.ImagemBeans"%>
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
    ImagemBeans imagem = null;
    try{
        evt = facade.getEvento(facade.getCodFromParameter(request.getParameter("e")));
        imagem = facade.getImagem(Long.parseLong(request.getParameter("i")));
        if(!evt.getAdministradores().contains(u)){
            response.sendRedirect("/"+dir+"/404");
        }
    }catch(NumberFormatException e){
        response.sendRedirect("/"+dir+"/404");
    }catch(NullPointerException e){
        response.sendRedirect("/"+dir+"/404");            
    }
    if(request.getParameter("atualiza") != null){
        try{
            imagem.setDescricao(request.getParameter("descricao"));
            facade.atualizaImagem(imagem);
            request.setAttribute("msg", "Imagem atualizada com sucesso!");
        }catch(NumberFormatException e){
            request.setAttribute("msg", "Isso não é um número!");
        }catch(NullPointerException e){
            request.setAttribute("msg", e.getMessage());            
        }catch(IllegalArgumentException e){
            request.setAttribute("msg", e.getMessage());            
        }catch(Exception e){
            request.setAttribute("msg", e.getMessage());            
        }
    }
%>
<section class="content-header">
      <h1>
          ATUALIZAR IMAGEM PARA GALERIA DO EVENTO <b><%=evt.getNome().toUpperCase() %></b>
        <small>formulário</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="/Artemis/admin/"><i class="fa fa-dashboard"></i> Inicio</a></li>
        <li class="active">Atualizar imagem</li>
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
                <h3 class="box-title"><%=(request.getAttribute("msg") != null) ? request.getAttribute("msg") : "Atualize esta imagem" %></h3>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
            <form action="" method="post" >
                <div class="form-group">
                    <img src="<%=ImageManipulation.encodeImage(imagem.getArquivo()) %>" style="width: 200px; height: 200px;">
                </div>
                <div class="box-body">
                    <div class="form-group">
                      <label>Descrição</label>
                      <textarea  class="textarea" rows="3" name="descricao" placeholder="Uma descrição para esta imagem..." style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;" value="<%=(request.getParameter("descricao") != null) ? request.getParameter("descricao") : (imagem!=null && imagem.getDescricao() !=null) ? imagem.getDescricao() : "" %>"><%=(request.getParameter("descricao") != null) ? request.getParameter("descricao") : (imagem!=null && imagem.getDescricao()!=null) ? imagem.getDescricao() : "" %></textarea>
                    </div>
              <!-- /.form group -->  
              </div>
              <!-- /.box-body -->

              <div class="box-footer">
                  <button type="submit" class="btn btn-primary" name="atualiza" value="imagem">Atualizar imagem</button>
              </div>
            </form>
          </div>
          <!-- /.box -->
        </div>
      </div>
    </section>