<%-- 
    Document   : cadastro
    Created on : 28/07/2017, 09:13:29
    Author     : Wallison
--%>

<%@page import="artemis.model.Facade"%>
<%@page import="artemis.beans.UsuarioBeans"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% String dir = config.getServletContext().getInitParameter("dir");
    if(session.getAttribute("usuario") == null){%>
<html>
<head>
     <title>Artemis | Reenviar E-mail</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <jsp:include page="/${dir}/theme/sistema/parts/css.jsp"></jsp:include>
</head>
<body>
    <jsp:include page="/${dir}/theme/sistema/header.jsp"></jsp:include>
        
        
    <!--aqui -->
    <%
        if(request.getParameter("reenviar") != null){
            try{
                String email = request.getParameter("email");
                Facade facade = new Facade();
                facade.reenviarEmail(email);
                request.setAttribute("msg", "O e-mail para <b>"+email+"</b>foi enviado com sucesso!<br />"
                        + " Obs.: Você tem até 12 horas após o envio do e-mail para validar sua conta!");
            }catch(IllegalArgumentException e){
                request.setAttribute("msg", e.getMessage());
            }catch(NullPointerException e){
                request.setAttribute("msg", e.getMessage());
            }catch(Exception e ){
                request.setAttribute("msg", "Não foi possivel enviar o e-mail!");
            }
        }
    %>
    <section>
		<div id="agileits-sign-in-page" class="sign-in-wrapper">
			<div class="agileinfo_signin">
			<h3>Reenviar Email de Validação</h3>
                        <p class="get-pw" style="text-align: center">Entre com o <b>e-mail</b> que você usou no cadastro. Nós enviaremos um email para você validar sua conta.</p>
                            <p class="login-box-msg" style="color: red;"><%= (request.getAttribute("msg") != null) ? request.getAttribute("msg") : "Reenvie o e-mail de validação de sua conta"%></p>
				<form action="" method="post">
					<input type="text" class="user" name="email" placeholder="E-mail" required="">
                                        <input type="submit"  name="reenviar" value="Reenviar">
				</form>
                                <h6><a href="/<%=dir%>/login">Eu recebi o e-mail</a> </h6>
			</div>
		</div>
	</section>
<!--aqui -->
        <footer>
            <jsp:include page="/${dir}/theme/sistema/footer-bottom.jsp"></jsp:include>
        </footer>
<script>
  $(function () {
    $('input').iCheck({
      checkboxClass: 'icheckbox_square-blue',
      radioClass: 'iradio_square-blue',
      increaseArea: '20%' // optional
    });
  });
</script>
</body>
</html>
<% }else{
    RequestDispatcher rd = request.getRequestDispatcher("/ArtemisTCC/");
    rd.forward(request, response);

}%>

