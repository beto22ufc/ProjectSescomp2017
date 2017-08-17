<%-- 
    Document   : dadosUsuario
    Created on : 02/08/2017, 11:29:51
    Author     : Wallison
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Collections"%>
<%@page import="artemis.beans.CursoBeans"%>
<%@page import="artemis.beans.InstituicaoBeans"%>
<%@page import="artemis.model.Instituicao"%>
<%@page import="java.util.List"%>
<%@page import="artemis.model.Facade"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="artemis.model.CPF"%>
<%@page import="artemis.beans.UsuarioBeans"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Facade facade = new Facade();
    
    UsuarioBeans u = (UsuarioBeans) session.getAttribute("usuario");
    InstituicaoBeans atual = null;
    List<InstituicaoBeans> insts = facade.getInstituicoes();
    boolean parar = false; 
    for(int i=0;i<insts.size();i++){
        InstituicaoBeans ins = insts.get(i);
        for(int j=0;j<ins.getAssociados().size();j++){
            UsuarioBeans ub = ins.getAssociados().get(i);
            if(ub.getEmail().equals(u.getEmail())){
                atual = ins;
                parar = true;
                break;
            }
        }
        if(parar){
            break;
        }
    }
    if(request.getParameter("atualiza") != null){
        String opc = request.getParameter("atualiza");
        if(opc.equals("geral")){
            try{
                u.setNome(request.getParameter("nomeUsuario"));
                u.setCpf(new CPF(request.getParameter("cpf")));
                u.setOcupacao(request.getParameter("ocupacao"));
                u.setFormacao(request.getParameter("formacao"));
                u.setLattes(request.getParameter("lattes"));
                DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                u.setNascimento(LocalDate.parse(request.getParameter("nascimento"), dtf));
                facade.atualizaUsuarioGeral(u);
                session.setAttribute("usuario", u);
                request.setAttribute("msgGeral", "Dados atualizados com sucesso!");
            }catch(IllegalArgumentException e){
                request.setAttribute("msgGeral", e.getMessage());
            }catch(NullPointerException e){
                request.setAttribute("msgGeral", e.getMessage());
            }
        }else if(opc.equals("senha")){
            try{
                if(request.getParameter("novaSenha").equals(request.getParameter("confirmeNovaSenha"))){
                    u = facade.atualizaUsuarioSenha(u, request.getParameter("senhaAtual"), request.getParameter("novaSenha"));
                    session.setAttribute("usuario", u);
                    request.setAttribute("msgSenha", "Senha atualizada com sucesso!"); 
                }else{
                   request.setAttribute("msgSenha", "Senha de confirmação não bate com nova senha!"); 
                }
            }catch(IllegalArgumentException e){
                request.setAttribute("msgSenha", e.getMessage());
            }catch(NullPointerException e){
                request.setAttribute("msgSenha", e.getMessage());
            }catch(Exception e){
                request.setAttribute("msgSenha", e.getMessage());
            }
        }else if(opc.equals("email")){
            try{
                if(request.getParameter("novoEmail").equals(request.getParameter("confirmeNovoEmail"))){
                    facade.atualizaUsuarioEmail(u, request.getParameter("emailAtual"),request.getParameter("novoEmail"));
                    request.setAttribute("msgEmail", "E-mail atualizado com sucesso!");
                    session.removeAttribute("usuario");
                }else{
                   request.setAttribute("msgEmail", "E-mail de confirmação não bate com o novo e-mail!"); 
                }
            }catch(IllegalArgumentException e){
                request.setAttribute("msgEmail", e.getMessage());
            }catch(NullPointerException e){
                request.setAttribute("msgEmail", e.getMessage());
            }catch(Exception e){
                request.setAttribute("msgEmail", e.getMessage());
            }
        }else if(opc.equals("instituicao")){
            try{
                if(request.getParameter("nomeInstituicao") != null){
                    InstituicaoBeans instituicao = new InstituicaoBeans();
                    instituicao.setNome(request.getParameter("nomeInstituicao"));
                    instituicao.setAssociados(Collections.synchronizedList(new ArrayList<UsuarioBeans>()));
                    instituicao.getAssociados().add(u);
                }else{
                    InstituicaoBeans instituicao = facade.getInstituicao(Long.parseLong(request.getParameter("instituicao")));
                    facade.atualizaInstituicao(u, atual, instituicao);
                }
                
            }catch(IllegalArgumentException e){
                request.setAttribute("msgEmail", e.getMessage());
            }catch(NullPointerException e){
                request.setAttribute("msgEmail", e.getMessage());
            }catch(Exception e){
                request.setAttribute("msgEmail", e.getMessage());
            }
        }
    }

