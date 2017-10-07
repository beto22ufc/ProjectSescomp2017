<%-- 
    Document   : index
    Created on : 04/09/2017, 21:57:53
    Author     : Wallison
--%>

<%@page import="java.time.LocalDate"%>
<%@page import="artemis.model.ImageManipulation"%>
<%@page import="artemis.beans.UsuarioBeans"%>
<%@page import="artemis.model.Facade"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--A Design by W3layouts
Author: W3layout
Author URL: http://w3layouts.com
License: Creative Commons Attribution 3.0 Unported
License URL: http://creativecommons.org/licenses/by/3.0/
-->
<%
    String dir  = config.getServletContext().getInitParameter("dir");
    Facade facade = new Facade();
    UsuarioBeans  usuario = null;
    try{
        usuario = facade.getUsuario(facade.getCodFromParameter(request.getParameter("u")));
    }catch(NumberFormatException e){
        response.sendRedirect("/"+dir+"/404");
    }catch(NullPointerException e){
        response.sendRedirect("/"+dir+"/404");
    }catch(Exception e){
        response.sendRedirect("/"+dir+"/404");
    }
%>
<html>
<head>
<title>Artemis | Perfil usuário</title>
<link href="/<%=dir %>/theme/sistema/perfil/css/bootstrap.css" rel='stylesheet' type='text/css' />
<!-- jQuery (necessary JavaScript plugins) -->
<script src="/<%=dir %>/theme/sistema/perfil/js/jquery.min.js"></script>
<!-- Custom Theme files -->
 <link href="/<%=dir %>/theme/sistema/perfil/css/dashboard.css" rel="stylesheet">
<link href="/<%=dir %>/theme/sistema/perfil/css/style.css" rel='stylesheet' type='text/css' />

<!-- Custom Theme files -->
<!--//theme-style-->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="" />
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
<link href='http://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700' rel='stylesheet' type='text/css'>
<link href='http://fonts.googleapis.com/css?family=Varela+Round' rel='stylesheet' type='text/css'>
<!-- start menu -->
</head>
<body>
    
<!-- header -->
<div class="col-sm-3 col-md-2 sidebar">
		 <div class="sidebar_top">
			<h1><%=usuario.getNome() %></h1> 
                        <% if(usuario.getImagemPerfil()!=null){%>
                        <img src="<%=ImageManipulation.encodeImage(usuario.getImagemPerfil()) %>" alt=""/>
                        <%}else{%>
                        <img src="/<%=dir %>/theme/sistema/perfil/images/avt.png" alt=""/>
                        <%}%>
		 </div>
		<div class="details">	 
			 <h3>EMAIL</h3>
                         <p><a href="mailto:<%=usuario.getEmail() %>"><%=usuario.getEmail() %></a></p>			 
		</div>
		<div class="clearfix"></div>
</div>
<!---->
<link href="/<%=dir %>/theme/sistema/perfil/css/popuo-box.css" rel="stylesheet" type="text/css" media="all"/>
<script src="/<%=dir %>/theme/sistema/perfil/js/jquery.magnific-popup.js" type="text/javascript"></script>
	<!---//pop-up-box---->			
<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
	 <div class="content">
		 <div class="details_header">
			 <ul>
                             <li><a href="/<%=dir %>/perfil/?u=<%=usuario.getNome().toLowerCase().replace(" ", "_")+"_"+usuario.getCodUsuario()%>"><span class="glyphicon glyphicon-file" aria-hidden="true"></span>Inicio</a></li>
                             <% if(usuario.getLattes() !=null){%><li><a href="<%=usuario.getLattes() %>"><span class="glyphicon glyphicon-print" aria-hidden="true"></span>Lattes</a></li><%}%>
                             <!--<li><a href="/<%=dir %>/perfil/contato/?u=<%=usuario.getNome().toLowerCase().replace(" ", "_")+"_"+usuario.getCodUsuario()%>"><span class="glyphicon glyphicon-envelope" aria-hidden="true"></span>Envie-me um e-mail</a></li>
				 --><li><a class="play-icon popup-with-zoom-anim" href="#small-dialog"><span class="glyphicon glyphicon-picture" aria-hidden="true"></span>Ver foto</a></li>
				 <div id="small-dialog" class="mfp-hide">
                                     <% if(usuario.getImagemPerfil()!=null){%>
                                     <img src="<%=ImageManipulation.encodeImage(usuario.getImagemPerfil()) %>" alt=""/>
                                     <%}else{%>
                                     <img src="/<%=dir %>/theme/sistema/perfil/images/avt.png" alt=""/>
                                     <%}%>
				 </div>
				 <script>
						$(document).ready(function() {
						$('.popup-with-zoom-anim').magnificPopup({
							type: 'inline',
							fixedContentPos: false,
							fixedBgPos: true,
							overflowY: 'auto',
							closeBtnInside: true,
							preloader: false,
							midClick: true,
							removalDelay: 300,
							mainClass: 'my-mfp-zoom-in'
						});
																						
						});
				</script>
			 </ul>
		 </div>
		 <div class="company">
			 <h3 class="clr1">Formação</h3>
			 <div class="company_details">
				 
				 <p class="cmpny1"><%=usuario.getFormacao() %></p>
			 </div>
		 </div>
		 <div class="skills">
			 <h3 class="clr2">Ocupação</h3>
			 <div class="skill_info">
			 <p><%=usuario.getOcupacao()%></p>
			 </div>
			 <div class="skill_list">
                                <% if(usuario.getContasSociais() !=null){%>
				 <div class="skill1">
					 <h4>Social links</h4>
					 <ul>					 
                                             <li><a href="<%=usuario.getContasSociais().getNookdear() %>">Nookdear</a></li>
                                            <li><a href="<%=usuario.getContasSociais().getFacebook()%>">Facebook</a></li>
                                            <li><a href="<%=usuario.getContasSociais().getTwitter()%>">Twitter</a></li>
                                            <li><a href="<%=usuario.getContasSociais().getGplus()%>">Google +</a></li>
                                            <li><a href="<%=usuario.getContasSociais().getLinkedin()%>">LinkedIn</a></li>
					 </ul>
				 </div>
                                 <%}%>
				 <div class="clearfix"></div>
			 </div>
		 </div>
		 
		 <div class="copywrite">
			 <p>© <%=LocalDate.now().getYear() %> Todos os direitos reservados Artemis | Design by <a href="http://w3layouts.com/" target="_blank">W3layouts</a> </p>
		 </div>
	 </div>
</div>
<!---->
</body>
</html>