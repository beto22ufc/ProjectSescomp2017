<%-- 
    Document   : cadastro
    Created on : 28/07/2017, 09:13:29
    Author     : Wallison
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
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Artemis | Login</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <!-- Bootstrap 3.3.6 -->
  <link rel="stylesheet" href="../../static/bootstrap/css/bootstrap.min.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../static/css/AdminLTE.min.css">
  <!-- iCheck -->
  <link rel="stylesheet" href="../../static/plugins/iCheck/square/blue.css">

  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->
</head>
<body class="hold-transition login-page" >
<div class="login-box">
  <div class="login-logo">
      <a href="/<%=dir %>/"><b>Artemis</b></a>
  </div>
  <!-- /.login-logo -->
  <div class="login-box-body">
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
    <p class="login-box-msg" style="color: red;"><%= (request.getAttribute("msg") != null) ? request.getAttribute("msg") : "Faça o login e inicie uma sessão"%></p>
    
    <form action="" method="post">
      <div class="form-group has-feedback">
        <input type="email" class="form-control" placeholder="E-mail" name="email">
        <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
      </div>
      <div class="form-group has-feedback">
        <input type="password" class="form-control" placeholder="Password" name="senha">
        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
      </div>
      <div class="row">
        <!-- /.col -->
        <div class="col-xs-4" style="float: right;">
            <button type="submit" class="btn btn-primary btn-block btn-flat" name="login" value="usuario">Entrar</button>
        </div>
        <!-- /.col -->
      </div>
    </form>
    <!-- /.social-auth-links -->

    <a href="#">Esqueci minha senha</a><br>
    <a href="/<%=dir %>/cadastro" class="text-center">Registar novo menbro</a>

  </div>
  <!-- /.login-box-body -->
</div>
<!-- /.login-box -->

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
        RequestDispatcher rd = request.getRequestDispatcher("/");
        rd.forward(request, response);
        
        }%>

