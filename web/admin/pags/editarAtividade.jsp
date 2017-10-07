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
                    <label>Descri��o</label>
                    <textarea class="textarea" name="descricao" placeholder="Descri��o para a atividade" style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;" value="<%=(request.getParameter("descricao") != null) ? request.getParameter("descricao") : (atividade.getDescricao()!=null) ? atividade.getDescricao() : "" %>"><%=(request.getParameter("descricao") != null) ? request.getParameter("descricao") : (atividade.getDescricao()!=null) ? atividade.getDescricao() : ""%></textarea>
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
                            for(UsuarioBeans u : usuarios){
                        %>
                        <option  value="<%=u.getCodUsuario() %>"  <%=(atividade.getMinistrante() != null && atividade.getMinistrante().getCodUsuario()==u.getCodUsuario()) ? "selected=\'selected\'" : (request.getParameter("ministrante") !=null && request.getParameter("ministrante").equals(u.getCodUsuario()+"")) ? "selected=\'selected\'" : "" %>><%=u.getNome()+" - "+u.getCpf().getSecretCpf() %></option>
                        <%}%>
                    </select>
                </div>
               <div class="form-group">
                <label>Institui��o</label>
                    <%
                        if(vinculado !=null){
                            InstituicaoBeans instituicao = facade.getInstituicao(vinculado);
                        
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
                <label>N�vel de conhecimento na �rea</label>
                    <select class="form-control select2" style="width: 100%;" name="nivel">
                        <option value="1" <%=(request.getParameter("nivel") != null && request.getParameter("nivel").equals("1")) ? "selected=\'selected\'" : (atividade.getNivel()== 1) ? "selected=\'selected\'" : "" %> >B�sico</option>
                        <option value="2" <%=(request.getParameter("nivel") != null && request.getParameter("nivel").equals("2")) ? "selected=\'selected\'" : (atividade.getNivel()== 2) ? "selected=\'selected\'" : "" %>>M�dio</option>
                        <option value="3" <%=(request.getParameter("nivel") != null && request.getParameter("nivel").equals("3")) ? "selected=\'selected\'" : (atividade.getNivel()== 1) ? "selected=\'selected\'" : "" %>>Avan�ado</option>
                    </select>
                </div>
                <div class="form-group">
                <label>Tipo de pagamento</label>
                    <select class="form-control select2" style="width: 100%;" name="tipoPagamento">
                        <option  value="1" <%=(request.getParameter("tipoPagamento") != null && request.getParameter("tipoPagamento").equals("1")) ? "selected=\'selected\'" : (atividade.getTipoPagamento() == 1) ? "selected=\'selected\'" : "" %> >Nenhum pagamento</option>
                        <option  value="2" <%=(request.getParameter("tipoPagamento") != null && request.getParameter("tipoPagamento").equals("2")) ? "selected=\'selected\'" : (atividade.getTipoPagamento() == 2) ? "selected=\'selected\'" : "" %> >Dinheiro</option>
                        <option  value="3" <%=(request.getParameter("tipoPagamento") != null && request.getParameter("tipoPagamento").equals("3")) ? "selected=\'selected\'" : (atividade.getTipoPagamento() == 3) ? "selected=\'selected\'" : "" %>>Alimento n�o perec�vel</option>
                    </select>
                </div>
                <label>Tem certificado?</label>
                    <select class="form-control select2" style="width: 100%;" name="temCertificado">
                        <option value="1" <%=(request.getParameter("temCertificado") != null && request.getParameter("temCertificado").equals("1")) ? "selected=\'selected\'" : (atividade.isTemCertificado()) ? "selected=\'selected\'" : "" %>>Sim</option>
                        <option value="0" <%=(request.getParameter("temCertificado") != null && request.getParameter("temCertificado").equals("0")) ? "selected=\'selected\'" : (!atividade.isTemCertificado()) ? "selected=\'selected\'" : "" %>>N�o</option>
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