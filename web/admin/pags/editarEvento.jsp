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
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<section class="content-header">
      <h1>
        ATUALIZAR EVENTO
        <small>formulário</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="/Artemis/admin/"><i class="fa fa-dashboard"></i> Inicio</a></li>
        <li class="active">Atualizar evento</li>
      </ol>
    </section>
    <%
        String dir = config.getServletContext().getInitParameter("dir");
        UsuarioBeans usuario = (UsuarioBeans) session.getAttribute("usuario");
        Facade facade = new Facade(usuario);
        request.setCharacterEncoding("UTF-8");
        EventoBeans evento = null;
        InstituicaoBeans ins = null;
        try{
            evento = facade.getEvento(facade.getCodFromParameter(request.getParameter("e")));
            if(!evento.getAdministradores().contains((UsuarioBeans) session.getAttribute("usuario"))){
                response.sendRedirect("/"+dir+"/404");
            }
            ins = facade.getInstituicao(evento);
        }catch(NumberFormatException e){
            response.sendRedirect("/"+dir+"/404");
        }catch(NullPointerException e){
            response.sendRedirect("/"+dir+"/404");
        }catch(Exception e){
            response.sendRedirect("/"+dir+"/404");
        }
        if(request.getParameter("atualiza") != null){
            try{
                if(request.getParameter("instituicao") != null && !request.getParameter("instituicao").isEmpty()){
                    evento.setNome(request.getParameter("nome"));
                    evento.setDescricao(request.getParameter("descricao"));
                    evento.setCategoria(request.getParameter("categoria"));
                    evento.setEmail(request.getParameter("email"));
                    evento.setTemCertificado((request.getParameter("temCertificado") != null && request.getParameter("temCertificado").equals("1")));
                    evento.setTemInscricao((request.getParameter("temInscricao") != null && request.getParameter("temInscricao").equals("1")));
                    evento.setPorcentagemMinimaGerarCertifciado(Float.parseFloat(request.getParameter("porcentagem")));
                    if(evento.getLocalizacao()!=null){
                        evento.getLocalizacao().setNome(request.getParameter("localizacao"));
                        evento.getLocalizacao().setLat(Float.parseFloat(request.getParameter("lat")));
                        evento.getLocalizacao().setLng(Float.parseFloat(request.getParameter("lng")));
                    }
                    facade.atualizaEvento(evento);
                    InstituicaoBeans instituicao = facade.getInstituicao(Long.parseLong(request.getParameter("instituicao")));
                    if(instituicao !=null && instituicao.getCodInstituicao()!=ins.getCodInstituicao()){
                        ins.getEventos().remove(evento);
                        facade.atualizaInstituicao(ins);
                        instituicao.getEventos().add(evento);
                        facade.atualizaInstituicao(instituicao);
                    }
                    request.setAttribute("msg", "Evento atualizado com sucesso!");
                }else{
                    request.setAttribute("msg", "Deve ser selecionado uma instituição! "
                            + "(Caso não haja uma instituição para selecionar, contactar"
                            + " o administrador do sistema para ele adicionar uma instituição)");
                }
            }catch(IllegalAccessException e){
                request.setAttribute("msg", e.getMessage());
            }catch(NumberFormatException e){
                request.setAttribute("msg", e.getMessage());
            }catch(IllegalArgumentException e){
                request.setAttribute("msg", e.getMessage());
            }catch(NullPointerException e){
                request.setAttribute("msg", e.getMessage()+" null");
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
                <h3 class="box-title"><%=(request.getAttribute("msg") != null) ? request.getAttribute("msg") : "Atualize esse evento" %></h3>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
            <form action="" method="post">
              <div class="box-body">
                <div class="form-group">
                  <label for="nome">Evento</label>
                  <input type="text" class="form-control" id="nome" placeholder="Nome do evento" name="nome" value="<%=(request.getParameter("nome") != null) ? request.getParameter("nome") : (evento != null && evento.getNome()!=null) ? evento.getNome() : "" %>">
                </div>
                <div class="box-body pad form-group">
                    <label>Descrição</label>
                    <textarea class="textarea" name="descricao" placeholder="Descrição para o evento" style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;" value="<%=(request.getParameter("descricao") != null) ? request.getParameter("descricao") : (evento != null && evento.getDescricao()!=null) ? evento.getDescricao(): ""%>"><%=(request.getParameter("descricao") != null) ? request.getParameter("descricao") : (evento != null && evento.getDescricao()!=null) ? evento.getDescricao(): "" %></textarea>
                </div>
                <div class="form-group">
                  <label for="nome">E-mail</label>
                  <input type="text" class="form-control" id="nome" placeholder="E-mail para contato" name="email" value="<%=(request.getParameter("email") != null) ? request.getParameter("email") : (evento != null && evento.getEmail()!=null) ? evento.getEmail(): "" %>">
                </div>
                <div class="form-group">
                <label>Categoria</label>
                        <select class="form-control select2" style="width: 100%;" name="categoria">
                        <option  value="">Selecione uma categoria</option>
                        <optgroup label="EVENTOS SOCIAIS">
                            <option value="Almoço banquete">Almoço banquete</option>
                            <option value="Brunch">Brunch</option>
                            <option value="Café da manhã">Café da manhã</option>
                            <option value="Chás">Chás</option>
                            <option value="Coquetel">Coquetel</option>
                            <option value="Festas ao ar livre">Festas ao ar livre</option>
                            <option value="Festas beneficentes">Festas beneficentes</option>
                            <option value="Festa de debutante">Festa de debutante</option>
                            <option value="Jantar banquete">Jantar banquete</option>
                            <option value="Noivados">Noivados</option>
                            <option value="Open House">Open House</option>
                        </optgroup>
                        <optgroup label="EVENTOS PROFISSIONAIS">
                            <option value="Coffe break">Coffe break</option>
                            <option value="Colóquio">Colóquio</option>
                            <option value="Condecorações">Condecorações</option>
                            <option value="Desfiles">Desfiles</option>
                            <option value="Leilões">Leilões</option>
                            <option value="Visitas institucionais">Visitas institucionais</option>
                        </optgroup>
                        <optgroup label="EVENTOS OFICIAIS">
                            <option value="Assinaturas">Assinaturas</option>
                            <option value="Homenagens e premiações">Homenagens e premiações</option>
                            <option value="Inaugurações">Inaugurações</option>
                            <option value="Posses">Posses</option>
                        </optgroup>
                        <optgroup label="EVENTOS TÉCNICO-CIENTÍFICOS">
                            <option value="Ciclo de palestras">Ciclo de palestras</option>
                            <option value="Conferências">Conferências</option>
                            <option value="Congressos">Congressos</option>
                            <option value="Convenção">Convenção</option>
                            <option value="Feira">Feira</option>
                            <option value="Fórum">Fórum</option>
                            <option value="Mesa redonda">Mesa redonda</option>
                            <option value="Painel">Painel</option>
                            <option value="Reunião">Reunião</option>
                            <option value="Semana">Semana</option>
                            <option value="Seminário">Seminário</option>
                            <option value="Simpósio">Simpósio</option>
                            <option value="Workshop">Workshop</option>
                        </optgroup>
                        <optgroup label=" EVENTOS ARTÍSTICOS">
                            <option value="Exposição">Exposição</option>
                            <option value="Mostra">Mostra</option>
                            <option value="Vernissages">Vernissages</option>
                        </optgroup>
                        <optgroup label="EVENTOS CULTURAIS">
                            <option value="Concursos">Concursos</option>
                            <option value="Entrevista coletiva">Entrevista coletiva</option>
                            <option value="Formaturas">Formaturas</option>
                            <option value="Tarde de autógrafos">Tarde de autógrafos</option>
                            <option value="Torneio">Torneio</option>
                        </optgroup>
                        <optgroup label="EVENTOS RELIGIOSOS">
                            <option value="Bar e bat-mitzva">Bar e bat-mitzva</option>
                            <option value="Batizados">Batizados</option>
                            <option value="Brit-miláh">Brit-miláh</option>
                            <option value="Casamentos">Casamentos</option>
                            <option value="Conclaves">Conclaves</option>
                            <option value="Primeira comunhão">Primeira comunhão</option>
                        </optgroup>
                    </select>
                </div> 
                <div class="form-group">
                  <label for="localizacao">Localização</label>
                  <input type="text" class="form-control" id="localizacao" placeholder="Localização do evento"  name="localizacao" value="<%=(request.getParameter("localizacao") !=null) ? request.getParameter("localizacao") : (evento != null && evento.getLocalizacao()!=null && evento.getLocalizacao().getNome() !=null) ? evento.getLocalizacao().getNome() : ""%>">
                  <input type="hidden" class="form-control" id="lat" placeholder="Nome do evento" name="lat" value="<%=(request.getParameter("localizacao") !=null) ? request.getParameter("localizacao") : (evento != null && evento.getLocalizacao()!=null) ? evento.getLocalizacao().getLat(): ""%>">
                  <input type="hidden" class="form-control" id="lng" placeholder="Nome do evento" name="lng" value="<%=(request.getParameter("localizacao") !=null) ? request.getParameter("localizacao") : (evento != null && evento.getLocalizacao()!=null) ? evento.getLocalizacao().getLng(): ""%>">
                </div>
                <div class="form-group">
                <label>Instituição</label>
                    <select class="form-control select2" style="width: 100%;" name="instituicao">
                        <option value="" >Selecione uma instituição</option>
                        <%
                            List<InstituicaoBeans> instituicoes = facade.getInstituicoes();
                            for(int i=0;i<instituicoes.size();i++){
                               InstituicaoBeans instituicao = instituicoes.get(i);
                            
                        %>
                        <option  value="<%=instituicao.getCodInstituicao() %>"  <%=(request.getParameter("instituicao") !=null && request.getParameter("instituicao").equals(instituicao.getCodInstituicao()+"")) ? "selected=/'selected/'" :  (ins!=null && ins.getCodInstituicao()==instituicao.getCodInstituicao()) ? "selected=/'selected/'" : ""%>><%=instituicao.getNome() %></option>
                        <%  }%>
                    </select>
                </div>
                <div class="form-group">
                  <label for="porcentagem">Por centagem mínima para gerar certificados</label>
                  <input type="number" class="form-control" id="porcentagem" placeholder="Por centagem mínima para gerar certificados"  name="porcentagem" value="<%=(request.getParameter("porcentagem") !=null) ? request.getParameter("porcentagem") : (evento != null) ? evento.getPorcentagemMinimaGerarCertifciado() : ""%>" max="100" min="0">
                </div>
                <div class="form-group">
                <label>Tem certificado?</label>
                    <select class="form-control select2" style="width: 100%;" name="temCertificado">
                        <option  value="1" <%=(request.getParameter("temCertificado") !=null && request.getParameter("temCertificado").equals("1")) ? "selected=/'selected/'" : (evento != null && evento.isTemCertificado()) ? "selected='/selected/'" : ""%>>Sim</option>
                        <option  value="0" <%=(request.getParameter("temCertificado") !=null && request.getParameter("temCertificado").equals("0")) ? "selected=/'selected/'" : (evento != null && !evento.isTemCertificado()) ? "selected='/selected/'" : ""%>>Não</option>
                    </select>
                </div>
                <div class="form-group">
                <label>Tem inscrição?</label>
                <p><small>*Se é possível se inscrever no evento como um todo, não somente em suas atividades</small></p>
                    <select class="form-control select2" style="width: 100%;" name="temInscricao">
                        <option value="1" <%=(request.getParameter("temInscricao") !=null && request.getParameter("temInscricao").equals("1")) ? "selected=/'selected/'" : (evento != null && evento.isTemInscricao()) ? "selected='/selected/'" : ""%>>Sim</option>
                        <option value="0" <%=(request.getParameter("temInscricao") !=null && request.getParameter("temInscricao").equals("0")) ? "selected=/'selected/'" : (evento != null && !evento.isTemInscricao()) ? "selected='/selected/'" : ""%>>Não</option>
                    </select>
                </div>
                <!-- Date and time range -->
              
              <!-- /.form group -->  
              </div>
              <!-- /.box-body -->

              <div class="box-footer">
                <button type="submit" class="btn btn-primary" name="atualiza" value="evento">Atualizar evento</button>
              </div>
            </form>
          </div>
          <!-- /.box -->
        </div>
      </div>
    </section>