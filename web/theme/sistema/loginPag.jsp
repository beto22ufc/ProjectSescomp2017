<%-- 
    Document   : loginPag
    Created on : 03/09/2017, 11:35:56
    Author     : Usuario
--%>
<%@page import="artemis.model.Facade"%>
<%@page import="artemis.beans.UsuarioBeans"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% 
    String dir = config.getServletContext().getInitParameter("dir");
    if(session.getAttribute("usuario") == null){
    
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Artemis | login</title>
         <jsp:include page="parts/css.jsp"></jsp:include>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
        
        
        <!--aqui -->
        <%
        if(request.getParameter("login") != null){
            try{
                UsuarioBeans ub = new UsuarioBeans(request.getParameter("email"), request.getParameter("senha"));
                Facade facade = new Facade();
                ub = facade.fazerLogin(ub);
                if(ub != null){
                    if(ub.getStatus() == 0){
                        request.setAttribute("msg", "Sua conta não foi validada ainda! Acesse seu e-mail e a valide!<br />"
                                + "Não recebeu o e-mail de ativação? <a href='/"+dir+"/reenviarEmailValidacao'>Não, reenviar e-mail!</a>");
                    }else{
                        session.setAttribute("usuario", ub);
                        request.setAttribute("msg", "Login realizado com sucesso!");
                        RequestDispatcher rd = request.getRequestDispatcher("/");
                        rd.forward(request, response);
                    }
                }else{
                    request.setAttribute("msg", "Usuário não encontrado!");
                }
            }catch(IllegalArgumentException e){
                request.setAttribute("msg", e.getMessage());
            }catch(NullPointerException e){
                request.setAttribute("msg", e.getMessage());
            }
        }
    %>
        
        
        
        
        
        <!-- sign in form -->
	 <section>
		<div id="agileits-sign-in-page" class="sign-in-wrapper">
			<div class="agileinfo_signin">
			<h3>Login</h3>
                            <p class="login-box-msg" style="color: red;"><%= (request.getAttribute("msg") != null) ? request.getAttribute("msg") : "FaÃ§a o login e inicie uma sessÃ£o"%></p>
				<form action="#" method="post">
					<input type="email" name="email" placeholder="E-mail" required=""> 
					<input type="password" name="senha" placeholder="Senha" required=""> 
					<input type="submit" value="Entrar">
					<div class="forgot-grid">
                                            <label class="checkbox"><input type="checkbox" name="checkbox">Lembrar de mim</label>
                                            <div class="forgot">
                                                <a href="#" data-toggle="modal" data-target="#myModal2">Esqueceu a senha?</a>
                                            </div>
                                            <!-- Modal -->
                                            <div class="modal fade collapse" id="myModal2" role="dialog">
                                                <div class="modal-dialog">
                                                    <!-- Modal content-->
                                                    <div class="modal-dialog modal-lg">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                                <h3 class="w3ls-password">Recuperar Senha</h3>		
                                                                <p class="get-pw">Entre com o <b>CPF</b> que vocÃª usou no cadastro. NÃ³s enviaremos um email para vocÃª recuperar sua senha.</p>
                                                                <form action="#" method="post">
                                                                    <input type="text" class="user" name="email" placeholder="E-mail" required="">
                                                                    <input type="submit" value="Recuperar">
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="clearfix"> </div>
					</div>
				</form>
                                <h6> Ainda não é membro? <a href="cadastroPag.jsp">Cadastre-se agora</a> </h6>
			</div>
		</div>
	</section>
	<!-- //sign in form -->
        <!--aqui -->
        <footer>
            <jsp:include page="footer-bottom.jsp"></jsp:include>
        </footer>
      
        <!-- Navigation-Js-->
        <script type="text/javascript" src="../../static/plugins/index/js/main.js"></script>
                <script type="text/javascript" src="../../static/plugins/index/js/classie.js"></script>
		<!-- //Navigation-Js-->
		<!-- js -->
		<script type="text/javascript" src="js/jquery.min.js"></script>
		<!-- js -->
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/bootstrap.js"></script>
		<script src="js/bootstrap-select.js"></script>
		<script>
		  $(document).ready(function () {
			var mySelect = $('#first-disabled2');

			$('#special').on('click', function () {
			  mySelect.find('option:selected').prop('disabled', true);
			  mySelect.selectpicker('refresh');
			});

			$('#special2').on('click', function () {
			  mySelect.find('option:disabled').prop('disabled', false);
			  mySelect.selectpicker('refresh');
			});

			$('#basic2').selectpicker({
			  liveSearch: true,
			  maxOptions: 1
			});
		  });
		</script>

        
        
        
        
        <jsp:include page="parts/js.jsp"></jsp:include>
    </body>
</html>
<% }else{
        RequestDispatcher rd = request.getRequestDispatcher("/");
        rd.forward(request, response);
        
        }%>

