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
        <small>formulário</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="/Artemis/admin/"><i class="fa fa-dashboard"></i> Inicio</a></li>
        <li class="active">Cadastrar evento</li>
      </ol>
    </section>
    <%
        Facade facade = new Facade((UsuarioBeans) session.getAttribute("usuario"));
        List<UsuarioBeans> usuarios = facade.getUsuarios();
        AtividadeBeans atividade = facade.getAtividade(facade.getCodFromParameter(request.getParameter("a")));
        if(request.getParameter("atualiza") != null){
            try{
                
                atividade.setNome(request.getParameter("nome"));
                atividade.setDescricao(request.getParameter("descricao"));
                atividade.setCategoria(request.getParameter("categoria"));
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
                    atividade.setNivel(Integer.parseInt(request.getParameter("nivel")));
                    atividade.setTipoPagamento(Integer.parseInt(request.getParameter("tipoPagamento")));
                    if(request.getParameter("ministrante") != null || !request.getParameter("ministrante").isEmpty()){
                        atividade.setMinistrante(facade.getUsuario(Long.parseLong(request.getParameter("ministrante"))));
                    }
                    facade.atualizaAtividade(atividade);
                    request.setAttribute("msg", "Atividade atualizada com sucesso!");
                }else{
                    request.setAttribute("msg", "A soma da quantidade de vagas internas com as vagas externas devem ser igual a quantidade de vagas!");
                }
            }catch(IllegalAccessException e){
                request.setAttribute("msg", e.getMessage());
            }catch(NumberFormatException e){
                request.setAttribute("msg", "Nos campos onde se pede um número deve ser digitado um número!");
            }catch(IllegalArgumentException e){
                request.setAttribute("msg", e.getMessage());
            }catch(NullPointerException e){
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
                <h3 class="box-title"><%=(request.getAttribute("msg") != null) ? request.getAttribute("msg") : "Atualize a atividade" %></h3>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
            <form action="" method="post">
              <div class="box-body">
                <div class="form-group">
                  <label for="nome">Atividade</label>
                  <input type="text" class="form-control" id="nome" placeholder="Nome da atividade" name="nome" value="<%=(atividade.getNome() != null) ? atividade.getNome() : (request.getParameter("nome") != null) ? request.getParameter("nome") : ""%>">
                </div>
                <div class="box-body pad form-group">
                    <label>Descrição</label>
                    <textarea class="textarea" name="descricao" placeholder="Descrição para a atividade" style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;" value="<%=(atividade.getDescricao()!= null) ? atividade.getDescricao() : (request.getParameter("descricao") != null) ? request.getParameter("descricao") : ""%>"><%=(atividade.getDescricao()!= null) ? atividade.getDescricao(): (request.getParameter("descricao") != null) ? request.getParameter("descricao") : ""%></textarea>
                </div>
                <div class="form-group">
                <label>Categoria</label>
                    <select class="form-control select2" style="width: 100%;" name="categoria">
                        <option <%=(atividade.getCategoria() == null || atividade.getCategoria().isEmpty()) ? "selected='selected'" : "" %> value="">Selecione uma categoria</option>
                        <optgroup label="ATIVIDADES SOCIAIS">
                            <option value="Almoço banquete" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Almoço banquete")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Almoço banquete")) ? "selected='selected'" : "" %> >Almoço banquete</option>
                            <option value="Brunch" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Brunch")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Brunch")) ? "selected='selected'" : "" %>>Brunch</option>
                            <option value="Café da manhã" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Café da manhã")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Café da manhã")) ? "selected='selected'" : "" %>>Café da manhã</option>
                            <option value="Chás" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Chás")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Chás")) ? "selected='selected'" : "" %>>Chás</option>
                            <option value="Coquetel" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Coquetel")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Coquetel")) ? "selected='selected'" : "" %>>Coquetel</option>
                            <option value="Festas ao ar livre" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Festas ao ar livre")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Festas ao ar livre")) ? "selected='selected'" : "" %>>Festas ao ar livre</option>
                            <option value="Festas beneficentes" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Festas beneficentes")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Festas beneficentes")) ? "selected='selected'" : "" %>>Festas beneficentes</option>
                            <option value="Festa de debutante" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Festa de debutante")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Festa de debutante")) ? "selected='selected'" : "" %>>Festa de debutante</option>
                            <option value="Jantar banquete" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Jantar banquete")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Jantar banquete")) ? "selected='selected'" : "" %>>Jantar banquete</option>
                            <option value="Noivados" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Noivados")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Noivados")) ? "selected='selected'" : "" %>>Noivados</option>
                            <option value="Open House" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Open House")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Open House")) ? "selected='selected'" : "" %>>Open House</option>
                        </optgroup>
                        <optgroup label="ATIVIDADES PROFISSIONAIS">
                            <option value="Coffe break" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Coffe break")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Coffe break")) ? "selected='selected'" : "" %>>Coffe break</option>
                            <option value="Colóquio" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Colóquio")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Colóquio")) ? "selected='selected'" : "" %>>Colóquio</option>
                            <option value="Condecorações" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Condecorações")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Condecorações")) ? "selected='selected'" : "" %>>Condecorações</option>
                            <option value="Desfiles" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Desfiles")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Desfiles")) ? "selected='selected'" : "" %>>Desfiles</option>
                            <option value="Leilões" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Leilões")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Leilões")) ? "selected='selected'" : "" %>>Leilões</option>
                            <option value="Visitas institucionais" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Visitas institucionais")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Visitas institucionais")) ? "selected='selected'" : "" %>>Visitas institucionais</option>
                        </optgroup>
                        <optgroup label="ATIVIDADES OFICIAIS">
                            <option value="Assinaturas" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Assinaturas")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Assinaturas")) ? "selected='selected'" : "" %>>Assinaturas</option>
                            <option value="Homenagens e premiações" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Homenagens e premiações")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Homenagens e premiações")) ? "selected='selected'" : "" %>>Homenagens e premiações</option>
                            <option value="Inaugurações" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Inaugurações")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Inaugurações")) ? "selected='selected'" : "" %>>Inaugurações</option>
                            <option value="Posses" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Posses")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Posses")) ? "selected='selected'" : "" %>>Posses</option>
                        </optgroup>
                        <optgroup label="ATIVIDADES TÉCNICO-CIENTÍFICOS">
                            <option value="Ciclo de palestras" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Ciclo de palestras")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Ciclo de palestras")) ? "selected='selected'" : "" %>>Ciclo de palestras</option>
                            <option value="Conferências" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Conferências")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Conferências")) ? "selected='selected'" : "" %>>Conferências</option>
                            <option value="Congressos" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Congressos")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Congressos")) ? "selected='selected'" : "" %>>Congressos</option>
                            <option value="Convenção" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Convenção")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Convenção")) ? "selected='selected'" : "" %>>Convenção</option>
                            <option value="Feira" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Feira")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Feira")) ? "selected='selected'" : "" %>>Feira</option>
                            <option value="Fórum" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Fórum")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Fórum")) ? "selected='selected'" : "" %>>Fórum</option>
                            <option value="Mesa redonda" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Mesa redonda")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Mesa redonda")) ? "selected='selected'" : "" %>>Mesa redonda</option>
                            <option value="Painel" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Painel")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Painel")) ? "selected='selected'" : "" %>>Painel</option>
                            <option value="Reunião" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Reunião")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Reunião")) ? "selected='selected'" : "" %>>Reunião</option>
                            <option value="Semana" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Semana")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Semana")) ? "selected='selected'" : "" %>>Semana</option>
                            <option value="Seminário" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Seminário")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Seminário")) ? "selected='selected'" : "" %>>Seminário</option>
                            <option value="Simpósio" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Simpósio")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Simpósio")) ? "selected='selected'" : "" %>>Simpósio</option>
                            <option value="Workshop" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Workshop")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Workshop")) ? "selected='selected'" : "" %>>Workshop</option>
                        </optgroup>
                        <optgroup label="ATIVIDADES ARTÍSTICOS">
                            <option value="Exposição" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Exposição")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Exposição")) ? "selected='selected'" : "" %>>Exposição</option>
                            <option value="Mostra" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Mostra")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Mostra")) ? "selected='selected'" : "" %>>Mostra</option>
                            <option value="Vernissages" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Vernissages")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Vernissages")) ? "selected='selected'" : "" %>>Vernissages</option>
                        </optgroup>
                        <optgroup label="ATIVIDADES CULTURAIS">
                            <option value="Concursos" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Concursos")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Concursos")) ? "selected='selected'" : "" %>>Concursos</option>
                            <option value="Entrevista coletiva" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Entrevista coletiva")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Entrevista coletiva")) ? "selected='selected'" : "" %>>Entrevista coletiva</option>
                            <option value="Formaturas" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Formaturas")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Formaturas")) ? "selected='selected'" : "" %>>Formaturas</option>
                            <option value="Tarde de autógrafos" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Tarde de autógrafos")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Tarde de autógrafos")) ? "selected='selected'" : "" %>>Tarde de autógrafos</option>
                            <option value="Torneio" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Torneio")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Torneio")) ? "selected='selected'" : "" %>>Torneio</option>
                        </optgroup>
                        <optgroup label="ATIVIDADES RELIGIOSOS">
                            <option value="Bar e bat-mitzva" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Bar e bat-mitzva")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Bar e bat-mitzva")) ? "selected='selected'" : "" %>>Bar e bat-mitzva</option>
                            <option value="Batizados" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Batizados")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Batizados")) ? "selected='selected'" : "" %>>Batizados</option>
                            <option value="Brit-miláh" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Brit-miláh")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Brit-miláh")) ? "selected='selected'" : "" %>>Brit-miláh</option>
                            <option value="Casamentos" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Casamentos")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Casamentos")) ? "selected='selected'" : "" %>>Casamentos</option>
                            <option value="Conclaves" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Conclaves")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Conclaves")) ? "selected='selected'" : "" %>>Conclaves</option>
                            <option value="Primeira comunhão" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Primeira comunhão")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Primeira comunhão")) ? "selected='selected'" : "" %>>Primeira comunhão</option>
                        </optgroup>
                    </select>
                </div>
                <div class="form-group">
                <label>Ministrante</label>
                    <select class="form-control select2" style="width: 100%;" name="ministrante">
                        <option value="">Selecione um ministrante</option>
                        <%
                            for(int i=0;i<usuarios.size();i++){
                                UsuarioBeans u = usuarios.get(i);
                        %>
                        <option  value="<%=u.getCodUsuario() %>" <%=(atividade.getMinistrante() != null && u.getCodUsuario() == atividade.getMinistrante().getCodUsuario()) ? "selected='selected'" : "" %>><%=u.getNome()+" - "+u.getCpf().getSecretCpf() %></option>
                        <%}%>
                    </select>
                </div>
                <div class="form-group">
                  <label for="qtdVagas">Vagas</label>
                  <input type="number" class="form-control" id="qtdVagas" placeholder="Quantidade de vagas da atividade" name="qtdVagas" value="<%=(request.getParameter("qtdVagas") != null) ? request.getParameter("qtdVagas") : atividade.getLimiteVagas() %>">
                </div>
                <div class="form-group">
                  <label for="qtdVagasInternas">Vagas internas</label>
                  <input type="number" class="form-control" id="qtdVagasInternas" placeholder="Quantidade de vagas internas da atividade" name="qtdVagasInternas" value="<%=(request.getParameter("qtdVagasInternas") != null) ? request.getParameter("qtdVagasInternas") : atividade.getVagasInternas() %>">
                </div>
                <div class="form-group">
                  <label for="qtdVagasExternas">Vagas externas</label>
                  <input type="number" class="form-control" id="qtdVagasExternas" placeholder="Quantidade de vagas externas da atividade" name="qtdVagasExternas" value="<%=(request.getParameter("qtdVagasExternas") != null) ? request.getParameter("qtdVagasExternas") : atividade.getVagasPublicas() %>">
                </div>
                <div class="form-group">
                <label>Nível de conhecimento na área</label>
                    <select class="form-control select2" style="width: 100%;" name="nivel">
                        <option <%=(atividade.getNivel() == 0) ? "selected='selected'" : "" %> value="0">Nenhum nível</option>
                        <option <%=(atividade.getNivel() == 1) ? "selected='selected'" : "" %> value="1">Básico</option>
                        <option <%=(atividade.getNivel() == 2) ? "selected='selected'" : "" %> value="2">Médio</option>
                        <option <%=(atividade.getNivel() == 3) ? "selected='selected'" : "" %> value="3">Avançado</option>
                    </select>
                </div>
                <div class="form-group">
                <label>Tipo de pagamento</label>
                    <select class="form-control select2" style="width: 100%;" name="tipoPagamento">
                        <option <%=(atividade.getTipoPagamento() == 0) ? "selected='selected'" : "" %> value="1">Nenhum pagamento</option>
                        <option <%=(atividade.getTipoPagamento() == 1) ? "selected='selected'" : "" %> value="2">Dinheiro</option>
                        <option <%=(atividade.getTipoPagamento() == 2) ? "selected='selected'" : "" %> value="3">Alimento não perecível</option>
                    </select>
                </div> 
                <!-- Date and time range -->
              <!-- /.form group -->  
              </div>
              <!-- /.box-body -->

              <div class="box-footer">
                <button type="submit" class="btn btn-primary" name="atualiza" value="atividade">Cadastrar atividade</button>
              </div>
            </form>
          </div>
          <!-- /.box -->
        </div>
      </div>
    </section>