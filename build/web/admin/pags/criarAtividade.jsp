<%@page import="java.time.format.DateTimeParseException"%>
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
                if(request.getParameter("instituicao") != null && !request.getParameter("instituicao").isEmpty()){
                AtividadeBeans atividade = new AtividadeBeans();
                atividade.setNome(request.getParameter("nome"));
                atividade.setDescricao(request.getParameter("descricao"));
                atividade.setCategoria(request.getParameter("categoria"));
                atividade.setTemCertificado((request.getParameter("temCertificado") != null && request.getParameter("temCertificado").equals("1")));
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
                atividade.setPeriodoBeanses(periodos);
                if((Integer.parseInt(request.getParameter("qtdVagasInternas")) + Integer.parseInt(request.getParameter("qtdVagasExternas"))) == Integer.parseInt(request.getParameter("qtdVagas"))){
                    atividade.setLimiteVagas(Integer.parseInt(request.getParameter("qtdVagas")));
                    atividade.setVagasInternas(Integer.parseInt(request.getParameter("qtdVagasInternas")));
                    atividade.setVagasPublicas(Integer.parseInt(request.getParameter("qtdVagasExternas")));
                    atividade.setNivel(Integer.parseInt(request.getParameter("nivel")));
                    atividade.setTipoPagamento(Integer.parseInt(request.getParameter("tipoPagamento")));
                    atividade = facade.cadastraAtividade(atividade);
                    if(request.getParameter("e") != null){
                        EventoBeans evento = facade.getEvento(facade.getCodFromParameter(request.getParameter("e")));
                        if(evento != null){
                            evento.getAtividades().add(atividade);
                            facade.atualizaEvento(evento);
                        }                
                    }
                    if(request.getParameter("ministrante") != null || !request.getParameter("ministrante").isEmpty()){
                        atividade.setMinistrante(facade.getUsuario(Long.parseLong(request.getParameter("ministrante"))));
                        facade.adicionaNivelUsuario(facade.getUsuario(Long.parseLong(request.getParameter("ministrante"))), "ministrante");
                    }
                    atividade.setAdministradores(new ArrayList<UsuarioBeans>());
                    atividade.getAdministradores().add((UsuarioBeans)session.getAttribute("usuario"));
                    InstituicaoBeans instituicao = facade.getInstituicao(Long.parseLong(request.getParameter("instituicao")));
                    instituicao.getAtividades().add(atividade);
                    facade.atualizaAtividade(atividade);
                    facade.atualizaInstituicao(instituicao);
                    request.setAttribute("msg", "Atividade cadastrada com sucesso!");
                }else{
                    request.setAttribute("msg", "A soma da quantidade de vagas internas com as vagas externas devem ser igual a quantidade de vagas!");
                }
                }else{
                    request.setAttribute("msg", "Deve ser selecionado uma institui��o! "
                            + "(Caso n�o haja uma institui��o para selecionar, contactar"
                            + " o administrador do sistema para ele adicionar uma institui��o)");                  
                }
            }catch(IllegalAccessException e){
                request.setAttribute("msg", e.getMessage());
            }catch(NumberFormatException e){
                request.setAttribute("msg", "Nos campos onde se pede um n�mero deve ser digitado um n�mero!");
            }catch(IllegalArgumentException e){
                request.setAttribute("msg", e.getMessage());
            }catch(NullPointerException e){
                request.setAttribute("msg", e.getMessage());
            }catch(DateTimeParseException e){
                request.setAttribute("msg","Formato de data inv�lido");
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
                <label>Institui��o</label>
                    <%
                        if(request.getParameter("e")!=null){
                            EventoBeans evento = facade.getEvento(facade.getCodFromParameter(request.getParameter("e")));
                            InstituicaoBeans instituicao = facade.getInstituicao(evento);
                        
                    %>
                    <input type="hidden" name="instituicao" value="<%=instituicao.getCodInstituicao() %>">
                    <input type="text" class="form-control" id="nomeDaInstituicao" placeholder="Nome da institui��o" name="nomeDaInstituicao" value="<%=instituicao.getNome() %>" disabled="disabled"/>
                    <%
                        }else{
                    %>
                    <select class="form-control select2" style="width: 100%;" name="instituicao">
                        <option value="" >Selecione uma institui��o</option>
                        <%
                            List<InstituicaoBeans> instituicoes = facade.getInstituicoes();
                            for(int i=0;i<instituicoes.size();i++){
                               InstituicaoBeans instituicao = instituicoes.get(i);
                            
                        %>
                        <option  value="<%=instituicao.getCodInstituicao() %>"><%=instituicao.getNome() %></option>
                        <%  }%>
                    </select>
                    <%  }%>
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
                        <option value="1">B�sico</option>
                        <option value="2">M�dio</option>
                        <option value="3">Avan�ado</option>
                    </select>
                </div>
                <div class="form-group">
                <label>Tipo de pagamento</label>
                    <select class="form-control select2" style="width: 100%;" name="tipoPagamento">
                        <option  value="1">Nenhum pagamento</option>
                        <option  value="2">Dinheiro</option>
                        <option  value="3">Alimento n�o perec�vel</option>
                    </select>
                </div>
                <label>Tem certificado?</label>
                    <select class="form-control select2" style="width: 100%;" name="temCertificado">
                        <option selected="selected" value="1">Sim</option>
                        <option value="0" >N�o</option>
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
                <button type="submit" class="btn btn-primary" name="cadastro" value="atividade">Cadastrar atividade</button>
              </div>
            </form>
          </div>
          <!-- /.box -->
        </div>
      </div>
    </section>