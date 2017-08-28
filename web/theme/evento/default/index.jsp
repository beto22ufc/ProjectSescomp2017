
<%@page import="artemis.beans.InscricaoBeans"%>
<%@page import="artemis.beans.PeriodoBeans"%>
<%@page import="artemis.beans.ImagemBeans"%>
<%@page import="artemis.model.ImageManipulation"%>
<%@page import="artemis.beans.UsuarioBeans"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.List"%>
<%@page import="artemis.beans.AtividadeBeans"%>
<%-- 
    Document   : index
    Created on : 21/08/2017, 21:16:24
    Author     : Wallison
--%>

<%@page import="artemis.model.Facade"%>
<%@page import="artemis.beans.EventoBeans"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--A Design by W3layouts
Author: W3layout
Author URL: http://w3layouts.com
License: Creative Commons Attribution 3.0 Unported
License URL: http://creativecommons.org/licenses/by/3.0/
-->
<%
    String dir = config.getServletContext().getInitParameter("dir");
    UsuarioBeans usuario = null;
    if(session.getAttribute("usuario") != null ){
        usuario = (UsuarioBeans) session.getAttribute("usuario"); 
    }
    if(request.getParameter("e") != null){
        Facade facade = new Facade(usuario);
        EventoBeans evento = null;
        try{
            evento = facade.getEvento(facade.getCodFromParameter(request.getParameter("e")));
        }catch(NumberFormatException e){
            response.sendRedirect("/"+dir+"/404");
        }catch(NullPointerException e){
            response.sendRedirect("/"+dir+"/404");            
        }catch(Exception e){
            response.sendRedirect("/"+dir+"/404");             
        }
       
        
%>
<!DOCTYPE html>
<!--A Design by W3layouts
Author: W3layout
Author URL: http://w3layouts.com
License: Creative Commons Attribution 3.0 Unported
License URL: http://creativecommons.org/licenses/by/3.0/
-->
<!DOCTYPE html>
<html lang="pt">
<head>
<title><%=evento.getNome() %></title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="utf-8">
<meta name="keywords" content="<%=evento.getNome()+", "+evento.getDescricao()+", "+evento.getCategoria() %>"> 
<script type="text/javascript">
addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
<!-- bootstrap-css -->
<link href="/<%=dir %>/theme/evento/default/css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
<!--// bootstrap-css -->
<!-- css -->
<link rel="stylesheet" href="/<%=dir %>/theme/evento/default/css/style.css" type="text/css" media="all" />

<!--// css -->
<link rel="stylesheet" href="/<%=dir %>/theme/evento/default/css/lightbox.css"> 
<!-- fullCalendar 2.2.5-->
<link rel="stylesheet" href="../../ArtemisTCC/static/plugins/fullcalendar/fullcalendar.min.css">
<link rel="stylesheet" href="../../ArtemisTCC/static/plugins/fullcalendar/fullcalendar.print.css" media="print">
<!-- font-awesome icons -->
<link href="/<%=dir %>/theme/evento/default/css/font-awesome.css" rel="stylesheet"> 

<!-- //font-awesome icons -->

<!-- font -->
<link href="//fonts.googleapis.com/css?family=Roboto:100,100i,300,300i,400,400i,500,500i,700,700i,900,900i" rel="stylesheet">
<link href="//fonts.googleapis.com/css?family=Montserrat:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
<!-- //font -->
<script src="/<%=dir %>/theme/evento/default/js/jquery-1.11.1.min.js"></script>
<script src="/<%=dir %>/theme/evento/default/js/bootstrap.js"></script>
<script src="/<%=dir %>/theme/evento/default/js/script.js"></script>
<script type="text/javascript">
	jQuery(document).ready(function($) {
		$(".scroll").click(function(event){		
			event.preventDefault();
			$('html,body').animate({scrollTop:$(this.hash).offset().top},1000);
		});
	});
</script> 
<%
    List<ImagemBeans> slideshow = evento.getSlideshow();
    int img = ((int) Math.random()*(slideshow.size()));
%>
<style>
    
    .banner{
        <% if(slideshow.size() == 0){%>
	background: url(/<%=dir %>/theme/evento/default/images/1.jpg) no-repeat 0px 0px;
        <% }else{%>
        background: url(<%= ImageManipulation.encodeImage(slideshow.get(0).getArquivo()) %>) no-repeat 0px 0px;
        <% }%>
        background-size: cover;
        -webkit-background-size: cover;
        -moz-background-size: cover;
        -o-background-size: cover;
        -ms-background-size: cover;
    }
    .stats{
	<% if(slideshow.size() == 0){%>
	background: url(/<%=dir %>/theme/evento/default/images/1.jpg) no-repeat 0px 0px;
        <% }else{%>
        background: url(<%= ImageManipulation.encodeImage(slideshow.get(0).getArquivo()) %>) no-repeat 0px 0px;
        <% }%>
        background-size: cover;
        -webkit-background-size: cover;
        -moz-background-size: cover;
        -o-background-size: cover;
        -ms-background-size: cover;
    }
    .w3ls-about-right-img{
	<% if(slideshow.size() == 0){%>
	background: url(/<%=dir %>/theme/evento/default/images/1.jpg) no-repeat 0px 0px;
        <% }else{%>
        background: url(<%= ImageManipulation.encodeImage(slideshow.get(0).getArquivo()) %>) no-repeat 0px 0px;
        <% }%>
        background-size: cover;
        min-height: 360px;
    }
</style>
<!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
<![endif]-->
</head>
<body>
	<!-- banner -->
	<div class="banner">
			<div class="address-info">
				<div class="container">
					<div class="address-info-text">
						<p><i class="fa fa-map-marker" aria-hidden="true"></i> <%=evento.getLocalizacao().getNome() %></p>
					</div>
				</div>
			</div>
			<div class="banner-info">
				<div class="banner-info-text">
					<div class="container">
						<div class="agileits-logo">
							<h1><a href="./"><% if(evento.getNome().length()>=4){ %><%=evento.getNome().substring(0, evento.getNome().length()-2) %><span><%=evento.getNome().substring(evento.getNome().length()-2, evento.getNome().length()) %><%}else{%><%=evento.getNome() %><%}%></span></a></h1>
						</div>
						<div class="w3-border"> </div>
						<div class="w3layouts-banner-info">
                                                    <h2></h2>
							<div class="w3ls-button btn-inscricao-evento">
                                                            <%
                                                                boolean inscritoEvento = false;
                                                                InscricaoBeans inscricao = null;
                                                                if(usuario != null){
                                                                    List<InscricaoBeans> inscricoes = evento.getInscricoes();
                                                                    for(int i=0;i<inscricoes.size();i++){
                                                                        inscricao = inscricoes.get(i);
                                                                        inscritoEvento = (inscricao.getParticipante().equals(usuario));
                                                                        if(inscritoEvento){
                                                                            break;
                                                                        }
                                                                    }
                                                                }
                                                                if(!inscritoEvento){
                                                            %>
                                                            <a href="javascript:void(0);" onclick="inscreveEvento(<%=evento.getCodEvento() %>);">Inscrever-se</a>
                                                        
                                                            <%  }else{%>
                                                            <a href="javascript:void(0);" onclick="desfazInscricaoEvento(<%=evento.getCodEvento()+", "+inscricao.getCodInscricao() %>);">Desfazer inscrição</a>
                                                            <%  }%>
                                                        </div>
                                                </div>
					</div>
				</div>
				<div class="header-top">
					<div class="container">
						<div class="header-top-info">
							<nav class="navbar navbar-default">
								<!-- Brand and toggle get grouped for better mobile display -->
								<div class="navbar-header">
									<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
										<span class="sr-only">Toggle navigation</span>
										<span class="icon-bar"></span>
										<span class="icon-bar"></span>
										<span class="icon-bar"></span>
									</button>
								</div>

								<!-- Collect the nav links, forms, and other content for toggling -->
								<div class="collapse navbar-collapse nav-wil" id="bs-example-navbar-collapse-1">
									<nav>
										<ul class="nav navbar-nav">
											<li class="active"><a href="index.html">Inicio</a></li>
											<li><a href="#about" class="scroll">Sobre</a></li>
											<li><a href="#services" class="scroll">Atividades e Eventos</a></li>
											<li><a href="#gallery" class="scroll">Galeria</a></li>
											<li><a href="#team" class="scroll">Ministrantes</a></li>
											<li><a href="#news" class="scroll">Cronograma</a></li>
											<li><a href="#mail" class="scroll">Contato</a></li>
										</ul>
									</nav>
								</div>
								<!-- /.navbar-collapse -->
							</nav>
						</div>
					</div>
				</div>
			</div>
	</div>
	<!-- //banner -->
	<!-- modal -->
	<div class="modal about-modal fade" id="myModal" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header"> 
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>						
					<h4 class="modal-title">Fitness <span>In</span></h4>
				</div> 
				<div class="modal-body">
					<div class="agileits-w3layouts-info">
						<img src="/<%=dir %>/theme/evento/default/images/1.jpg" alt="" />
						<p>Duis venenatis, turpis eu bibendum porttitor, sapien quam ultricies tellus, ac rhoncus risus odio eget nunc. Pellentesque ac fermentum diam. Integer eu facilisis nunc, a iaculis felis. Pellentesque pellentesque tempor enim, in dapibus turpis porttitor quis. Suspendisse ultrices hendrerit massa. Nam id metus id tellus ultrices ullamcorper.  Cras tempor massa luctus, varius lacus sit amet, blandit lorem. Duis auctor in tortor sed tristique. Proin sed finibus sem</p>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- //modal -->
	<!-- about -->
	<div class="about" id="about">
		<div class="container">
			<div class="agileits-heading">
				<h3>Sobre nós</h3>
			</div>
			<div class="w3l-about-grids">
				<div class="col-md-6 w3ls-about-right">
					<div class="w3ls-about-right-img">
						
					</div>
				</div>
				<div class="col-md-6 w3ls-about-left">
					<div class="agileits-icon-grid">
						<div class="icon-left hvr-radial-out">
							<i class="fa fa-question" aria-hidden="true"></i>
						</div>
						<div class="icon-right">
							<h5><%=evento.getNome() %></h5>
							<p><%=evento.getDescricao() %>
                                                            <%=facade.getAtividadesEventosJSON(evento) %>
                                                        </p>
						</div>
						<div class="clearfix"> </div>
					</div>
				</div>
				<div class="clearfix"> </div>
			</div>
		</div>
	</div>
	<!-- //about -->
	<!-- services -->
	<div class="services" id="services">
		<div class="container">
			<div class="agileits-heading">
				<h3>Atividades e Eventos</h3>
			</div>
			<div class="wthree-services-grids">
                            <%
                                List<AtividadeBeans> atividades = evento.getAtividades();
                                List<EventoBeans> eventos = evento.getEventos();
                                for(int i=0;i<atividades.size();i++){
                                    AtividadeBeans atividade = atividades.get(i);                                
                            %>
				<div class="col-sm-3 wthree-services">
					<div class="wthree-services-grid">
						<div class="wthree-services-info">
							<i class="fa fa-puzzle-piece" aria-hidden="true"></i>
							<h4><%=atividade.getNome() %></h4>
							<div class="w3ls-border"> </div>
						</div>
						<div class="wthree-services-captn">
							<h4><%=atividade.getNome() %></h4>
							<p><%=atividade.getDescricao()%></p>
						</div>
					</div>
				</div>
				<%}%>
				<div class="clearfix"> </div>
			</div>
			<div class="wthree-services-grids services-grids1">
                                <%
                                    for(int i=0;i<eventos.size();i++){
                                        EventoBeans e = eventos.get(i);
                                %>
				<div class="col-sm-3 wthree-services">
					<div class="wthree-services-grid">
						<div class="wthree-services-info">
							<i class="fa fa-calendar" aria-hidden="true"></i>
							<h4><%=e.getNome() %></h4>
							<div class="w3ls-border"> </div>
						</div>
						<div class="wthree-services-captn">
							<h4><%=e.getNome() %></h4>
                                                        <p><%=(e.getDescricao().length()>64) ? e.getDescricao().substring(0, 64) : e.getDescricao() %></p>
						</div>
					</div>
				</div>
                                <%
                                    }
                                %>
				<div class="clearfix"> </div>
                        </div>
		</div>
	</div>
	<!-- //services -->
	<!-- gallery -->
	<div id="gallery" class="gallery">
		<div class="container"> 
			<div class="agileits-heading">
				<h3>Galeria</h3>
			</div>
			<div class="gallery-w3lsrow">
                            <%
                                List<ImagemBeans> galeria = evento.getGaleria();
                                if(galeria.size() == 0){
                            %>
				<div class="col-sm-3 col-xs-4 gallery-grids">
                                    <div class="w3ls-hover">
                                        <a href="/<%=dir %>/theme/evento/default/images/1.jpg" data-lightbox="example-set" data-title="Nenhuma legenda">
                                            <img src="/<%=dir %>/theme/evento/default/images/g1.jpg" class="img-responsive zoom-img" alt=""/>
                                            <div class="view-caption">
                                                <h5>Sem imagens para mostrar</h5>
                                                <i class="fa fa-search-plus" aria-hidden="true"></i>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                            <%
                                }else{
                                    for(int i=0;i<galeria.size();i++){
                                        ImagemBeans imagem = galeria.get(i);
                            %>
                                <div class="w3ls-hover">
                                    <a href="<%=ImageManipulation.encodeImage(imagem.getArquivo()) %>" data-lightbox="example-set" data-title="<%=imagem.getDescricao() %>">
                                        <img src="<%=ImageManipulation.encodeImage(imagem.getArquivo()) %>" class="img-responsive zoom-img" alt="" style="width: 426px; height: 640px; float: left"/>
                                        <div class="view-caption">
                                            <h5>Imagem <%=i %></h5>
                                            <i class="fa fa-search-plus" aria-hidden="true"></i>
                                        </div>
                                    </a>
                                </div>
                            <%      }
                                }%>
				<div class="clearfix"> </div> 
			</div>
			<!--  light box js -->
			<script src="/<%=dir %>/theme/evento/default/js/lightbox-plus-jquery.min.js"> </script> 
			<!-- //light box js--> 
		</div> 
	</div>
	<!-- //gallery -->
	<!-- stats -->
	<div class="stats jarallax">
		<div class="container">
			<div class="col-md-3 w3_counter_grid">
				<div class="w3_agileits_counter_grid">
					<i class="fa fa-umbrella" aria-hidden="true"></i>
				</div>
				<p class="counter">1,965</p>
				<h3>Orders Completed</h3>
			</div>
			<div class="col-md-3 w3_counter_grid">
				<div class="w3_agileits_counter_grid">
					<i class="fa fa-users" aria-hidden="true"></i>
				</div>
				<p class="counter">432</p>
				<h3>Crew Members</h3>
			</div>
			<div class="col-md-3 w3_counter_grid">
				<div class="w3_agileits_counter_grid">
					<i class="fa fa-comments" aria-hidden="true"></i>
				</div>
				<p class="counter">690</p>
				<h3>Million Man-hours</h3>
			</div>
			<div class="col-md-3 w3_counter_grid">
				<div class="w3_agileits_counter_grid">
					<i class="fa fa-book" aria-hidden="true"></i>
				</div>
				<p class="counter">124</p>
				<h3>Counties Covered</h3>
			</div>
			<div class="clearfix"> </div>
		</div>
	</div>
	<!-- //stats -->
	<!-- team -->
	<div id="team" class="team">
		<div class="container">	
			<div class="agileits-heading">
				<h3>Ministrantes</h3>
			</div>			
			<div class="teamw3-agileinfo">
                                <%
                                    List<UsuarioBeans> ministrantes = facade.getMinistrantes(evento);
                                    for(int i=0;i<ministrantes.size();i++){
                                        UsuarioBeans ub = ministrantes.get(i);
                                    
                                %>
				<div class="col-md-3 col-xs-6 team-wthree-grid">
					<div class="btm-right">
                                            <%
                                                if (ub.getImagemPerfil() == null) {
                                            %>
                                           <img src="../../<%=dir%>/static/img/avatar-default.png" class="img-circle" alt="User default Image">
                                            <%
                                            } else {
                                            %>
                                            <img src="<%=ImageManipulation.encodeImage(ub.getImagemPerfil())%>" alt="User <%=ub.getNome() %> Image" />
                                            <%  }%>
						<div class="w3social-icons captn-icon"> 
							<ul>
								<li><a href="#"><i class="fa fa-facebook"></i></a></li>
								<li><a href="#"><i class="fa fa-google-plus"></i></a></li> 
								<li><a href="#"><i class="fa fa-twitter"></i></a></li> 
							</ul>
						</div>
						<div class="captn">
							<h4><%=ub.getNome() %></h4>	
						</div>
					</div>
				</div>
                                <%}%>
				<div class="clearfix"> </div>
			</div>
		</div>
	</div>
	<!-- //team -->
	<!-- news -->
	<div class="news" id="news">
		<div class="container">  
			<div class="agileits-heading">
				<h3>Cronograma</h3>
			</div>
			<div class="news-agileinfo"> 
                            <div id="calendar"></div>
                            <div class="clearfix"> </div>
			</div>
		</div>
	</div>
	<!-- //news -->
	<!-- contact -->
	<div class="contact" id="mail">
		<div class="container"> 
			<div class="agileits-heading">
				<h3>Contact Us</h3>
			</div>
			<div class="contact-w3ls-row">
				<div class="w3agile-map">
					<iframe src="https://www.google.com/maps/embed?pb=!1m10!1m8!1m3!1d86258.20905457705!2d-82.56985214706441!3d36.53988771087049!3m2!1i1024!2i768!4f13.1!5e0!3m2!1sen!2sin!4v1463030942772" allowfullscreen=""></iframe>
				</div>
				<div class="wthree-contact-form">
					<form action="#" method="post">
						<div class="col-md-5 col-sm-5 agileits-contact-right">
							<textarea name="Message" placeholder="Message" required=""></textarea>
						</div>
						<div class="col-md-7 col-sm-7 agileits-contact-left">
							<input type="text" name="First Name" placeholder="First Name" required="">
							<input type="text" class="email" name="Last Name" placeholder="Last Name" required="">
							<input type="text" name="Number" placeholder="Mobile Number" required="">
							<input type="email"  class="email" name="Email" placeholder="Email" required="">
							<input type="submit" value="SUBMIT">
						</div> 
						<div class="clearfix"> </div> 
					</form>
				</div>
			</div>  
		</div> 
	</div>
	<!-- contact -->
	<!-- footer -->
	<div class="footer">
		<div class="container">
			<div class="agile_footer_copy">
				<div class="w3agile_footer_grids">
					<div class="col-md-4 w3agile_footer_grid">
						<h3>Sobre nós</h3>
						<p><%=evento.getDescricao() %> </span></p>
					</div>
					<div class="col-md-4 w3agile_footer_grid">
						<h3>Informações de contato</h3>
						<ul>
							<li><i class="fa fa-map" aria-hidden="true"></i> <%=evento.getLocalizacao().getNome() %></li>
                                                        <li><i class="fa fa-envelope" aria-hidden="true"></i> <a href="mailto:<%=evento.getEmail() %>"><%=evento.getEmail() %></a></li>
						</ul>
					</div>
					<div class="col-md-4 w3agile_footer_grid w3agile_footer_grid1">
						<h3>Navegação</h3>
						<ul>
							<li><i class="fa fa-angle-right" aria-hidden="true"></i> <a href="#about" class="scroll">Sobre</a></li>
							<li><i class="fa fa-angle-right" aria-hidden="true"></i> <a href="#services" class="scroll">Atividades</a></li>
							<li><i class="fa fa-angle-right" aria-hidden="true"></i> <a href="#gallery" class="scroll">Galeria</a></li>
							<li><i class="fa fa-angle-right" aria-hidden="true"></i> <a href="#team" class="scroll">Ministrantes</a></li>
							<li><i class="fa fa-angle-right" aria-hidden="true"></i> <a href="#news" class="scroll">Cronograma</a></li>
							<li><i class="fa fa-angle-right" aria-hidden="true"></i> <a href="#mail" class="scroll">Contato</a></li>
						</ul>
					</div>
					<div class="clearfix"> </div>
				</div>
			</div>
			<div class="w3_agileits_copy_right_social">
				<div class="agileits_w3layouts_copy_right">
                                    <p>&copy; <%=LocalDate.now().getYear()+" Artemis/"+evento.getNome() %>. Todos os direitos reservados | Design by <a href="http://w3layouts.com/">W3layouts</a></p>
				</div>
				<div class="clearfix"> </div>
			</div>
		</div>
	</div>
	<!-- //footer -->
	<script src="/<%=dir %>/theme/evento/default/js/jarallax.js"></script>
	<script src="/<%=dir %>/theme/evento/default/js/SmoothScroll.min.js"></script>
	<script type="text/javascript">
		/* init Jarallax */
		$('.jarallax').jarallax({
			speed: 0.5,
			imgWidth: 1366,
			imgHeight: 768
		})
	</script>
	<script src="/<%=dir %>/theme/evento/default/js/responsiveslides.min.js"></script>
	<script type="text/javascript" src="/<%=dir %>/theme/evento/default/js/move-top.js"></script>
	<script type="text/javascript" src="/<%=dir %>/theme/evento/default/js/easing.js"></script>
	<!-- here stars scrolling icon -->
	<script type="text/javascript">
		$(document).ready(function() {
			/*
				var defaults = {
				containerID: 'toTop', // fading element id
				containerHoverID: 'toTopHover', // fading element hover id
				scrollSpeed: 1200,
				easingType: 'linear' 
				};
			*/
								
			$().UItoTop({ easingType: 'easeOutQuart' });
								
			});
	</script>
	<!-- //here ends scrolling icon -->
	<!-- Tabs-JavaScript -->
	<!-- stats -->
	<script src="/<%=dir %>/theme/evento/default/js/jquery.waypoints.min.js"></script>
	<script src="/<%=dir %>/theme/evento/default/js/jquery.countup.js"></script>
        <!-- fullCalendar 2.2.5 -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.2/moment.min.js"></script>
        <script src="../../ArtemisTCC/static/plugins/fullcalendar/fullcalendar.min.js"></script>
		<script>
			$('.counter').countUp();
		</script>
	<!-- //stats -->
        <!-- Page specific script -->
<script>
  $(function () {

    /* initialize the external events
     -----------------------------------------------------------------*/
    function ini_events(ele) {
      ele.each(function () {

        // create an Event Object (http://arshaw.com/fullcalendar/docs/event_data/Event_Object/)
        // it doesn't need to have a start or end
        var eventObject = {
          title: $.trim($(this).text()) // use the element's text as the event title
        };

        // store the Event Object in the DOM element so we can get to it later
        $(this).data('eventObject', eventObject);

        // make the event draggable using jQuery UI
        $(this).draggable({
          zIndex: 1070,
          revert: true, // will cause the event to go back to its
          revertDuration: 0  //  original position after the drag
        });

      });
    }

    ini_events($('#external-events div.external-event'));

    /* initialize the calendar
     -----------------------------------------------------------------*/
    //Date for the calendar events (dummy data)
    <%
        PeriodoBeans inicial = facade.getMenorPeriodo(evento);
        if(inicial != null){
    %>
        var date = date = new Date(<%=inicial.getInicio().getYear()%>, <%=inicial.getInicio().getMonthValue()%>, <%=inicial.getInicio().getDayOfMonth()%>);
    <%  }%>
    $('#calendar').fullCalendar({
      header: {
        left: 'prev,next today',
        center: 'title',
        right: 'month,agendaWeek,agendaDay'
      },
      buttonText: {
        today: 'Hoje',
        month: 'Mês',
        week: 'Semana',
        day: 'Dia'
      },
      //Random default events
      events: [
        <%=facade.getAtividadesEventosJSON(evento) %>
      ],
      editable: false,
      droppable: false, // this allows things to be dropped onto the calendar !!!
      drop: function (date, allDay) { // this function is called when something is dropped

        // retrieve the dropped element's stored Event Object
        var originalEventObject = $(this).data('eventObject');

        // we need to copy it, so that multiple events don't have a reference to the same object
        var copiedEventObject = $.extend({}, originalEventObject);

        // assign it the date that was reported
        copiedEventObject.start = date;
        copiedEventObject.allDay = allDay;
        copiedEventObject.backgroundColor = $(this).css("background-color");
        copiedEventObject.borderColor = $(this).css("border-color");

        // render the event on the calendar
        // the last `true` argument determines if the event "sticks" (http://arshaw.com/fullcalendar/docs/event_rendering/renderEvent/)
        $('#calendar').fullCalendar('renderEvent', copiedEventObject, true);

        // is the "remove after drop" checkbox checked?
        if ($('#drop-remove').is(':checked')) {
          // if so, remove the element from the "Draggable Events" list
          $(this).remove();
        }

      }
    });

  });
</script>
</body>	
</html>
<%}else{
    response.sendRedirect("/"+dir+"/404");
}%>