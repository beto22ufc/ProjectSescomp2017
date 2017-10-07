<%-- 
    Document   : cadastro
    Created on : 28/07/2017, 09:13:29
    Author     : Wallison
--%>

<%@page import="artemis.model.Facade"%>
<%@page import="artemis.beans.UsuarioBeans"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%  String dir = config.getServletContext().getInitParameter("dir");
    if(session.getAttribute("usuario") == null){%>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Artemis | Validar conta</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <jsp:include page="/${dir}/theme/sistema/parts/css.jsp"></jsp:include>

  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->
</head>
<body class="hold-transition login-page">
    <jsp:include page="/${dir}/theme/sistema/header.jsp"></jsp:include>
<div class="login-box">
 
  <!-- /.login-logo -->
  <div class="login-box-body">

      <p class="login-box-msg">
          <%
              if(request.getParameter("cv") != null){
                  try{
                    String cod = request.getParameter("cv");
                    Facade facade = new Facade();
                    facade.validarConta(cod);
                    out.print("Sua conta foi validada com sucesso! Volte a tela de login para entrar no sistema.");
                  }catch(NullPointerException e){
                      out.println(e.getMessage());
                  }catch(IllegalArgumentException e){
                      out.println(e.getMessage());
                  }
              }else{
                  out.println("Não foi informado o código validador!");
              }
          %>
      </p>
    <!-- /.social-auth-links -->

  </div>
  <!-- /.login-box-body -->
</div>
<!-- /.login-box -->
        <footer>
            <jsp:include page="/${dir}/theme/sistema/footer-bottom.jsp"></jsp:include>
        </footer>
<!-- jQuery 2.2.3 -->
<script src="../../static/plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="../../static/bootstrap/js/bootstrap.min.js"></script>
<!-- iCheck -->
<script src="../../static/plugins/iCheck/icheck.min.js"></script>
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

