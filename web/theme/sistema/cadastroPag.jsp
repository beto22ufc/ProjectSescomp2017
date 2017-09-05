<%-- 
    Document   : cadastroPag
    Created on : 03/09/2017, 12:34:55
    Author     : Usuario
--%>
<%@page import="artemis.model.ContasSociais"%>
<%@page import="artemis.beans.ContasSociaisBeans"%>
<%@page import="org.apache.commons.mail.EmailException"%>
<%@page import="artemis.model.Facade"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="artemis.model.CPF"%>
<%@page import="artemis.beans.UsuarioBeans" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Artemis | cadastro</title>
        <jsp:include page="parts/css.jsp"></jsp:include>
    </head>
    <body>
    <jsp:include page="header.jsp"></jsp:include>
        <!-- aqui -->
        <%
      if(request.getParameter("cadastro") != null){
          try{      
            UsuarioBeans usuario = new UsuarioBeans();
            usuario.setNome(request.getParameter("nome"));
            usuario.setEmail(request.getParameter("email"));
            usuario.setSenha(request.getParameter("senha"));
            usuario.setCpf(new CPF(request.getParameter("numerocpf")));
            usuario.setCadastro(LocalDate.now());
            DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate nascimento = LocalDate.parse((String) request.getParameter("dataNascimento"), dateTimeFormatter);
            usuario.setNascimento(nascimento);
            Facade facade = new Facade();
            if(request.getParameter("senha").equals(request.getParameter("resenha"))){
                facade.fazerCadastro(usuario);
                request.setAttribute("msg", "Cadastro realizado com sucesso! "
                        + "<br />Verifique seu e-mail("+request.getParameter("email")+"), foi lhe enviado<br /> "
                        + "um link para ativação de sua conta!<br /> Obs.: Link"
                        + " válido por 12 horas após o cadastro! <br /> Não recebeu o e-mail de ativação? <a href='/ArtemisTCC/reenviarEmailValidacao'>Não, reenviar e-mail!</a>");
            }else{
                request.setAttribute("msg", "Senhas não conferem!");
            }
        }catch(IllegalArgumentException e){
            request.setAttribute("msg", e.getMessage());
        }catch(NullPointerException e){
            request.setAttribute("msg", e.getMessage());
        }catch(EmailException e){
            request.setAttribute("msg", e.getMessage());
        }
      }
  %>
    
    
    <!-- sign up form -->
	 <section>
            <div id="agileits-sign-in-page" class="sign-in-wrapper">
                <div class="agileinfo_signin">
                <h3>Cadastro</h3>
                    <p class="login-box-msg"><%=(request.getAttribute("msg")!= null) ? request.getAttribute("msg") : "Registro de novo membro" %></p>
                    <form action="#" method="post">
                        <input type="text" name="nome" placeholder="Nome completo"  value="<%= (request.getParameter("nome")!= null) ? request.getParameter("nome") : "" %>"> 
                        <input type="email" name="email" placeholder="E-mail" value="<%= (request.getParameter("email")!= null) ? request.getParameter("email") : "" %>"> 
                        <input type="text" name="numerocpf" placeholder="CPF ex.: 809.908.090-40" name="numerocpf" value="<%= (request.getParameter("numerocpf")!= null) ? request.getParameter("numerocpf") : "" %>" > 
                        <input type="date" name="dataNascimento" placeholder="Data de nascimento" value="<%= (request.getParameter("dataNascimento")!= null) ? request.getParameter("dataNascimento") : "" %>"> 
                        <input type="password" name="senha" placeholder="Senha" > 
                        <input type="password" name="resenha" placeholder="Confirme a senha" > 
                        <div class="signin-rit">
                            <span class="agree-checkbox">
                                <label class="checkbox"><input type="checkbox"> Eu aceito os <a href="#">termos</a></label>
                            </span>
                        </div>
                        <input type="submit" name="cadastro" value="Cadastre-se">
                    </form>
                        <a href="loginPag.jsp" class="text-center">Eu já sou um membro</a>
                </div>
            </div>
	</section>
	<!-- //sign up form -->
        
        <!-- aqui -->
        <footer>
            <jsp:include page="footer-bottom.jsp"></jsp:include>
        </footer>
            
        
        <jsp:include page="parts/js.jsp"></jsp:include>
    </body>
</html>
