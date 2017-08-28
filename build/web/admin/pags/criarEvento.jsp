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
        CADASTRAR EVENTO
        <small>formul�rio</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="/Artemis/admin/"><i class="fa fa-dashboard"></i> Inicio</a></li>
        <li class="active">Cadastrar evento</li>
      </ol>
    </section>
    <%
        if(request.getParameter("cadastro") != null){
            try{
                EventoBeans evento = new EventoBeans();
                evento.setNome(request.getParameter("nome"));
                evento.setDescricao(request.getParameter("descricao"));
                evento.setCategoria(request.getParameter("categoria"));
                evento.setEmail(request.getParameter("email"));
                LocalizacaoBeans lb = new LocalizacaoBeans(request.getParameter("localizacao"), Float.parseFloat(request.getParameter("lat")), Float.parseFloat(request.getParameter("lng")));
                evento.setLocalizacao(lb);
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
                evento.setPeriodos(periodos);
                Facade facade = new Facade((UsuarioBeans) session.getAttribute("usuario"));
                evento =  facade.cadastraEvento(evento);
                evento.setAdministradores(new ArrayList<UsuarioBeans>());
                evento.getAdministradores().add((UsuarioBeans)session.getAttribute("usuario"));
                facade.atualizaEvento(evento);
                request.setAttribute("msg", "Evento cadastrado com sucesso!");
            }catch(IllegalAccessException e){
                request.setAttribute("msg", e.getMessage());
            }catch(NumberFormatException e){
                request.setAttribute("msg", e.getMessage());
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
                    <label>Descri��o</label>
                    <textarea class="textarea" name="descricao" placeholder="Descri��o para o evento" style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;" value="<%=(request.getParameter("descricao") != null) ? request.getParameter("descricao") : ""%>"><%=(request.getParameter("descricao") != null) ? request.getParameter("descricao") : ""%></textarea>
                </div>
                <div class="form-group">
                  <label for="nome">E-mail</label>
                  <input type="text" class="form-control" id="nome" placeholder="E-mail para contato" name="email" value="<%=(request.getParameter("email") != null) ? request.getParameter("email") : ""%>">
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
                  <label for="localizacao">Localiza��o</label>
                  <input type="text" class="form-control" id="localizacao" placeholder="Localiza��o do evento"  name="localizacao" value="Russas - CE, Brasil">
                  <input type="hidden" class="form-control" id="lat" placeholder="Nome do evento" name="lat" value="-4.9271161">
                  <input type="hidden" class="form-control" id="lng" placeholder="Nome do evento" name="lng" value="-37.97242589999996">
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
                <button type="submit" class="btn btn-primary" name="cadastro" value="evento">Cadastrar evento</button>
              </div>
            </form>
          </div>
          <!-- /.box -->
        </div>
      </div>
    </section>