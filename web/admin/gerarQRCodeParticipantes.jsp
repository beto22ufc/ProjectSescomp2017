<%-- 
    Document   : index
    Created on : 31/07/2017, 08:52:04
    Author     : Wallison
--%>
<%@page import="artemis.model.Constantes"%>
<%@page import="artemis.model.ImageManipulation"%>
<%@page import="artemis.model.Facade"%>
<%@page import="artemis.beans.UsuarioBeans"%>
<%
    String dir = config.getServletContext().getInitParameter("dir");
    if(session.getAttribute("usuario") != null && ((UsuarioBeans) session.getAttribute("usuario")).getTipo().contains("adminEvento")){
        Facade f = new Facade();
        UsuarioBeans ub = (UsuarioBeans) session.getAttribute("usuario");
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
    <jsp:include page="/${dir}/admin/pags/gerarQRCodeParticipantes.jsp" ></jsp:include>
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
<script src="/<%=dir%>/static/js/qrcode.js"></script>
<script src="/<%=dir%>/static/js/dist/qart.js"></script>
<!-- Slimscroll -->
<script src="/<%=dir%>/static/plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- FastClick -->
<script src="/<%=dir%>/static/plugins/fastclick/fastclick.js"></script>

<!-- AdminLTE App -->
<script src="/<%=dir%>/static/js/app.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="/<%=dir%>/static/js/demo.js"></script>
    <script>
            $(document).ready(function() {
                var value = "<%=f.getUsuarioForQRCode(ub).replace("\n", "").replace("\r", "") %>";
                var filter = 'threshold';
                var imagePath = "<%=Constantes.URL%>/<%=dir%>/static/img/avatar-default.png";
                var version = 10;
                var imageSize = 75 + (version * 12) - 24;
                var bg = "#C2C";
                var size = "175";
                var fillType = 'scale_to_fit';

                var self = this;

                $('#image img').width(imageSize);

                function makeQR() {
                    // console.log('Current version:', version)
                    qrcode.qrcode.stringToBytes = qrcode.qrcode.stringToBytesFuncs['UTF-8']
                    var qr = qrcode.qrcode(version, 'H');
                    qr.addData(value);
                    try {
                      qr.make();

                    } catch (err) {
                      console.log('Version is low:', version)
                      console.log('Error:', err)
                    }
                    document.getElementById('qr').innerHTML = qr.createImgTag(3);
                }

                function makeQArt() {
                    new QArt({
                        value: value,
                        imagePath: imagePath,
                        filter: filter,
                        version: version,
                        background: bg,
                        size: size,
                        fillType: fillType
                    }).make(document.getElementById('combine'));
                }
                
                function getBase64(file, callback) {
                    var reader = new FileReader();
                    reader.readAsDataURL(file);
                    reader.onload = function () {
                        callback(reader.result);
                    };
                }
                $('#bg').keyup(function() {
                    bg = $(this).val();
                    makeQArt();
                });

                $('#size').keyup(function() {
                    size = $(this).val();
                    makeQArt();
                });

                $('#fillType').bind('change',function() {
                    fillType = $(this).val();
                    makeQArt();
                });


                $('#version').bind('keyup change click', function() {
                    console.log($('#version').val());
                    version = $('#version').val();
                    imageSize = 75 + (version * 12) - 24;
                    $('#image img').width(imageSize);
                    makeQR();
                    makeQArt();
                });


                $('#gerarQRCode').click(function() {
                    var regex = /data:(.*);base64,(.*)/gm;
                    var parts = regex.exec('<%=ImageManipulation.encodeImage(ub.getImagemPerfil()) %>');
                    imagePath = parts[0];
                    $('#image img').attr('src',imagePath);
                    makeQArt();
                    
                    var crachar = document.getElementById("crachar");
                    var context = crachar.getContext("2d");
                    context.font = "26px sans-serif";
                    context.fillText("<%=ub.getNome() %>", 100, 100);
                    var canvas_qr = $("#combine canvas");
                    var image = $("#image_test");
                    context.drawImage(image, 10, 10, 80, 130);
                    
                });
                $('input[type=radio]').click(function() {
                    filter = $(this).val();
                    makeQArt();
                });

                makeQR();
                makeQArt();
            });
        </script>
</body>
</html>
<% }else{
        response.sendRedirect("/"+dir+"/login");
} %>