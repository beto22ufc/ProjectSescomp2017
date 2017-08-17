<%-- 
    Document   : js
    Created on : 02/08/2017, 15:48:16
    Author     : Wallison
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
   String dir = config.getServletContext().getInitParameter("dir");
%>
<!-- jQuery 2.2.3 -->
<script src="/<%=dir%>/static/plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script>
  $.widget.bridge('uibutton', $.ui.button);
</script>
<!-- Bootstrap 3.3.6 -->
<script src="/<%=dir%>/static/bootstrap/js/bootstrap.min.js"></script>
<!-- Morris.js charts -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
<script src="/<%=dir%>/static/plugins/morris/morris.min.js"></script>
<!-- Sparkline -->
<script src="/<%=dir%>/static/plugins/sparkline/jquery.sparkline.min.js"></script>
<!-- jvectormap -->
<script src="/<%=dir%>/static/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
<script src="/<%=dir%>/static/plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
<!-- jQuery Knob Chart -->
<script src="/<%=dir%>/static/plugins/knob/jquery.knob.js"></script>
<!-- daterangepicker -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.2/moment.min.js"></script>
<script src="/<%=dir%>/static/plugins/daterangepicker/daterangepicker.js"></script>
<!-- datepicker -->
<script src="/<%=dir%>/static/plugins/datepicker/bootstrap-datepicker.js"></script>
<!-- Bootstrap WYSIHTML5 -->
<script src="/<%=dir%>/static/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
<!-- Slimscroll -->
<script src="/<%=dir%>/static/plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- FastClick -->
<script src="/<%=dir%>/static/plugins/fastclick/fastclick.js"></script>
<!-- Select2 -->
<script src="/<%=dir%>/static/plugins/select2/select2.full.min.js"></script>
<!-- InputMask -->
<script src="/<%=dir%>/static/plugins/input-mask/jquery.inputmask.js"></script>
<script src="/<%=dir%>/static/plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
<script src="/<%=dir%>/static/plugins/input-mask/jquery.inputmask.extensions.js"></script>
<!-- date-range-picker -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.2/moment.min.js"></script>
<script src="/<%=dir%>/static/plugins/daterangepicker/daterangepicker.js"></script>
<!-- bootstrap datepicker -->
<script src="/<%=dir%>/static/plugins/datepicker/bootstrap-datepicker.js"></script>
<!-- bootstrap color picker -->
<script src="/<%=dir%>/static/plugins/colorpicker/bootstrap-colorpicker.min.js"></script>
<!-- bootstrap time picker -->
<script src="/<%=dir%>/static/plugins/timepicker/bootstrap-timepicker.min.js"></script>
<!-- iCheck 1.0.1 -->
<script src="/<%=dir%>/static/plugins/iCheck/icheck.min.js"></script>
<!-- AdminLTE App -->
<script src="/<%=dir%>/static/js/app.min.js"></script>
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<script src="/<%=dir%>/static/js/pages/dashboard.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="/<%=dir%>/static/js/demo.js"></script>
<script src="/<%=dir%>/static/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
<!-- DataTables -->
<script src="/<%=dir%>/static/plugins/datatables/jquery.dataTables.min.js"></script>
<script src="/<%=dir%>/static/plugins/datatables/dataTables.bootstrap.min.js"></script>
<script src="http://maps.googleapis.com/maps/api/js?sensor=false&amp;libraries=places"></script>
    <script src="/<%=dir%>/static/plugins/jquery.geocomplete.js"></script>
<script>
  $(function () {
    //bootstrap WYSIHTML5 - text editor
    $(".textarea").wysihtml5();
    $(".nis").click(function (){
        $(".novaInstituicao").toggle();
        e.preventDefault();
        return false;
    });
    $("#localizacao").geocomplete({
          details: "form",
          types: ["geocode", "establishment"],
        });

        $("#find").click(function(){
          $("#localizacao").trigger("geocode");
        });

    //Initialize Select2 Elements
    $(".select2").select2();

    //Datemask dd/mm/yyyy
    $("#datemask").inputmask("dd/mm/yyyy", {"placeholder": "dd/mm/yyyy"});
    //Datemask2 mm/dd/yyyy
    $("#datemask2").inputmask("mm/dd/yyyy", {"placeholder": "mm/dd/yyyy"});
    //Money Euro
    $("[data-mask]").inputmask();

    //Date range picker
    $('#reservation').daterangepicker();
    //Date range picker with time picker
    $('#reservationtime').daterangepicker({timePicker: true, timePickerIncrement: 30, format: 'MM/DD/YYYY h:mm A'});
    //Date range as a button
    $('#daterange-btn').daterangepicker(
        {
          ranges: {
            'Today': [moment(), moment()],
            'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
            'Last 7 Days': [moment().subtract(6, 'days'), moment()],
            'Last 30 Days': [moment().subtract(29, 'days'), moment()],
            'This Month': [moment().startOf('month'), moment().endOf('month')],
            'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
          },
          startDate: moment().subtract(29, 'days'),
          endDate: moment()
        },
        function (start, end) {
          $('#daterange-btn span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
        }
    );

    //Date picker
    $('#datepicker').datepicker({
      autoclose: true
    });

    //iCheck for checkbox and radio inputs
    $('input[type="checkbox"].minimal, input[type="radio"].minimal').iCheck({
      checkboxClass: 'icheckbox_minimal-blue',
      radioClass: 'iradio_minimal-blue'
    });
    //Red color scheme for iCheck
    $('input[type="checkbox"].minimal-red, input[type="radio"].minimal-red').iCheck({
      checkboxClass: 'icheckbox_minimal-red',
      radioClass: 'iradio_minimal-red'
    });
    //Flat red color scheme for iCheck
    $('input[type="checkbox"].flat-red, input[type="radio"].flat-red').iCheck({
      checkboxClass: 'icheckbox_flat-green',
      radioClass: 'iradio_flat-green'
    });

    //Colorpicker
    $(".my-colorpicker1").colorpicker();
    //color picker with addon
    $(".my-colorpicker2").colorpicker();

    //Timepicker
    $(".timepicker").timepicker({
      showInputs: false
    });

    $('#example2').DataTable({
      "paging": true,
      "lengthChange": false,
      "searching": false,
      "ordering": true,
      "info": true,
      "autoWidth": false
    });
  });
  function Atualizar(){window.location.reload();}
  function nis(){
    $(".novaInstituicao").toggle();
  }
  function ncs(){
    $(".novoCurso").toggle();
  }
  function ncss(){
    $(".novoCursoS").toggle();
  }
  function addPeriodo(){
         $('.periodos').append('<div class="form-group"><label for="dataInicio">Inicio</label>'+
         '<input type="date" class="form-control" id="dataInicio" placeholder="Data incio" name="dataInicio[]">'+
                    '<br /><input type="time" class="form-control" id="dataInicio" placeholder="Tempo inicio" name="tempoInicio[]">'+
                  '</div><div class="form-group"><label for="dataInicio">Termino</label>'+
                    '<input type="date" class="form-control" id="dataInicio" placeholder="Data incio" name="dataTermino[]">'+
                    '<br /><input type="time" class="form-control" id="dataInicio" placeholder="Tempo inicio" name="tempoTermino[]">'+
                  '</div>');

        return false;       
  }
</script>
