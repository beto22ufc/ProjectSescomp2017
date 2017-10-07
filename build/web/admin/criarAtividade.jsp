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
    <jsp:include page="/${dir}/admin/pags/criarAtividade.jsp" ></jsp:include>
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

<!-- Bootstrap 3.3.6 -->
<script src="/<%=dir%>/static/bootstrap/js/bootstrap.min.js"></script>

<!-- Bootstrap WYSIHTML5 -->
<script src="/<%=dir%>/static/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
<!-- Slimscroll -->
<script src="/<%=dir%>/static/plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- FastClick -->
<script src="/<%=dir%>/static/plugins/fastclick/fastclick.js"></script>
<!-- Select2 -->
<script src="/<%=dir%>/static/plugins/select2/select2.full.min.js"></script>
<!-- InputMask -->
<!-- AdminLTE App -->
<script src="/<%=dir%>/static/js/app.min.js"></script>

<script src="/<%=dir%>/static/js/demo.js"></script>
<script src="/<%=dir%>/static/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
<!-- DataTables -->

<script>
  $(function () {
    //bootstrap WYSIHTML5 - text editor
    $(".textarea").wysihtml5();
    //Initialize Select2 Elements
    $(".select2").select2();
    
  });
  function addPeriodo(){
         $('.periodos').append('<div class="form-group"><label for="dataInicio">Inicio</label>'+
         '<input type="text" class="form-control" id="dataInicio" placeholder="Data incio" name="dataInicio[]"  maxlength="10" onkeypress="formatar(\'##/##/####\',this)">'+
                    '<br /><input type="text" class="form-control" id="dataInicio" placeholder="Tempo inicio" name="tempoInicio[]" maxlength="5" onkeypress="formatar(\'##:##\',this)">'+
                  '</div><div class="form-group"><label for="dataInicio">Termino</label>'+
                    '<input type="text" class="form-control" id="dataInicio" placeholder="Data incio" name="dataTermino[]" maxlength="10" onkeypress="formatar(\'##/##/####\',this)">'+
                    '<br /><input type="text" class="form-control" id="dataInicio" placeholder="Tempo inicio" name="tempoTermino[]" maxlength="5" onkeypress="formatar(\'##:##\',this)">'+
                  '</div>');

        return false;       
  }
</script>
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