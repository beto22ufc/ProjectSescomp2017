<%-- 
    Document   : cadastro
    Created on : 28/07/2017, 09:13:29
    Author     : Wallison
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
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Artemis | Cadastro</title>
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
<body class="hold-transition register-page">
<div class="register-box">
  <div class="register-logo">
      <a href="/ArtemisTCC/"><b>Artemis</b></a>
  </div  
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
  <div class="register-box-body">
      <p class="login-box-msg"><%=(request.getAttribute("msg")!= null) ? request.getAttribute("msg") : "Registro de novo membro" %></p>

    <form action="" method="post">
      <div class="form-group has-feedback">
          <input type="text" class="form-control" placeholder="Nome completo" name="nome" value="<%= (request.getParameter("nome")!= null) ? request.getParameter("nome") : "" %>">
        <span class="glyphicon glyphicon-user form-control-feedback"></span>
      </div>
      <div class="form-group has-feedback">
          <input type="email" class="form-control" placeholder="E-mail" name="email" value="<%= (request.getParameter("email")!= null) ? request.getParameter("email") : "" %>">
        <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
      </div>
      <div class="form-group has-feedback">
          <input type="text" class="form-control" placeholder="CPF ex.: 809.908.090-40" name="numerocpf" value="<%= (request.getParameter("numerocpf")!= null) ? request.getParameter("numerocpf") : "" %>">
        <span class="glyphicon glyphicon-user form-control-feedback"></span>
      </div>
      <div class="form-group has-feedback">
          <input type="date" class="form-control" placeholder="Data de nascimento" name="dataNascimento" value="<%= (request.getParameter("dataNascimento")!= null) ? request.getParameter("dataNascimento") : "" %>">
        <span class="glyphicon glyphicon-calendar form-control-feedback"></span>
      </div>
      <div class="form-group has-feedback">
          <input type="password" class="form-control" placeholder="Senha" name="senha" >
        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
      </div>
      <div class="form-group has-feedback">
        <input type="password" class="form-control" placeholder="Confime a senha" name="resenha">
        <span class="glyphicon glyphicon-log-in form-control-feedback"></span>
      </div>
      <div class="row">
        <div class="col-xs-8">
          <div class="checkbox icheck">
            <label>
              <input type="checkbox"> Eu aceito os <a href="#">termos</a>
            </label>
          </div>
        </div>
        <!-- /.col -->
        <div class="col-xs-4">
          <button type="submit" class="btn btn-primary btn-block btn-flat" name="cadastro" value="usuario">Cadastrar-se</button>
        </div>
        <!-- /.col -->
      </div>
    </form>

    <a href="/ArtemisTCC/login" class="text-center">Eu já sou um membro</a>
  </div>
  <!-- /.form-box -->
</div>
<!-- /.register-box -->

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


