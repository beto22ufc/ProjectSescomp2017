<%-- 
    Document   : index
    Created on : 31/07/2017, 08:52:04
    Author     : Wallison
--%>
<%@page import="artemis.model.Facade"%>
<%@page import="artemis.beans.UsuarioBeans"%>
<%
    String dir = config.getServletContext().getInitParameter("dir");
    if(session.getAttribute("usuario") != null && (((UsuarioBeans) session.getAttribute("usuario")).getTipo().contains("adminEvento") || ((UsuarioBeans) session.getAttribute("usuario")).getTipo().contains("organizador"))){
    Facade f = new Facade();
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
    <jsp:include page="/${dir}/admin/pags/marcarPresencaQRCodeAtividade.jsp" ></jsp:include>
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
<script src="/<%=dir%>/static/js/build/qcode-decoder.min.js"></script>
<!-- Slimscroll -->
<script src="/<%=dir%>/static/plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- FastClick -->
<script src="/<%=dir%>/static/plugins/fastclick/fastclick.js"></script>

<!-- AdminLTE App -->
<script src="/<%=dir%>/static/js/app.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="/<%=dir%>/static/js/demo.js"></script>
<script type="text/javascript">

  (function () {
    'use strict';

    var qr = new QCodeDecoder();

    if (!(qr.isCanvasSupported() && qr.hasGetUserMedia())) {
      alert('Your browser doesn\'t match the required specs.');
      throw new Error('Canvas and getUserMedia are required');
    }

    var video = document.querySelector('video');
    var reset = document.querySelector('#reset');
    var stop = document.querySelector('#stop');


    function resultHandler (err, result) {
      if (err)
        return console.log(err.message);

      alert(result);
      marcarPresenca(<%=f.getCodFromParameter(request.getParameter("a")) %>, result);
    }

    // prepare a canvas element that will receive
    // the image to decode, sets the callback for
    // the result and then prepares the
    // videoElement to send its source to the
    // decoder.

    qr.decodeFromCamera(video, resultHandler);


    // attach some event handlers to reset and
    // stop whenever we want.

    reset.onclick = function () {
      qr.decodeFromCamera(video, resultHandler);
    };

    stop.onclick = function () {
      qr.stop();
    };

  })();
    function marcarPresenca(atividade, p){
        if(isNumeric(atividade) && (atividade>0)){
            $.get("/ArtemisTCC/MarcaPresencaAtividadeQRCode", {atividade: atividade, p: p
            }, function (data) {
                alert(data);
            });
        }else{
            alert("Atividade e/ou inscrição inválidas!");
        }
    }
    function isNumeric(num){
        return (typeof num === "number");
    }
  </script>
</body>
</html>
<% }else{
        response.sendRedirect("/"+dir+"/login");
} %>