%>
<section class="content">
      <div class="row">
        <!-- left column -->
        <div class="col-md-6">
          <!-- general form elements -->
          <div class="box box-primary">
            <div class="box-header with-border">
              <h3 class="box-title">Geral</h3>
              <p><%= (request.getAttribute("msgGeral") != null) ? request.getAttribute("msgGeral") : ""%></p>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
            <form role="form" action="" method="post">
              <div class="box-body">
                <div class="form-group">
                  <label for="nome">Nome</label>
                  <input type="text" class="form-control" id="nome" placeholder="Seu nome" name="nomeUsuario" value="<%= (request.getParameter("nomeUsuario") != null) ? request.getParameter("nomeUsuario") : (u.getNome() != null && !u.getNome().isEmpty()) ? u.getNome() : "" %>">
                </div>
                <div class="form-group">
                  <label for="cpf">CPF</label>
                  <input type="text" class="form-control" id="cpf" placeholder="Seu CPF" name="cpf" value="<%= (request.getParameter("cpf") != null) ? request.getParameter("cpf") : (u.getCpf()!= null && u.getCpf().getCpf() != null && !u.getCpf().getCpf().isEmpty()) ? u.getCpf().getFormatedCpf() : "" %>">
                </div>
                <div class="form-group">
                  <label>Ocupação</label>
                  <textarea class="form-control" rows="3" placeholder="Sua ocupação" name="ocupacao" value="<%= (request.getParameter("ocupacao") != null) ? request.getParameter("ocupacao") : (u.getOcupacao()!= null && !u.getOcupacao().isEmpty()) ? u.getOcupacao() : "" %>"><%= (request.getParameter("ocupacao") != null) ? request.getParameter("ocupacao") : (u.getOcupacao()!= null && !u.getOcupacao().isEmpty()) ? u.getOcupacao() : "" %></textarea>
                </div>
                <div class="form-group">
                  <label>Formação</label>
                  <textarea class="form-control" rows="3" placeholder="Sua ocupação" name="formacao" value="<%= (request.getParameter("formacao") != null) ? request.getParameter("formacao") : (u.getFormacao()!= null && !u.getFormacao().isEmpty()) ? u.getFormacao() : "" %>"><%= (request.getParameter("formacao") != null) ? request.getParameter("formacao") : (u.getFormacao()!= null && !u.getFormacao().isEmpty()) ? u.getFormacao() : "" %></textarea>
                </div>
                <div class="form-group">
                  <label for="lattes">Link lattes</label>
                  <input type="text" class="form-control" id="lattes" placeholder="Link curriculum" name="lattes" value="<%= (request.getParameter("lattes") != null) ? request.getParameter("lattes") : (u.getLattes()!= null && !u.getLattes().isEmpty()) ? u.getLattes() : "" %>" >
                </div> 
                <div class="form-group">
                  <label for="nascimento">Nascimento</label>
                  <input type="date" class="form-control" id="nascimento" placeholder="Data nascimento" name="nascimento" value="<%= (request.getParameter("nascimento") != null) ? request.getParameter("nascimento") : (u.getNascimento()!= null) ? u.getNascimento().toString() : "" %>">
                </div>   
              </div>
              <!-- /.box-body -->
              <div class="box-footer">
                  <button type="submit" class="btn btn-primary" name="atualiza" value="geral">Atualizar</button>
              </div>
            </form>
          </div>
          <!-- /.box -->
           <!-- /.box -->
           <div class="box box-info">
            <div class="box-header with-border">
                <h3 class="box-title">Instituição</h3>
                <p><%= (request.getAttribute("msgInstituicao") != null) ? request.getAttribute("msgInstituicao") : ""%></p>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
            <form class="form-horizontal" action="" method="post">
              <div class="box-body">
                <div class="form-group">
                    <label>Selecionar instituição</label>
                    <select class="form-control select2"  name="categoria">
                        <option selected="selected" value="">Selecione uma instituição</option>
                        <%
                            List<InstituicaoBeans> instituicoes = facade.getInstituicoes();
                            String selected = "";
                            boolean achou = false;
                            InstituicaoBeans inst = null;
                            for(int i=0;i<instituicoes.size();i++){
                                InstituicaoBeans in =instituicoes.get(i);
                                for(int j=0;j<in.getAssociados().size();j++){   
                                    UsuarioBeans ub = in.getAssociados().get(j);
                                    if(u.getEmail().equals(ub.getEmail())){
                                        selected = "selected='selected'";
                                        inst = in;
                                        break;
                                    }else{
                                        selected = "";
                                    }
                                }
                        %>
                            <option value="<%=in.getCodInstituicao() %>" <%=selected%> ><%= in.getNome() %></option>
                        <% } %>
                    </select>
                </div>
                    <p><a href="javascript:void(0);" onclick="nis();" class="nis">Adicionar uma nova</a></p>
                <div class="novaInstituicao" style="display:none;">
                    <fieldset>
                    <div class="form-group">
                        <label for="nomeInstituicao">Instituição</label>
                        <input type="text" class="form-control" id="nomeInstituicao" placeholder="Nome da instituição" name="nomeInstituicao">
                    </div>
                    </fieldset>    
                </div>
              </div>
              <!-- /.box-body -->
              <div class="box-footer">
                <button type="submit" class="btn btn-info pull-right" name="atualiza" value="instituicao">Atualizar</button>
              </div>
              <!-- /.box-footer -->
            </form>
          </div>
          <!-- /.box -->

          <!-- /.box -->

          <!-- Input addon -->
          <div class="box box-info">
            <div class="box-header with-border">
              <h3 class="box-title">Instituição</h3>
            </div>
            <div class="box-body">
                <div class="selecionarCurso">
                        <div class="form-group">
                            <label>Selecionar curso</label>
                            <select class="form-control select2" style="width: 100%;" name="categoria">
                                <option selected="selected" value="">Selecione um curso</option>
                                <%
                                    String selectedCurso = "";
                                    boolean achado = false;
                                    if(inst != null){
                                        for(int i=0;i<inst.getCursos().size();i++){
                                            CursoBeans c = inst.getCursos().get(i);
                                            if(u.getMatricula() != null){
                                                if(u.getMatricula().getCurso().getCodCurso() == c.getCodCurso()){
                                                    selectedCurso = "selected='selected'";
                                                    achado = true;
                                                }else{
                                                    selectedCurso = "";   
                                                }
                                            }  
                                %>
                                    <option value="<%=c.getCodCurso()%>" <%=selectedCurso %>><%=c.getNome() %></option>
                                <%  
                                        }
                                    }else{
                                  %>
                                  <%}%>
                            </select>
                        </div>
                        <p><a href="javascript:void(0);" onclick="ncss();" class="nis">Adicionar um novo curso</a></p>
                        <div class="novoCursoS" style="display:none;">
                            <div class="form-group">
                                <label for="nomeCurso">Curso</label>
                                <input type="text" class="form-control" id="nomeCurso" placeholder="Nome do curso" name="nomeCurso">
                            </div>
                            <div class="form-group">
                                <label>Descrição</label>
                                <textarea class="form-control" rows="3" placeholder="Descrição do curso" name="descricaoCurso"></textarea>
                            </div>
                            <div class="form-group">
                                <label for="duracaoCurso">Duração</label>
                                <input type="number" class="form-control" id="duracaoCurso" placeholder="Duração do curso" name="duracaoCurso">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="numMatricula">Matrícula</label>
                            <input type="number" class="form-control" id="numMatricula" placeholder="Número da matrícula" name="numMatricula">
                        </div>
                        <div class="form-group">
                            <label for="periodoCurso">Período</label>
                            <input type="number" class="form-control" id="periodoCurso" placeholder="Período que está cursando o curso" name="periodoCurso">
                     </div>
                </div>
              <!-- /input-group -->
            </div>
            <!-- /.box-body -->
            <div class="box-footer">
                <button type="submit" class="btn btn-primary" name="atualiza" value="instituicao">Atualizar</button>
            </div>
          </div>
          <!-- /.box -->

        </div>
        <!--/.col (left) -->
        <!-- right column -->
        <div class="col-md-6">
          <!-- Horizontal Form -->
          <div class="box box-info">
            <div class="box-header with-border">
              <h3 class="box-title">Senha</h3>
              <p><%= (request.getAttribute("msgSenha") != null) ? request.getAttribute("msgSenha") : ""%></p>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
            <form class="form-horizontal" action="" method="post">
              <div class="box-body">
                <div class="form-group">
                  <label for="senhaAtual" class="col-sm-2 control-label">Senha atual</label>

                  <div class="col-sm-10">
                      <input type="password" class="form-control" id="senhaAtual" placeholder="Sua senha atual" name="senhaAtual">
                  </div>
                </div>
                <div class="form-group">
                  <label for="novaSenha" class="col-sm-2 control-label">Nova senha</label>

                  <div class="col-sm-10">
                    <input type="password" class="form-control" id="novaSenha" placeholder="Sua nova senha" name="novaSenha">
                  </div>
                </div>
                <div class="form-group">
                  <label for="confirmeNovaSenha" class="col-sm-2 control-label">Confirme nova senha</label>

                  <div class="col-sm-10">
                    <input type="password" class="form-control" id="confirmeNovaSenha" placeholder="Digite novamente sua nova senha" name="confirmeNovaSenha">
                  </div>
                </div>  

              </div>
              <!-- /.box-body -->
              <div class="box-footer">
                <button type="submit" class="btn btn-info pull-right" name="atualiza" value="senha">Atualizar</button>
              </div>
              <!-- /.box-footer -->
            </form>
          </div>
            <!-- /.box -->
           <div class="box box-info">
            <div class="box-header with-border" onload="<%= (request.getAttribute("scriptReload") != null) ? request.getAttribute("scriptReload") : "" %>">
                <h3 class="box-title">Email</h3><br /><small style="color:red">*(Caso altere o seu e-mail, sua conta passará a ser inválida, e será necessário realizar o processo de validação novamente! Após a auteração sua sessão será encerrada, e você terá o prazo de 12 horas para validar sua conta.)</small>
                <p><%= (request.getAttribute("msgEmail") != null) ? request.getAttribute("msgEmail") : ""%></p>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
            <form class="form-horizontal" action="" method="post">
              <div class="box-body">
                <div class="form-group">
                  <label for="emailAtual" class="col-sm-2 control-label">E-mail atual</label>

                  <div class="col-sm-10">
                      <input type="email" class="form-control" id="emailAtual" placeholder="Seu e-mail atual" name="emailAtual" value="<%= (request.getParameter("emailAtual") != null) ? request.getParameter("emailAtual") : (u.getEmail()!= null && !u.getEmail().isEmpty()) ? u.getEmail() : "" %>">
                  </div>
                </div>
                <div class="form-group">
                  <label for="novoEmail" class="col-sm-2 control-label">Novo e-mail</label>

                  <div class="col-sm-10">
                    <input type="email" class="form-control" id="novoEmail" placeholder="Seu novo e-mail" name="novoEmail">
                  </div>
                </div>
                <div class="form-group">
                  <label for="confirmeNovaSenha" class="col-sm-2 control-label">Confirme novo e-mail</label>

                  <div class="col-sm-10">
                    <input type="email" class="form-control" id="confirmeNovaSenha" placeholder="Digite novamente seu novo e-mail" name="confirmeNovoEmail">
                  </div>
                </div>  

              </div>
              <!-- /.box-body -->
              <div class="box-footer">
                <button type="submit" class="btn btn-info pull-right" name="atualiza" value="email">Atualizar</button>
              </div>
              <!-- /.box-footer -->
            </form>
          </div>
        </div>
        <!--/.col (right) -->
      </div>
      <!-- /.row -->
    </section>