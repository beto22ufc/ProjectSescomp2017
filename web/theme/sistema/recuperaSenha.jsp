<%-- 
    Document   : cadastro
    Created on : 28/07/2017, 09:13:29
    Author     : Wallison
--%>

<%@page import="org.apache.commons.mail.EmailException"%>
<%@page import="artemis.model.Facade"%>
<%@page import="artemis.beans.UsuarioBeans"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% if(session.getAttribute("usuario") == null){%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Artemis | Recuperar Senha</title>
         <jsp:include page="parts/css.jsp"></jsp:include>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
        
        
        <!--aqui -->
             <%
        if(request.getParameter("recuperar") != null){
            try{
                String cpf = request.getParameter("cpf");
                Facade facade = new Facade();
                facade.recuperaSenha(cpf);
                request.setAttribute("msg", "O e-mail de recuperação de senha foi enviado com sucesso!<br />"
                        + " Obs.: Verifique sua mensagens e veja sua nova senha e altere-a!");
            }catch(IllegalArgumentException e){
                request.setAttribute("msg", e.getMessage());
            }catch(NullPointerException e){
                request.setAttribute("msg", e.getMessage());
            }catch(EmailException e){
                request.setAttribute("msg", e.getMessage());
            }
        }
    %>
        <section>
		<div id="agileits-sign-in-page" class="sign-in-wrapper">
			<div class="agileinfo_signin">
			<h3>Recuperar Senha</h3>
                        <p class="get-pw" style="text-align: center">Entre com o <b>CPF</b> que você usou no cadastro. Nós enviaremos um email para você recuperar sua senha.</p>
                            <p class="login-box-msg" style="color: red;"><%= (request.getAttribute("msg") != null) ? request.getAttribute("msg") : "Preencha o campo abaixo"%></p>
				<form action="" method="post">
					<input type="text" class="user" name="cpf" placeholder="Digite seu CPF" required="">
                                        <input type="submit"  name="recuperar" value="Recuperar">
				</form>
                                <h6> Ainda não é membro? <a href="cadastroPag.jsp">Cadastre-se agora</a> </h6>
			</div>
		</div>
	</section>
        
        <!--aqui -->
        <footer>
            <jsp:include page="footer-bottom.jsp"></jsp:include>
        </footer>


</body>
</html>
                
<% }else{
        RequestDispatcher rd = request.getRequestDispatcher("/ArtemisTCC/");
        rd.forward(request, response);
        
        }%>

