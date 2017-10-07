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
        <small>formulário</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="/Artemis/admin/"><i class="fa fa-dashboard"></i> Inicio</a></li>
        <li class="active">Atualizar atividade</li>
      </ol>
    </section>
    <%
        String dir = config.getServletContext().getInitParameter("dir");
        Facade facade = new Facade((UsuarioBeans) session.getAttribute("usuario"));
        List<UsuarioBeans> usuarios = facade.getUsuarios();
        AtividadeBeans atividade = null;
        EventoBeans vinculado = null;
        InstituicaoBeans insAtividade = null;
        try{
            atividade = facade.getAtividade(facade.getCodFromParameter(request.getParameter("a")));
            vinculado = facade.getEventoVinculado(atividade);
            insAtividade = facade.getInstituicao(atividade);
            if(!atividade.getAdministradores().contains((UsuarioBeans) session.getAttribute("usuario"))){
                response.sendRedirect("/"+dir+"/404");
            }
        }catch(NumberFormatException e){
            response.sendRedirect("/"+dir+"/404");
        }catch(NullPointerException e){
            response.sendRedirect("/"+dir+"/404");            
        }
        
        if(request.getParameter("atualiza") != null){
            try{
                if(request.getParameter("instituicao") != null && !request.getParameter("instituicao").isEmpty()){
                    atividade.setNome(request.getParameter("nome"));
                    atividade.setDescricao(request.getParameter("descricao"));
                    atividade.setCategoria(request.getParameter("categoria"));
                    atividade.setTemCertificado((request.getParameter("temCertificado") != null && request.getParameter("temCertificado").equals("1")));
                    if((Integer.parseInt(request.getParameter("qtdVagasInternas")) + Integer.parseInt(request.getParameter("qtdVagasExternas"))) == Integer.parseInt(request.getParameter("qtdVagas"))){
                        atividade.setLimiteVagas(Integer.parseInt(request.getParameter("qtdVagas")));
                        atividade.setVagasInternas(Integer.parseInt(request.getParameter("qtdVagasInternas")));
                        atividade.setVagasPublicas(Integer.parseInt(request.getParameter("qtdVagasExternas")));
                        atividade.setNivel(Integer.parseInt(request.getParameter("nivel")));
                        atividade.setTipoPagamento(Integer.parseInt(request.getParameter("tipoPagamento")));
                        if(request.getParameter("ministrante") != null || !request.getParameter("ministrante").isEmpty()){
                            atividade.setMinistrante(facade.getUsuario(Long.parseLong(request.getParameter("ministrante"))));
                            facade.adicionaNivelUsuario(facade.getUsuario(Long.parseLong(request.getParameter("ministrante"))), "ministrante");
                        }
                        InstituicaoBeans instituicao = facade.getInstituicao(Long.parseLong(request.getParameter("instituicao")));
                        if(instituicao.getCodInstituicao()!=insAtividade.getCodInstituicao()){
                            instituicao.getAtividades().add(atividade);
                            facade.atualizaInstituicao(instituicao);
                            insAtividade.getAtividades().remove(atividade);
                            facade.atualizaInstituicao(insAtividade);
                        }
                        facade.atualizaAtividade(atividade);
                        
                        request.setAttribute("msg", "Atividade atualizada com sucesso!");
                    }else{
                        request.setAttribute("msg", "A soma da quantidade de vagas internas com as vagas externas devem ser igual a quantidade de vagas!");
                    }
                }else{
                    request.setAttribute("msg", "Deve ser selecionado uma instituição! "
                            + "(Caso não haja uma instituição para selecionar, contactar"
                            + " o administrador do sistema para ele adicionar uma instituição)");                  
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
                  <input type="text" class="form-control" id="nome" placeholder="Nome da atividade" name="nome" value="<%=(request.getParameter("nome") != null) ? request.getParameter("nome") : (atividade.getNome() !=null) ? atividade.getNome() : "" %>">
                </div>
                <div class="box-body pad form-group">
                    <label>Descrição</label>
                    <textarea class="textarea" name="descricao" placeholder="Descrição para a atividade" style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;" value="<%=(request.getParameter("descricao") != null) ? request.getParameter("descricao") : (atividade.getDescricao()!=null) ? atividade.getDescricao() : "" %>"><%=(request.getParameter("descricao") != null) ? request.getParameter("descricao") : (atividade.getDescricao()!=null) ? atividade.getDescricao() : ""%></textarea>
                </div>
                <div class="form-group">
                <label>Categoria</label>
                    <select class="form-control select2" style="width: 100%;" name="categoria">
                        <option selected="selected" value="">Selecione uma categoria</option>
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
                <label>Ministrante</label>
                    <select class="form-control select2" style="width: 100%;" name="ministrante">
                        <option selected="selected" value="">Selecione uma ministrante</option>
                        <%
                            for(UsuarioBeans u : usuarios){
                        %>
                        <option  value="<%=u.getCodUsuario() %>"  <%=(atividade.getMinistrante() != null && atividade.getMinistrante().getCodUsuario()==u.getCodUsuario()) ? "selected=\'selected\'" : (request.getParameter("ministrante") !=null && request.getParameter("ministrante").equals(u.getCodUsuario()+"")) ? "selected=\'selected\'" : "" %>><%=u.getNome()+" - "+u.getCpf().getSecretCpf() %></option>
                        <%}%>
                    </select>
                </div>
               <div class="form-group">
                <label>Instituição</label>
                    <%
                        if(vinculado !=null){
                            InstituicaoBeans instituicao = facade.getInstituicao(vinculado);
                        
                    %>
                    <input type="hidden" name="instituicao" value="<%=instituicao.getCodInstituicao() %>">
                    <input type="text" class="form-control" id="nomeDaInstituicao" placeholder="Nome da instituição" name="nomeDaInstituicao" value="<%=instituicao.getNome() %>" disabled="disabled"/>
                    <%
                        }else{
                    %>
                    <select class="form-control select2" style="width: 100%;" name="instituicao">
                        <option value="" >Selecione uma instituição</option>
                        <%
                            List<InstituicaoBeans> instituicoes = facade.getInstituicoes();
                            for(int i=0;i<instituicoes.size();i++){
                               InstituicaoBeans instituicao = instituicoes.get(i);
                            
                        %>
                        <option  value="<%=instituicao.getCodInstituicao() %>" <%=(request.getParameter("instituicao") != null && request.getParameter("instituicao").equals(""+instituicao.getCodInstituicao())) ? "selected=\'selected\'" : (insAtividade.getCodInstituicao() == instituicao.getCodInstituicao()) ? "selected=\'selected\'" : "" %>><%=instituicao.getNome() %></option>
                        <%  }%>
                    </select>
                    <%  }%>
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
                        <option value="1" <%=(request.getParameter("nivel") != null && request.getParameter("nivel").equals("1")) ? "selected=\'selected\'" : (atividade.getNivel()== 1) ? "selected=\'selected\'" : "" %> >Básico</option>
                        <option value="2" <%=(request.getParameter("nivel") != null && request.getParameter("nivel").equals("2")) ? "selected=\'selected\'" : (atividade.getNivel()== 2) ? "selected=\'selected\'" : "" %>>Médio</option>
                        <option value="3" <%=(request.getParameter("nivel") != null && request.getParameter("nivel").equals("3")) ? "selected=\'selected\'" : (atividade.getNivel()== 1) ? "selected=\'selected\'" : "" %>>Avançado</option>
                    </select>
                </div>
                <div class="form-group">
                <label>Tipo de pagamento</label>
                    <select class="form-control select2" style="width: 100%;" name="tipoPagamento">
                        <option  value="1" <%=(request.getParameter("tipoPagamento") != null && request.getParameter("tipoPagamento").equals("1")) ? "selected=\'selected\'" : (atividade.getTipoPagamento() == 1) ? "selected=\'selected\'" : "" %> >Nenhum pagamento</option>
                        <option  value="2" <%=(request.getParameter("tipoPagamento") != null && request.getParameter("tipoPagamento").equals("2")) ? "selected=\'selected\'" : (atividade.getTipoPagamento() == 2) ? "selected=\'selected\'" : "" %> >Dinheiro</option>
                        <option  value="3" <%=(request.getParameter("tipoPagamento") != null && request.getParameter("tipoPagamento").equals("3")) ? "selected=\'selected\'" : (atividade.getTipoPagamento() == 3) ? "selected=\'selected\'" : "" %>>Alimento não perecível</option>
                    </select>
                </div>
                <label>Tem certificado?</label>
                    <select class="form-control select2" style="width: 100%;" name="temCertificado">
                        <option value="1" <%=(request.getParameter("temCertificado") != null && request.getParameter("temCertificado").equals("1")) ? "selected=\'selected\'" : (atividade.isTemCertificado()) ? "selected=\'selected\'" : "" %>>Sim</option>
                        <option value="0" <%=(request.getParameter("temCertificado") != null && request.getParameter("temCertificado").equals("0")) ? "selected=\'selected\'" : (!atividade.isTemCertificado()) ? "selected=\'selected\'" : "" %>>Não</option>
                    </select>
                </div>
                <!-- Date and time range -->
                
              <!-- /.form group -->  
              </div>
              <!-- /.box-body -->

              <div class="box-footer">
                <button type="submit" class="btn btn-primary" name="atualiza" value="atividade">Atualizar atividade</button>
              </div>
            </form>
          </div>
          <!-- /.box -->
        </div>
      </div>
    </section>