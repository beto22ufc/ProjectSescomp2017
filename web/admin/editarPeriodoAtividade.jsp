<%-- 
    Document   : index
    Created on : 31/07/2017, 08:52:04
    Author     : Wallison
--%>
<%@page import="artemis.beans.UsuarioBeans"%>
<%
    String dir = config.getServletContext().getInitParameter("dir");
    if(session.getAttribute("usuario") != null && ((UsuarioBeans) session.getAttribute("usuario")).getTipo().contains("adminEvento")){
%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<%
   
%>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Artemis | Painel do usuário</title>
  <jsp:include page="/${dir}/admin/parts/head.jsp"></jsp:include>
</head>
<%
%>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
    <jsp:include page="/${dir}/admin/parts/header.jsp"></jsp:include>  
  <!-- Left side column. contains the logo and sidebar -->
  <jsp:include page="/${dir}/admin/parts/mainMenu.jsp"></jsp:include>
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <jsp:include page="/${dir}/admin/pags/editarPeriodoAtividade.jsp" ></jsp:include>
  </div>
  <!-- /.content-wrapper -->
    <jsp:include page="/${dir}/admin/parts/footer.jsp"></jsp:include>

  <!-- Control Sidebar -->
  <jsp:include page="/${dir}/admin/parts/control.jsp"></jsp:include>
  <!-- /.control-sidebar -->
  <!-- Add the sidebar's background. This div must be placed
       immediately after the control sidebar -->
  <div class="control-sidebar-bg"></div>
</div>
<!-- ./wrapper -->
<jsp:include page="/${dir}/admin/parts/js.jsp"></jsp:include>
<script>
    function formatar(mascara, documento){
        var i = documento.value.length;
        var saida = mascara.substring(0,1);
        var texto = mascara.substring(i)
        if (texto.substring(0,1) !== saida){
                documento.value += texto.substring(0,1);
        }
    }
</script>
</body>
</html>
<% }else{
        response.sendRedirect("/"+dir+"/login");
} %>