<%-- 
    Document   : dadosUsuario
    Created on : 02/08/2017, 11:29:51
    Author     : Wallison
--%>
<%@page import="java.time.format.DateTimeParseException"%>
<%@page import="artemis.beans.ContasSociaisBeans"%>
<%@page import="artemis.beans.MatriculaBeans"%>
<%@page import="artemis.model.ImageManipulation"%>
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
    String dir = config.getServletContext().getInitParameter("dir");
    Facade facade = new Facade();
    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    UsuarioBeans u = (UsuarioBeans) session.getAttribute("usuario");
    InstituicaoBeans atual = null;
    List<InstituicaoBeans> insts = facade.getInstituicoes();
    boolean parar = false;
    for (int i = 0; i < insts.size(); i++) {
        InstituicaoBeans ins = insts.get(i);
        for (int j = 0; j < ins.getAssociados().size(); j++) {
            UsuarioBeans ub = ins.getAssociados().get(j);
            if (ub.getEmail().equals(u.getEmail())) {
                atual = ins;
                parar = true;
                break;
            }
        }
        if (parar) {
            break;
        }
    }
    if (request.getParameter("atualiza") != null) {
        String opc = request.getParameter("atualiza");
        if (opc.equals("geral")) {
            try {
                u.setNome(request.getParameter("nomeUsuario"));
                u.setCpf(new CPF(request.getParameter("cpf")));
                u.setOcupacao(request.getParameter("ocupacao"));
                u.setFormacao(request.getParameter("formacao"));
                u.setLattes(request.getParameter("lattes"));
                u.setNascimento(LocalDate.parse(request.getParameter("nascimento"), dtf));
                facade.atualizaUsuarioGeral(u);
                session.setAttribute("usuario", u);
                request.setAttribute("msgGeral", "Dados atualizados com sucesso!");
            } catch (IllegalArgumentException e) {
                request.setAttribute("msgGeral", e.getMessage());
            } catch (NullPointerException e) {
                request.setAttribute("msgGeral", e.getMessage());
            }catch(DateTimeParseException e){
                request.setAttribute("msg","Formato de data inválido");
            }
        } else if (opc.equals("senha")) {
            try {
                if (request.getParameter("novaSenha").equals(request.getParameter("confirmeNovaSenha"))) {
                    u = facade.atualizaUsuarioSenha(u, request.getParameter("senhaAtual"), request.getParameter("novaSenha"));
                    session.setAttribute("usuario", u);
                    request.setAttribute("msgSenha", "Senha atualizada com sucesso!");
                } else {
                    request.setAttribute("msgSenha", "Senha de confirmação não bate com nova senha!");
                }
            } catch (IllegalArgumentException e) {
                request.setAttribute("msgSenha", e.getMessage());
            } catch (NullPointerException e) {
                request.setAttribute("msgSenha", e.getMessage());
            } catch (Exception e) {
                request.setAttribute("msgSenha", e.getMessage());
            }
        } else if (opc.equals("email")) {
            try {
                if (request.getParameter("novoEmail").equals(request.getParameter("confirmeNovoEmail"))) {
                    facade.atualizaUsuarioEmail(u, request.getParameter("emailAtual"), request.getParameter("novoEmail"));
                    request.setAttribute("msgEmail", "E-mail atualizado com sucesso!");
                    session.removeAttribute("usuario");
                } else {
                    request.setAttribute("msgEmail", "E-mail de confirmação não bate com o novo e-mail!");
                }
            } catch (IllegalArgumentException e) {
                request.setAttribute("msgEmail", e.getMessage());
            } catch (NullPointerException e) {
                request.setAttribute("msgEmail", e.getMessage());
            } catch (Exception e) {
                request.setAttribute("msgEmail", e.getMessage());
            }
        } else if (opc.equals("instituicao")) {
            try {
                InstituicaoBeans instituicao = facade.getInstituicao(Long.parseLong(request.getParameter("instituicao")));
                facade.atualizaInstituicao(u, atual, instituicao);
                request.setAttribute("msgInstituicao", "Instituição atualizada com sucesso!");
            } catch (IllegalArgumentException e) {
                request.setAttribute("msgInstituicao", e.getMessage());
            } catch (NullPointerException e) {
                request.setAttribute("msgInstituicao", e.getMessage()+"Tetse");
            } catch (Exception e) {
                request.setAttribute("msgInstituicao", e.getMessage());
            }
        }else if (opc.equals("curso")) {
            try {
                if(request.getParameter("curso") != null){
                    CursoBeans curso = null;
                    try{
                        curso = facade.getCurso(Long.parseLong(request.getParameter("curso")));
                    }catch(NumberFormatException e){
                        request.setAttribute("msgCurso", "Código do curso inválido!");
                    }catch(NullPointerException e){
                        request.setAttribute("msgCurso", "Código do curso inválido!");
                    }
                    if(u.getMatricula() != null){
                        u.getMatricula().setNumero(Integer.parseInt(request.getParameter("numMatricula")));
                        u.getMatricula().setCurso(curso);
                        u.getMatricula().setPeriodo(Integer.parseInt(request.getParameter("periodoCurso")));
                    }else{
                        MatriculaBeans matricula = new MatriculaBeans();
                        matricula.setNumero(Integer.parseInt(request.getParameter("numMatricula")));
                        matricula.setCurso(curso);
                        matricula.setPeriodo(Integer.parseInt(request.getParameter("periodoCurso")));
                        u.setMatricula(facade.adicionaMatricula(matricula));
                    }
                    facade.atualizaUsuarioGeral(u);
                }else{
                    u.setMatricula(null);
                }
                request.setAttribute("msgCurso", "Curso atualizado com sucesso!");
            } catch (IllegalArgumentException e) {
                request.setAttribute("msgCurso", e.getMessage());
            } catch (NullPointerException e) {
                request.setAttribute("msgCurso", e.getMessage());
            } catch (Exception e) {
                request.setAttribute("msgCurso", e.getMessage());
            }
        }else if (opc.equals("contasSociais")) {
            try {   
                if(u.getContasSociais() != null){
                    u.getContasSociais().setNookdear(request.getParameter("nookdear"));
                    u.getContasSociais().setFacebook(request.getParameter("facebook"));
                    u.getContasSociais().setTwitter(request.getParameter("twitter"));
                    u.getContasSociais().setGplus(request.getParameter("gplus"));
                    u.getContasSociais().setLinkedin(request.getParameter("linkedin"));
                }else{
                    ContasSociaisBeans contas = new ContasSociaisBeans();
                    contas.setNookdear(request.getParameter("nookdear"));
                    contas.setFacebook(request.getParameter("facebook"));
                    contas.setTwitter(request.getParameter("twitter"));
                    contas.setGplus(request.getParameter("gplus"));
                    contas.setLinkedin(request.getParameter("linkedin"));
                    u.setContasSociais(facade.adicionaContasSociais(contas));
                }
                facade.atualizaUsuarioGeral(u);
                request.setAttribute("msgContasSociais", "Contas sociais atualizadas com sucesso!");
            } catch (IllegalArgumentException e) {
                request.setAttribute("msgContasSociais", e.getMessage());
            } catch (NullPointerException e) {
                request.setAttribute("msgContasSociais", e.getMessage()
                );
            } catch (Exception e) {
                request.setAttribute("msgContasSociais", e.getMessage());
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
                            <input type="text" class="form-control" id="nome" placeholder="Seu nome" name="nomeUsuario" value="<%= (request.getParameter("nomeUsuario") != null) ? request.getParameter("nomeUsuario") : (u.getNome() != null && !u.getNome().isEmpty()) ? u.getNome() : ""%>">
                        </div>
                        <div class="form-group">
                            <label for="cpf">CPF</label>
                            <input type="text" class="form-control" id="cpf" placeholder="Seu CPF" name="cpf" value="<%= (request.getParameter("cpf") != null) ? request.getParameter("cpf") : (u.getCpf() != null && u.getCpf().getCpf() != null && !u.getCpf().getCpf().isEmpty()) ? u.getCpf().getFormatedCpf() : ""%>">
                        </div>
                        <div class="form-group">
                            <label>Ocupação</label>
                            <textarea class="form-control" rows="3" placeholder="Sua ocupação" name="ocupacao" value="<%= (request.getParameter("ocupacao") != null) ? request.getParameter("ocupacao") : (u.getOcupacao() != null && !u.getOcupacao().isEmpty()) ? u.getOcupacao() : ""%>"><%= (request.getParameter("ocupacao") != null) ? request.getParameter("ocupacao") : (u.getOcupacao() != null && !u.getOcupacao().isEmpty()) ? u.getOcupacao() : ""%></textarea>
                        </div>
                        <div class="form-group">
                            <label>Formação</label>
                            <textarea class="form-control" rows="3" placeholder="Sua ocupação" name="formacao" value="<%= (request.getParameter("formacao") != null) ? request.getParameter("formacao") : (u.getFormacao() != null && !u.getFormacao().isEmpty()) ? u.getFormacao() : ""%>"><%= (request.getParameter("formacao") != null) ? request.getParameter("formacao") : (u.getFormacao() != null && !u.getFormacao().isEmpty()) ? u.getFormacao() : ""%></textarea>
                        </div>
                        <div class="form-group">
                            <label for="lattes">Link lattes</label>
                            <input type="text" class="form-control" id="lattes" placeholder="Link curriculum" name="lattes" value="<%= (request.getParameter("lattes") != null) ? request.getParameter("lattes") : (u.getLattes() != null && !u.getLattes().isEmpty()) ? u.getLattes() : ""%>" >
                        </div> 
                        <div class="form-group">
                            <label for="nascimento">Nascimento</label>
                            <input type="text" class="form-control" id="nascimento" maxlength="10" onkeypress="formatar('##/##/####',this)" placeholder="Data nascimento" name="nascimento" value="<%= (request.getParameter("nascimento") != null) ? request.getParameter("nascimento") : (u.getNascimento() != null) ? u.getNascimento().format(dtf) : ""%>">
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
                            <select class="form-control select2"  name="instituicao">
                                <option value="">Selecione uma instituição</option>
                                <%
                                    List<InstituicaoBeans> instituicoes = facade.getInstituicoes();
                                    String selected = "";
                                    boolean achou = false;
                                    InstituicaoBeans inst = null;
                                    for (int i = 0; i < instituicoes.size(); i++) {
                                        InstituicaoBeans in = instituicoes.get(i);
                                        for (int j = 0; j < in.getAssociados().size(); j++) {
                                            UsuarioBeans ub = in.getAssociados().get(j);
                                            if (u.getEmail().equals(ub.getEmail())) {
                                                selected = "selected='selected'";
                                                inst = in;
                                                break;
                                            } else {
                                                selected = "";
                                            }
                                        }
                                %>
                                <option value="<%=in.getCodInstituicao()%>" <%=selected%> ><%= in.getNome()%></option>
                                <% } %>
                            </select>
                        </div>
                        
                    </div>
                    <!-- /.box-body -->
                    <div class="box-footer">
                        <button type="submit" class="btn btn-primary pull-right" name="atualiza" value="instituicao">Atualizar</button>
                    </div>
                    <!-- /.box-footer -->
                </form>
            </div>
            <!-- /.box -->

            <!-- /.box -->

            <!-- Input addon -->
            <div class="box box-info">
                <div class="box-header with-border">
                    <h3 class="box-title">Curso</h3>
                    <p><%= (request.getAttribute("msgCurso") != null) ? request.getAttribute("msgCurso") : ""%></p>
                </div>
                <form action="" method="post">
                <div class="box-body">
                    <div class="selecionarCurso">
                        <div class="form-group">
                            <label>Selecionar curso</label>
                            <select class="form-control select2" style="width: 100%;" name="curso">
                                <option value="">Selecione um curso</option>
                                <%
                                    String selectedCurso = "";
                                    boolean achado = false;
                                    if (inst != null) {
                                        for (int i = 0; i < inst.getCursos().size(); i++) {
                                            CursoBeans c = inst.getCursos().get(i);
                                            if (u.getMatricula() != null) {
                                                if (u.getMatricula().getCurso() !=null && u.getMatricula().getCurso().getCodCurso() == c.getCodCurso()) {
                                                    selectedCurso = "selected=/'selected/'";
                                                    achado = true;
                                                } else {
                                                    selectedCurso = "";
                                                }
                                            }
                                %>
                                <option value="<%=c.getCodCurso()%>" <%=selectedCurso%>><%=c.getNome()%></option>
                                <%
                                    }
                                } else {
                                %>
                                <%}%>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="numMatricula">Matrícula</label>
                            <input type="number" class="form-control" id="numMatricula" placeholder="Número da matrícula" name="numMatricula" value="<%=(request.getParameter("numMatricula") != null) ? request.getParameter("numMatricula") : (u.getMatricula() != null) ? u.getMatricula().getNumero() : "" %>">
                        </div>
                        <div class="form-group">
                            <label for="periodoCurso">Período</label>
                            <input type="number" class="form-control" id="periodoCurso" placeholder="Período que está cursando o curso" name="periodoCurso" value="<%=(request.getParameter("periodoCurso") != null) ? request.getParameter("periodoCurso") : (u.getMatricula() != null) ? u.getMatricula().getPeriodo(): "" %>">
                        </div>
                    </div>
                    <!-- /input-group -->
                    
                </div>
                <!-- /.box-body -->
                <div class="box-footer">
                    <button type="submit" class="btn btn-primary" name="atualiza" value="curso">Atualizar</button>
                </div>
                </form>
            </div>
            <!-- /.box -->

            <!-- general form elements -->
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">Contas sociais</h3>
                    <p><%= (request.getAttribute("msgContasSociais") != null) ? request.getAttribute("msgContasSociais") : ""%></p>
                </div>
                <!-- /.box-header -->
                <!-- form start -->
                <form role="form" action="" method="post">
                    <div class="box-body">
                        <div class="form-group">
                            <label for="nookdear">Nookdear</label>
                            <input type="text" class="form-control" id="nookdear" placeholder="Nome de usuário da Nookdear" name="nookdear" value="<%= (request.getParameter("nookdear") != null) ? request.getParameter("nookdear") : (u.getContasSociais() != null && u.getContasSociais().getNookdear() != null) ? u.getContasSociais().getNookdear().substring(u.getContasSociais().getNookdear().lastIndexOf("/")+1) : ""%>">
                        </div>
                        <div class="form-group">
                            <label for="facebook">Facebook</label>
                            <input type="text" class="form-control" id="facebook" placeholder="Nome de usuário da Facebook" name="facebook" value="<%= (request.getParameter("facebook") != null) ? request.getParameter("facebook") : (u.getContasSociais() != null && u.getContasSociais().getFacebook()!= null) ? u.getContasSociais().getFacebook().substring(u.getContasSociais().getFacebook().lastIndexOf("/")+1) : ""%>">
                        </div>
                        <div class="form-group">
                            <label for="twitter">Twitter</label>
                            <input type="text" class="form-control" id="twitter" placeholder="Nome de usuário da Twitter" name="twitter" value="<%= (request.getParameter("twitter") != null) ? request.getParameter("twitter") : (u.getContasSociais() != null && u.getContasSociais().getTwitter()!= null) ? u.getContasSociais().getTwitter().substring(u.getContasSociais().getTwitter().lastIndexOf("/")+1) : ""%>">
                        </div>
                        <div class="form-group">
                            <label for="gplus">Google +</label>
                            <input type="text" class="form-control" id="gplus" placeholder="Nome de usuário da Google +" name="gplus" value="<%= (request.getParameter("gplus") != null) ? request.getParameter("gplus") : (u.getContasSociais() != null && u.getContasSociais().getGplus()!= null) ? u.getContasSociais().getGplus().substring(u.getContasSociais().getGplus().lastIndexOf("/")+1) : ""%>">
                        </div>
                        <div class="form-group">
                            <label for="linkedin">Linkedin</label>
                            <input type="text" class="form-control" id="linkedin" placeholder="Nome de usuário da Linkedin" name="linkedin" value="<%= (request.getParameter("linkedin") != null) ? request.getParameter("linkedin") : (u.getContasSociais() != null && u.getContasSociais().getLinkedin()!= null) ? u.getContasSociais().getLinkedin().substring(u.getContasSociais().getLinkedin().lastIndexOf("/")+1) : ""%>">
                        </div>
                         </div>                   <!-- /.box-body -->
                    <div class="box-footer">
                        <button type="submit" class="btn btn-primary" name="atualiza" value="contasSociais">Atualizar</button>
                    </div>
                </form>
            </div>
            
            
            
        </div>
        <!--/.col (left) -->
        <!-- right column -->
        <div class="col-md-6">
            <div class="box box-info">
                <div class="box-header with-border">
                    <h3 class="box-title">Alterar foto perfil</h3>
                    <p><%= (request.getAttribute("msgFoto") != null) ? request.getAttribute("msgFoto") : ""%></p>
                </div>
                <!-- /.box-header -->
                <!-- form start -->
                <form class="form-horizontal" action="/<%=dir%>/PerfilImagemUpload" method="post" enctype="multipart/form-data">
                    <div class="box-body">
                        <div class="form-group">
                            <div class="col-sm-10">
                                <%
                                    if (u.getImagemPerfil() == null) {
                                %>
                                <img src="/<%=dir%>/static/img/avatar-default.png" style="width: 150px; height: 150px" />
                                <%
                                } else {
                                %>
                                <img src="<%=ImageManipulation.encodeImage(u.getImagemPerfil())%>" style="width: 150px; height: 150px" />
                                <%  }%>
                            </div>
                        </div>    
                        <div class="form-group">
                            <label for="fotoPerfil" class="col-sm-2 control-label">Nova foto</label>
                            <div class="col-sm-10">
                                <input type="file" class="form-control" id="fotoPerfil" name="fotoPerfil" required="required">
                            </div>
                        </div>

                    </div>
                    <!-- /.box-body -->
                    <div class="box-footer">
                        <button type="submit" class="btn btn-primary pull-right" name="atualiza" value="fotoPerfil">Atualizar</button>
                    </div>
                    <!-- /.box-footer -->
                </form>
            </div>


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
                        <button type="submit" class="btn btn-primary pull-right" name="atualiza" value="senha">Atualizar</button>
                    </div>
                    <!-- /.box-footer -->
                </form>
            </div>
            <!-- /.box -->
            <div class="box box-info">
                <div class="box-header with-border" onload="<%= (request.getAttribute("scriptReload") != null) ? request.getAttribute("scriptReload") : ""%>">
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
                                <input type="email" class="form-control" id="emailAtual" placeholder="Seu e-mail atual" name="emailAtual" value="<%= (request.getParameter("emailAtual") != null) ? request.getParameter("emailAtual") : (u.getEmail() != null && !u.getEmail().isEmpty()) ? u.getEmail() : ""%>">
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
                        <button type="submit" class="btn btn-primary pull-right" name="atualiza" value="email">Atualizar</button>
                    </div>
                    <!-- /.box-footer -->
                </form>
            </div>
        </div>
        <!--/.col (right) -->
    </div>
    <!-- /.row -->
</section>