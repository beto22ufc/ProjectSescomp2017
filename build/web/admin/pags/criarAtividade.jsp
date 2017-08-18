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
<section class="content-header">
      <h1>
        CADASTRAR ATIVIDADE
        <small>formul�rio</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="/Artemis/admin/"><i class="fa fa-dashboard"></i> Inicio</a></li>
        <li class="active">Cadastrar evento</li>
      </ol>
    </section>
    <%
        Facade facade = new Facade((UsuarioBeans) session.getAttribute("usuario"));
        List<UsuarioBeans> usuarios = facade.getUsuarios();
        if(request.getParameter("cadastro") != null){
            try{
                AtividadeBeans atividade = new AtividadeBeans();
                atividade.setNome(request.getParameter("nome"));
                atividade.setDescricao(request.getParameter("descricao"));
                atividade.setCategoria(request.getParameter("categoria"));
                atividade.setMinistrante(facade.getUsuario(Long.parseLong(request.getParameter("ministrante"))));
                String[] inicioDatas = request.getParameterValues("dataInicio[]"),
                inicioTempos = request.getParameterValues("tempoInicio[]"),
                terminoDatas = request.getParameterValues("dataTermino[]"),
                terminoTempos = request.getParameterValues("tempoTermino[]");
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
                List<PeriodoBeans> periodos = new ArrayList<>();
                for(int i=0;i<inicioTempos.length;i++){
                    if(inicioDatas[i] != null && inicioTempos[i] != null && terminoDatas[i] != null && terminoTempos[i] != null)
                        periodos.add(new PeriodoBeans(LocalDateTime.parse(inicioDatas[i]+" "+inicioTempos[i], formatter), LocalDateTime.parse(terminoDatas[i]+" "+terminoTempos[i], formatter)));
                }
                atividade.setPeriodoBeanses(periodos);
                if((Integer.parseInt(request.getParameter("qtdVagasInternas")) + Integer.parseInt(request.getParameter("qtdVagasExternas"))) == Integer.parseInt(request.getParameter("qtdVagas"))){
                    atividade.setLimiteVagas(Integer.parseInt(request.getParameter("qtdVagas")));
                    atividade.setVagasInternas(Integer.parseInt(request.getParameter("qtdVagasInternas")));
                    atividade.setVagasPublicas(Integer.parseInt(request.getParameter("qtdVagasExternas")));
                    atividade = facade.cadastraAtividade(atividade);
                    atividade.setAdministradores(new ArrayList<UsuarioBeans>());
                    atividade.getAdministradores().add((UsuarioBeans)session.getAttribute("usuario"));
                    facade.atualizaAtividade(atividade);
                    if(request.getParameter("e") != null){
                        EventoBeans evento = facade.getEvento(facade.getCodFromParameter(request.getParameter("e")));
                        if(evento != null){
                            evento.getAtividades().add(atividade);
                            facade.atualizaEvento(evento);
                        }                
                    }
                    request.setAttribute("msg", "Atividade cadastrada com sucesso!");
                }else{
                    request.setAttribute("msg", "A soma da quantidade de vagas internas com as vagas externas devem ser igual a quantidade de vagas!");
                }
            }catch(IllegalAccessException e){
                request.setAttribute("msg", e.getMessage());
            }catch(NumberFormatException e){
                request.setAttribute("msg", e.getMessage());
            }catch(IllegalArgumentException e){
                request.setAttribute("msg", e.getMessage());
            }catch(NullPointerException e){
                request.setAttribute("msg", e.getMessage()+" Aqui ");
            }catch(Exception e){
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
                <h3 class="box-title"><%=(request.getAttribute("msg") != null) ? request.getAttribute("msg") : "Registre uma nova atividade" %></h3>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
            <form action="" method="post">
              <div class="box-body">
                <div class="form-group">
                  <label for="nome">Atividade</label>
                  <input type="text" class="form-control" id="nome" placeholder="Nome da atividade" name="nome" value="<%=(request.getParameter("nome") != null) ? request.getParameter("nome") : ""%>">
                </div>
                <div class="box-body pad form-group">
                    <label>Descri��o</label>
                    <textarea class="textarea" name="descricao" placeholder="Descri��o para a atividade" style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;" value="<%=(request.getParameter("descricao") != null) ? request.getParameter("descricao") : ""%>"><%=(request.getParameter("descricao") != null) ? request.getParameter("descricao") : ""%></textarea>
                </div>
                <div class="form-group">
                <label>Categoria</label>
                    <select class="form-control select2" style="width: 100%;" name="categoria">
                        <option selected="selected" value="">Selecione uma categoria</option>
                        <optgroup label="EVENTOS SOCIAIS">
                            <option value="Almo�o banquete">Almo�o banquete</option>
                            <option value="Brunch">Brunch</option>
                            <option value="Caf� da manh�">Caf� da manh�</option>
                            <option value="Ch�s">Ch�s</option>
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
                            <option value="Col�quio">Col�quio</option>
                            <option value="Condecora��es">Condecora��es</option>
                            <option value="Desfiles">Desfiles</option>
                            <option value="Leil�es">Leil�es</option>
                            <option value="Visitas institucionais">Visitas institucionais</option>
                        </optgroup>
                        <optgroup label="EVENTOS OFICIAIS">
                            <option value="Assinaturas">Assinaturas</option>
                            <option value="Homenagens e premia��es">Homenagens e premia��es</option>
                            <option value="Inaugura��es">Inaugura��es</option>
                            <option value="Posses">Posses</option>
                        </optgroup>
                        <optgroup label="EVENTOS T�CNICO-CIENT�FICOS">
                            <option value="Ciclo de palestras">Ciclo de palestras</option>
                            <option value="Confer�ncias">Confer�ncias</option>
                            <option value="Congressos">Congressos</option>
                            <option value="Conven��o">Conven��o</option>
                            <option value="Feira">Feira</option>
                            <option value="F�rum">F�rum</option>
                            <option value="Mesa redonda">Mesa redonda</option>
                            <option value="Painel">Painel</option>
                            <option value="Reuni�o">Reuni�o</option>
                            <option value="Semana">Semana</option>
                            <option value="Semin�rio">Semin�rio</option>
                            <option value="Simp�sio">Simp�sio</option>
                            <option value="Workshop">Workshop</option>
                        </optgroup>
                        <optgroup label=" EVENTOS ART�STICOS">
                            <option value="Exposi��o">Exposi��o</option>
                            <option value="Mostra">Mostra</option>
                            <option value="Vernissages">Vernissages</option>
                        </optgroup>
                        <optgroup label="EVENTOS CULTURAIS">
                            <option value="Concursos">Concursos</option>
                            <option value="Entrevista coletiva">Entrevista coletiva</option>
                            <option value="Formaturas">Formaturas</option>
                            <option value="Tarde de aut�grafos">Tarde de aut�grafos</option>
                            <option value="Torneio">Torneio</option>
                        </optgroup>
                        <optgroup label="EVENTOS RELIGIOSOS">
                            <option value="Bar e bat-mitzva">Bar e bat-mitzva</option>
                            <option value="Batizados">Batizados</option>
                            <option value="Brit-mil�h">Brit-mil�h</option>
                            <option value="Casamentos">Casamentos</option>
                            <option value="Conclaves">Conclaves</option>
                            <option value="Primeira comunh�o">Primeira comunh�o</option>
                        </optgroup>
                    </select>
                </div>
                <div class="form-group">
                <label>Ministrante</label>
                    <select class="form-control select2" style="width: 100%;" name="ministrante">
                        <option selected="selected" value="">Selecione uma ministrante</option>
                        <%
                            for(int i=0;i<usuarios.size();i++){
                                UsuarioBeans u = usuarios.get(i);
                        %>
                        <option  value="<%=u.getCodUsuario() %>"><%=u.getNome()+" - "+u.getCpf().getSecretCpf() %></option>
                        <%}%>
                    </select>
                </div>
                <div class="form-group">
                  <label for="qtdVagas">Vagas</label>
                  <input type="number" class="form-control" id="qtdVagas" placeholder="Quantidade de vagas da atividade" name="qtdVagas" value="<%=(request.getParameter("qtdVagas") != null) ? request.getParameter("qtdVagas") : ""%>">
                </div>
                <div class="form-group">
                  <label for="qtdVagasInternas">Vagas internas</label>
                  <input type="number" class="form-control" id="qtdVagasInternas" placeholder="Quantidade de vagas internas da atividade" name="qtdVagasInternas" value="<%=(request.getParameter("qtdVagasInternas") != null) ? request.getParameter("qtdVagasInternas") : ""%>">
                </div>
                <div class="form-group">
                  <label for="qtdVagasExternas">Vagas externas</label>
                  <input type="number" class="form-control" id="qtdVagasExternas" placeholder="Quantidade de vagas externas da atividade" name="qtdVagasExternas" value="<%=(request.getParameter("qtdVagasExternas") != null) ? request.getParameter("qtdVagasExternas") : ""%>">
                </div>
                <div class="form-group">
                <label>N�vel de conhecimento na �rea</label>
                    <select class="form-control select2" style="width: 100%;" name="nivel">
                        <option selected="selected" value="">Selecione um n�vel de conhecimento necess�rio na �rea</option>
                        <option selected="selected" value="1">Nenhum n�vel</option>
                        <option selected="selected" value="2">B�sico</option>
                        <option selected="selected" value="3">M�dio</option>
                        <option selected="selected" value="4">Avan�ado</option>
                    </select>
                </div>
                <div class="form-group">
                <label>Tipo de pagamento</label>
                    <select class="form-control select2" style="width: 100%;" name="tipoPagamento">
                        <option selected="selected" value="">Selecione um pagamento necess�rio para a atividade</option>
                        <option selected="selected" value="1">Nenhum pagamento</option>
                        <option selected="selected" value="2">Dinheiro</option>
                        <option selected="selected" value="3">Alimento n�o perec�vel</option>
                    </select>
                </div> 
                <!-- Date and time range -->
                <div class="form-group periodos">
                    <label>Periodos: <a href="javascript:void(0);" title="Adicionar novo periodo" class="adicionarNovoPeriodo" onclick="addPeriodo();"><i class="fa fa-plus"></i></a></label>

                  <div class="form-group">
                    <label for="dataInicio">Inicio</label>
                    <input type="date" class="form-control" id="dataInicio" placeholder="Data incio" name="dataInicio[]">
                    <br />
                    <input type="time" class="form-control" id="dataInicio" placeholder="Tempo inicio" name="tempoInicio[]">
                  </div>
                  <div class="form-group">
                    <label for="dataInicio">Termino</label>
                    <input type="date" class="form-control" id="dataInicio" placeholder="Data incio" name="dataTermino[]">
                    <br />
                    <input type="time" class="form-control" id="dataInicio" placeholder="Tempo inicio" name="tempoTermino[]">
                  </div>
                  <!-- /.input group -->
                </div>
              <!-- /.form group -->  
              </div>
              <!-- /.box-body -->

              <div class="box-footer">
                <button type="submit" class="btn btn-primary" name="cadastro" value="atividade">Cadastrar atividade</button>
              </div>
            </form>
          </div>
          <!-- /.box -->
        </div>
      </div>
    </section>