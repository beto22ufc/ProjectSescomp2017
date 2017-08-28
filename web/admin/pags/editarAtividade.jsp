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
                request.setAttribute("msg", "Nos campos onde se pede um n�mero deve ser digitado um n�mero!");
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
                    <label>Descri��o</label>
                    <textarea class="textarea" name="descricao" placeholder="Descri��o para a atividade" style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;" value="<%=(atividade.getDescricao()!= null) ? atividade.getDescricao() : (request.getParameter("descricao") != null) ? request.getParameter("descricao") : ""%>"><%=(atividade.getDescricao()!= null) ? atividade.getDescricao(): (request.getParameter("descricao") != null) ? request.getParameter("descricao") : ""%></textarea>
                </div>
                <div class="form-group">
                <label>Categoria</label>
                    <select class="form-control select2" style="width: 100%;" name="categoria">
                        <option <%=(atividade.getCategoria() == null || atividade.getCategoria().isEmpty()) ? "selected='selected'" : "" %> value="">Selecione uma categoria</option>
                        <optgroup label="ATIVIDADES SOCIAIS">
                            <option value="Almo�o banquete" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Almo�o banquete")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Almo�o banquete")) ? "selected='selected'" : "" %> >Almo�o banquete</option>
                            <option value="Brunch" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Brunch")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Brunch")) ? "selected='selected'" : "" %>>Brunch</option>
                            <option value="Caf� da manh�" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Caf� da manh�")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Caf� da manh�")) ? "selected='selected'" : "" %>>Caf� da manh�</option>
                            <option value="Ch�s" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Ch�s")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Ch�s")) ? "selected='selected'" : "" %>>Ch�s</option>
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
                            <option value="Col�quio" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Col�quio")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Col�quio")) ? "selected='selected'" : "" %>>Col�quio</option>
                            <option value="Condecora��es" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Condecora��es")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Condecora��es")) ? "selected='selected'" : "" %>>Condecora��es</option>
                            <option value="Desfiles" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Desfiles")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Desfiles")) ? "selected='selected'" : "" %>>Desfiles</option>
                            <option value="Leil�es" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Leil�es")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Leil�es")) ? "selected='selected'" : "" %>>Leil�es</option>
                            <option value="Visitas institucionais" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Visitas institucionais")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Visitas institucionais")) ? "selected='selected'" : "" %>>Visitas institucionais</option>
                        </optgroup>
                        <optgroup label="ATIVIDADES OFICIAIS">
                            <option value="Assinaturas" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Assinaturas")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Assinaturas")) ? "selected='selected'" : "" %>>Assinaturas</option>
                            <option value="Homenagens e premia��es" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Homenagens e premia��es")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Homenagens e premia��es")) ? "selected='selected'" : "" %>>Homenagens e premia��es</option>
                            <option value="Inaugura��es" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Inaugura��es")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Inaugura��es")) ? "selected='selected'" : "" %>>Inaugura��es</option>
                            <option value="Posses" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Posses")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Posses")) ? "selected='selected'" : "" %>>Posses</option>
                        </optgroup>
                        <optgroup label="ATIVIDADES T�CNICO-CIENT�FICOS">
                            <option value="Ciclo de palestras" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Ciclo de palestras")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Ciclo de palestras")) ? "selected='selected'" : "" %>>Ciclo de palestras</option>
                            <option value="Confer�ncias" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Confer�ncias")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Confer�ncias")) ? "selected='selected'" : "" %>>Confer�ncias</option>
                            <option value="Congressos" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Congressos")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Congressos")) ? "selected='selected'" : "" %>>Congressos</option>
                            <option value="Conven��o" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Conven��o")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Conven��o")) ? "selected='selected'" : "" %>>Conven��o</option>
                            <option value="Feira" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Feira")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Feira")) ? "selected='selected'" : "" %>>Feira</option>
                            <option value="F�rum" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("F�rum")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("F�rum")) ? "selected='selected'" : "" %>>F�rum</option>
                            <option value="Mesa redonda" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Mesa redonda")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Mesa redonda")) ? "selected='selected'" : "" %>>Mesa redonda</option>
                            <option value="Painel" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Painel")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Painel")) ? "selected='selected'" : "" %>>Painel</option>
                            <option value="Reuni�o" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Reuni�o")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Reuni�o")) ? "selected='selected'" : "" %>>Reuni�o</option>
                            <option value="Semana" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Semana")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Semana")) ? "selected='selected'" : "" %>>Semana</option>
                            <option value="Semin�rio" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Semin�rio")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Semin�rio")) ? "selected='selected'" : "" %>>Semin�rio</option>
                            <option value="Simp�sio" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Simp�sio")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Simp�sio")) ? "selected='selected'" : "" %>>Simp�sio</option>
                            <option value="Workshop" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Workshop")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Workshop")) ? "selected='selected'" : "" %>>Workshop</option>
                        </optgroup>
                        <optgroup label="ATIVIDADES ART�STICOS">
                            <option value="Exposi��o" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Exposi��o")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Exposi��o")) ? "selected='selected'" : "" %>>Exposi��o</option>
                            <option value="Mostra" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Mostra")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Mostra")) ? "selected='selected'" : "" %>>Mostra</option>
                            <option value="Vernissages" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Vernissages")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Vernissages")) ? "selected='selected'" : "" %>>Vernissages</option>
                        </optgroup>
                        <optgroup label="ATIVIDADES CULTURAIS">
                            <option value="Concursos" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Concursos")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Concursos")) ? "selected='selected'" : "" %>>Concursos</option>
                            <option value="Entrevista coletiva" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Entrevista coletiva")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Entrevista coletiva")) ? "selected='selected'" : "" %>>Entrevista coletiva</option>
                            <option value="Formaturas" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Formaturas")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Formaturas")) ? "selected='selected'" : "" %>>Formaturas</option>
                            <option value="Tarde de aut�grafos" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Tarde de aut�grafos")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Tarde de aut�grafos")) ? "selected='selected'" : "" %>>Tarde de aut�grafos</option>
                            <option value="Torneio" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Torneio")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Torneio")) ? "selected='selected'" : "" %>>Torneio</option>
                        </optgroup>
                        <optgroup label="ATIVIDADES RELIGIOSOS">
                            <option value="Bar e bat-mitzva" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Bar e bat-mitzva")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Bar e bat-mitzva")) ? "selected='selected'" : "" %>>Bar e bat-mitzva</option>
                            <option value="Batizados" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Batizados")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Batizados")) ? "selected='selected'" : "" %>>Batizados</option>
                            <option value="Brit-mil�h" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Brit-mil�h")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Brit-mil�h")) ? "selected='selected'" : "" %>>Brit-mil�h</option>
                            <option value="Casamentos" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Casamentos")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Casamentos")) ? "selected='selected'" : "" %>>Casamentos</option>
                            <option value="Conclaves" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Conclaves")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Conclaves")) ? "selected='selected'" : "" %>>Conclaves</option>
                            <option value="Primeira comunh�o" <%=(atividade.getCategoria() != null && atividade.getCategoria().equals("Primeira comunh�o")) ? "selected='selected'" : (request.getParameter("categoria") != null && request.getParameter("categoria").equals("Primeira comunh�o")) ? "selected='selected'" : "" %>>Primeira comunh�o</option>
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
                <label>N�vel de conhecimento na �rea</label>
                    <select class="form-control select2" style="width: 100%;" name="nivel">
                        <option <%=(atividade.getNivel() == 0) ? "selected='selected'" : "" %> value="0">Nenhum n�vel</option>
                        <option <%=(atividade.getNivel() == 1) ? "selected='selected'" : "" %> value="1">B�sico</option>
                        <option <%=(atividade.getNivel() == 2) ? "selected='selected'" : "" %> value="2">M�dio</option>
                        <option <%=(atividade.getNivel() == 3) ? "selected='selected'" : "" %> value="3">Avan�ado</option>
                    </select>
                </div>
                <div class="form-group">
                <label>Tipo de pagamento</label>
                    <select class="form-control select2" style="width: 100%;" name="tipoPagamento">
                        <option <%=(atividade.getTipoPagamento() == 0) ? "selected='selected'" : "" %> value="1">Nenhum pagamento</option>
                        <option <%=(atividade.getTipoPagamento() == 1) ? "selected='selected'" : "" %> value="2">Dinheiro</option>
                        <option <%=(atividade.getTipoPagamento() == 2) ? "selected='selected'" : "" %> value="3">Alimento n�o perec�vel</option>
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