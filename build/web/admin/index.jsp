<%-- 
    Document   : index
    Created on : 31/07/2017, 08:52:04
    Author     : Wallison
--%>
<%@page import="artemis.model.Facade"%>
<%@page import="artemis.beans.PeriodoBeans"%>
<%@page import="artemis.beans.UsuarioBeans"%>
<%
    String dir = config.getServletContext().getInitParameter("dir");
    if(session.getAttribute("usuario") != null){
        Facade facade = new Facade();
%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Artemis | Painel do usuário</title>
  <jsp:include page="/${dir}/admin/parts/head.jsp"></jsp:include>
</head>
<%
%>
<body class="hold-transition skin-blue sidebar-mini" >
<div class="wrapper">
    <jsp:include page="/${dir}/admin/parts/header.jsp"></jsp:include>  
  <!-- Left side column. contains the logo and sidebar -->
  <jsp:include page="/${dir}/admin/parts/mainMenu.jsp"></jsp:include>
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
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
<script src="/<%=dir%>/static/plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- jQuery UI 1.11.4 -->

<!-- Bootstrap 3.3.6 -->
<script src="/<%=dir%>/static/bootstrap/js/bootstrap.min.js"></script>
<!-- Slimscroll -->
<script src="/<%=dir%>/static/plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- FastClick -->
<script src="/<%=dir%>/static/plugins/fastclick/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="/<%=dir%>/static/js/app.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="/<%=dir%>/static/js/demo.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.2/moment.min.js"></script>
<script src="/<%=dir%>/static/plugins/fullcalendar/fullcalendar.min.js"></script>
</body>
</html>
<% }else{
    response.sendRedirect("/"+dir+"/login");
} %>