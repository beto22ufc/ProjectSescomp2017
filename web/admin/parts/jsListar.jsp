<%
    String dir = config.getServletContext().getInitParameter("dir");
%>
<script src="/<%=dir%>/static/plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- jQuery UI 1.11.4 -->

<!-- Bootstrap 3.3.6 -->
<script src="/<%=dir%>/static/bootstrap/js/bootstrap.min.js"></script>
<!-- Morris.js charts -->

<!-- DataTables -->
<script src="/<%=dir%>/static/plugins/datatables/jquery.dataTables.min.js"></script>
<script src="/<%=dir%>/static/plugins/datatables/dataTables.bootstrap.min.js"></script>

<!-- Slimscroll -->
<script src="/<%=dir%>/static/plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- FastClick -->
<script src="/<%=dir%>/static/plugins/fastclick/fastclick.js"></script>

<!-- AdminLTE App -->
<script src="/<%=dir%>/static/js/app.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="/<%=dir%>/static/js/demo.js"></script>

<script>
  $(function () {
    $("#example1").DataTable();
    $('#example2').DataTable({
      "paging": true,
      "lengthChange": false,
      "searching": false,
      "ordering": true,
      "info": true,
      "autoWidth": false
    });
  });
</script>