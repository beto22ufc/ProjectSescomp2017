<%-- 
    Document   : cadastro
    Created on : 28/07/2017, 09:13:29
    Author     : Wallison
--%>

<%@page import="artemis.model.Facade"%>
<%@page import="artemis.beans.UsuarioBeans"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% if(session.getAttribute("usuario") == null){%>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Artemis | Validar conta</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <!-- Bootstrap 3.3.6 -->
  <link rel="stylesheet" href="../../ArtemisTCC/static/bootstrap/css/bootstrap.min.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../ArtemisTCC/static/css/AdminLTE.min.css">
  <!-- iCheck -->
  <link rel="stylesheet" href="../../ArtemisTCC/static/plugins/iCheck/square/blue.css">

  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->
</head>
<body class="hold-transition login-page">
<div class="login-box">
  <div class="login-logo">
    <a href="/ArtemisTCC/"><b>Artemis</b></a>
  </div>
  <!-- /.login-logo -->
  <div class="login-box-body">

      <p class="login-box-msg">
          <%
              if(request.getParameter("cv") != null){
                  try{
                    String cod = request.getParameter("cv");
                    Facade facade = new Facade();
                    facade.validarConta(cod);
                    out.print("Sua conta foi validada com sucesso! <a href='/ArtemisTCC/login'>Faça o login!</a>");
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

    <a href="/ArtemisTCC/cadastro" class="text-center">Realize o cadastro</a>
    <a href="/ArtemisTCC/login" class="text-center">Realize o login</a>

  </div>
  <!-- /.login-box-body -->
</div>
<!-- /.login-box -->

<!-- jQuery 2.2.3 -->
<script src="../../ArtemisTCC/static/plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="../../ArtemisTCC/static/bootstrap/js/bootstrap.min.js"></script>
<!-- iCheck -->
<script src="../../ArtemisTCC/static/plugins/iCheck/icheck.min.js"></script>
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
