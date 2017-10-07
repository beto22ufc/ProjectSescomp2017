<%@page import="java.time.format.DateTimeParseException"%>
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
        CADASTRAR EVENTO
        <small>formulário</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="/Artemis/admin/"><i class="fa fa-dashboard"></i> Inicio</a></li>
        <li class="active">Cadastrar evento</li>
      </ol>
    </section>
    <%
        Facade facade = new Facade((UsuarioBeans) session.getAttribute("usuario"));
        request.setCharacterEncoding("UTF-8");
        if(request.getParameter("cadastro") != null){
            try{
                if(request.getParameter("instituicao") != null && !request.getParameter("instituicao").isEmpty()){
                    EventoBeans evento = new EventoBeans();
                    evento.setNome(request.getParameter("nome"));
                    evento.setDescricao(request.getParameter("descricao"));
                    evento.setCategoria(request.getParameter("categoria"));
                    evento.setEmail(request.getParameter("email"));
                    evento.setTemCertificado((request.getParameter("temCertificado") != null && request.getParameter("temCertificado").equals("1")));
                    evento.setTemInscricao((request.getParameter("temInscricao") != null && request.getParameter("temInscricao").equals("1")));
                    evento.setPorcentagemMinimaGerarCertifciado(Float.parseFloat(request.getParameter("porcentagem")));
                    LocalizacaoBeans lb = new LocalizacaoBeans(request.getParameter("localizacao"), Float.parseFloat(request.getParameter("lat")), Float.parseFloat(request.getParameter("lng")));
                    evento.setLocalizacao(lb);
                    String[] inicioDatas = request.getParameterValues("dataInicio[]"),
                    inicioTempos = request.getParameterValues("tempoInicio[]"),
                    terminoDatas = request.getParameterValues("dataTermino[]"),
                    terminoTempos = request.getParameterValues("tempoTermino[]");
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
                    List<PeriodoBeans> periodos = new ArrayList<>();
                    for(int i=0;i<inicioTempos.length;i++){
                        if(inicioDatas[i] != null && inicioTempos[i] != null && terminoDatas[i] != null && terminoTempos[i] != null)
                            periodos.add(new PeriodoBeans(LocalDateTime.parse(inicioDatas[i]+" "+inicioTempos[i], formatter), LocalDateTime.parse(terminoDatas[i]+" "+terminoTempos[i], formatter)));
                    }
                    evento.setPeriodos(periodos);
                    evento =  facade.cadastraEvento(evento);
                    evento.setAdministradores(new ArrayList<UsuarioBeans>());
                    InstituicaoBeans instituicao = facade.getInstituicao(Long.parseLong(request.getParameter("instituicao")));
                    instituicao.getEventos().add(evento);
                    evento.getAdministradores().add((UsuarioBeans)session.getAttribute("usuario"));
                    facade.atualizaEvento(evento);
                    facade.atualizaInstituicao(instituicao);
                    request.setAttribute("msg", "Evento cadastrado com sucesso!");
                }else{
                    request.setAttribute("msg", "Deve ser selecionado uma instituição! "
                            + "(Caso não haja uma instituição para selecionar, contactar"
                            + " o administrador do sistema para ele adicionar uma instituição)");
                }
            }catch(IllegalAccessException e){
                request.setAttribute("msg", e.getMessage());
            }catch(NumberFormatException e){
                request.setAttribute("msg", "Deve ser digitado um número onde se pede!");
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
                <h3 class="box-title"><%=(request.getAttribute("msg") != null) ? request.getAttribute("msg") : "Registre um novo evento" %></h3>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
            <form action="" method="post">
              <div class="box-body">
                <div class="form-group">
                  <label for="nome">Evento</label>
                  <input type="text" class="form-control" id="nome" placeholder="Nome do evento" name="nome" value="<%=(request.getParameter("nome") != null) ? request.getParameter("nome") : ""%>">
                </div>
                <div class="box-body pad form-group">
                    <label>Descrição</label>
                    <textarea class="textarea" name="descricao" placeholder="Descrição para o evento" style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;" value="<%=(request.getParameter("descricao") != null) ? request.getParameter("descricao") : ""%>"><%=(request.getParameter("descricao") != null) ? request.getParameter("descricao") : ""%></textarea>
                </div>
                <div class="form-group">
                  <label for="nome">E-mail</label>
                  <input type="text" class="form-control" id="nome" placeholder="E-mail para contato" name="email" value="<%=(request.getParameter("email") != null) ? request.getParameter("email") : ""%>">
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
                  <input type="text" class="form-control" id="localizacao" placeholder="Localização do evento"  name="localizacao" value="UFC - Campus Russas - Vila Matoso, Russas - CE">
                  <input type="hidden" class="form-control" id="lat" placeholder="Nome do evento" name="lat" value="-4.9450007">
                  <input type="hidden" class="form-control" id="lng" placeholder="Nome do evento" name="lng" value="-37.9772579">
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
                        <option  value="<%=instituicao.getCodInstituicao() %>" <%=(request.getParameter("instituicao") !=null && request.getParameter("instituicao").equals(instituicao.getCodInstituicao()+"")) ? "selected=/'selected/'" :  ""%>><%=instituicao.getNome() %></option>
                        <%  }%>
                    </select>
                </div>
                <div class="form-group">
                  <label for="porcentagem">Por centagem mínima para gerar certificados</label>
                  <input type="number" class="form-control" id="porcentagem" placeholder="Por centagem mínima para gerar certificados"  name="porcentagem" value="<%=(request.getParameter("porcentagem") !=null) ? request.getParameter("porcentagem") : ""%>" max="100" min="0">
                </div>
                <div class="form-group">
                <label>Tem certificado?</label>
                    <select class="form-control select2" style="width: 100%;" name="temCertificado">
                        <option  value="1" <%=(request.getParameter("temCertificado") !=null && request.getParameter("temCertificado").equals("1")) ? "selected=/'selected/'" :  ""%>>Sim</option>
                        <option  value="0" <%=(request.getParameter("temCertificado") !=null && request.getParameter("temCertificado").equals("0")) ? "selected=/'selected/'" :  ""%>>Não</option>
                    </select>
                </div>
                <div class="form-group">
                <label>Tem inscrição?</label>
                <p><small>*Se é possível se inscrever no evento como um todo, não somente em suas atividades</small></p>
                    <select class="form-control select2" style="width: 100%;" name="temInscricao">
                        <option value="1" <%=(request.getParameter("temInscricao") !=null && request.getParameter("temInscricao").equals("1")) ? "selected=/'selected/'" : ""%>>Sim</option>
                        <option value="0" <%=(request.getParameter("temInscricao") !=null && request.getParameter("temInscricao").equals("0")) ? "selected=/'selected/'" : ""%>>Não</option>
                    </select>
                </div>
                <!-- Date and time range -->
                <div class="form-group periodos">
                    <label>Periodos: <a href="javascript:void(0);" title="Adicionar novo periodo" class="adicionarNovoPeriodo" onclick="addPeriodo();"><i class="fa fa-plus"></i></a></label>

                 <div class="form-group">
                    <label for="dataInicio">Inicio</label>
                    <input type="text" class="form-control" id="dataInicio" placeholder="Data incio" name="dataInicio[]" maxlength="10" onkeypress="formatar('##/##/####',this)">
                    <br />
                    <input type="text" class="form-control" id="dataInicio" placeholder="Tempo inicio" name="tempoInicio[]" maxlength="5" onkeypress="formatar('##:##',this)">
                  </div>
                  <div class="form-group">
                    <label for="dataInicio">Termino</label>
                    <input type="text" class="form-control" id="dataInicio" placeholder="Data incio" name="dataTermino[]" maxlength="10" onkeypress="formatar('##/##/####',this)">
                    <br />
                    <input type="text" class="form-control" id="dataInicio" placeholder="Tempo inicio" name="tempoTermino[]" maxlength="5" onkeypress="formatar('##:##',this)">
                  </div>
                  <!-- /.input group -->
                </div>
              <!-- /.form group -->  
              </div>
              <!-- /.box-body -->

              <div class="box-footer">
                <button type="submit" class="btn btn-primary" name="cadastro" value="evento">Cadastrar evento</button>
              </div>
            </form>
          </div>
          <!-- /.box -->
        </div>
      </div>
    </section>