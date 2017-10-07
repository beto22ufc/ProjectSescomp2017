<%-- 
    Document   : certificadoEvento
    Created on : 05/09/2017, 16:07:24
    Author     : Wallison
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Artemis | Certificado Evento</title>
    </head>
    <body>
        <%
            String dir = config.getServletContext().getInitParameter("dir");
            String modelo = "default";
            RequestDispatcher rd = request.getRequestDispatcher("/theme/certificado/evento/"+modelo+"/index.jsp");
            rd.include(request, response);
        %>
    </body>
</html>
