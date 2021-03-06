<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="artemis.beans.EventoBeans" %>
<%@page import="artemis.model.Facade" %>
<%@page import="artemis.model.ImageManipulation" %>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Artemis</title>
      
        <jsp:include page="/${dir}/theme/sistema/parts/css.jsp"></jsp:include>
    </head>
    <body style="overflow-x: hidden">
        <% String dir = config.getServletContext().getInitParameter("dir");
           Facade f = new Facade();
            List<EventoBeans> eventos = f.getPrimeirosEventos();
           String img = "/"+dir+"/static/plugins/index/images/sem-imagem.png";
        %>
        <jsp:include page="/${dir}/theme/sistema/header.jsp"></jsp:include>
         
        <!-- corpo -->
        <!-- Slider -->
		<div class="slider">
                    <ul class="rslides" id="slider">
                        <li>
                            <div class="w3ls-slide-text">
                                <h3>Seu gerenciador de eventos online</h3>
                           <!--     <a href="#" class="w3layouts-explore-all">Todas as categorias</a> -->
                            </div>
                        </li>
                        <li>
                            <div class="w3ls-slide-text">
                                    <h3>Encontre o que você precisa aqui</h3>
                                <!--    <a href="#" class="w3layouts-explore">Explore</a> -->
                            </div>
                        </li>
                        <li>
                            <div class="w3ls-slide-text">
                                    <h3>Faça seu evento acontecer</h3>
                                <!--    <a href="#" class="w3layouts-explore">Explore</a> -->
                            </div>
                        </li>
                        <li>
                            <div class="w3ls-slide-text">
                                <h3>Gerencie de maneira rápida e fácil</h3>
                            <!--    <a href="#" class="w3layouts-explore">Explore</a> -->
                            </div>
                        </li>

                    </ul>
		</div>
		<!-- //Slider -->
		<!-- content-starts-here -->
		<div class="main-content">
			<div class="w3-categories">
				<h3>Categorias</h3>
				<div class="container text-center">
					<div class="col-md-3">
						<div class="focus-grid w3layouts-boder1">
							<a class="btn-8" href="#">
								<div class="focus-border">
									<div class="focus-layout">
										<div class="focus-image"><i ></i></div>
										<h4 class="clrchg">Eventos Socias</h4>
									</div>
								</div>
							</a>
						</div>
					</div>
					<div class="col-md-3">
						<div class="focus-grid w3layouts-boder2">	
						<a class="btn-8" href="#">
							<div class="focus-border">
								<div class="focus-layout">
									<div class="focus-image"><i ></i></div>
									<h4 class="clrchg"> Eventos Profissionais</h4>
								</div>
							</div>
						</a>
					</div>
					</div>
					<div class="col-md-3">
					<div class="focus-grid w3layouts-boder3">
						<a class="btn-8" href="#">
							<div class="focus-border">
								<div class="focus-layout">
									<div class="focus-image"><i ></i></div>
									<h4 class="clrchg">Eventos Oficias</h4>
								</div>
							</div>
						</a>
					</div>	
					</div>
					<div class="col-md-3">
					<div class="focus-grid w3layouts-boder4">
						<a class="btn-8" href="#">
							<div class="focus-border">
								<div class="focus-layout">
									<div class="focus-image"><i ></i></div>
									<h4 class="clrchg">Eventos Técnicos-Administrativos</h4>
								</div>
							</div>
						</a>
					</div>	
					</div>
					<div class="col-md-3">
					<div class="focus-grid w3layouts-boder5">
						<a class="btn-8" href="#">
							<div class="focus-border">
								<div class="focus-layout">
									<div class="focus-image"><i></i></div>
									<h4 class="clrchg">Eventos Artísticos</h4>
								</div>
							</div>
						</a>
					</div>
					</div>
					<div class="col-md-3">
					<div class="focus-grid w3layouts-boder6">
						<a class="btn-8" href="#">
							<div class="focus-border">
								<div class="focus-layout">
									<div class="focus-image"><i ></i></div>
									<h4 class="clrchg">Eventos Culturais</h4>
								</div>
							</div>
						</a>
					</div>	
					</div>
					<div class="col-md-3">
						<div class="focus-grid w3layouts-boder7">
							<a class="btn-8" href="#">
								<div class="focus-border">
									<div class="focus-layout">
										<div class="focus-image"><i ></i></div>
										<h4 class="clrchg">Eventos Religiosos</h4>
									</div>
								</div>
							</a>
						</div>	
					</div> 
                                        <div class="col-md-3">
					<div class="focus-grid w3layouts-boder4">
						<a class="btn-8" href="#">
							<div class="focus-border">
								<div class="focus-layout">
									<div class="focus-image"><i ></i></div>
									<h4 class="clrchg">Outros Eventos</h4>
								</div>
							</div>
						</a>
					</div>	
					</div>
					<div class="clearfix"></div>
				</div>
			</div>
			<!-- section -->
			<div class="w3l-popular-ads"  >
				<section class="landing-hero landing-section--bg landing-section--bg-cover g-group g-group--full-width slide-text-position">
					<div class="g-grid l-block--padded-v-40 l-md-align-center l-sm-align-center">

					<!-- Hero Headline and subline (Hidden on small and medium screens) -->
						<div class="g-cell g-cell-12-12 g-cell-md-12-12 g-cell-lg-10-12">
							<div class="w3-categories">
								<h3 >Para todos os tipos de eventos</h3>
								<p style="text-align: center;margin-top: 2%;font-size: 20px;color: black; padding: 80px;">Atraia mais participantes para seu evento, personalize o hotsite, viralize nas redes sociais e divulgue seu evento. </p>
							</div>
						</div>
					<!-- END: Hero Headline and subline -->
					</div>
				</section>
			</div>
			<!-- most-popular-ads -->
			<div class="w3l-popular-ads">  
				<h3>Eventos</h3>
				 <div class="container">
					<!-- começo -->
					<% if(!eventos.isEmpty()){
                                            for(int i=0;i<eventos.size();i++){%>
						<div class="col-md-4 w3ls-portfolio-left">
                                                        <%if(!eventos.get(i).getSlideshow().isEmpty()){img = ImageManipulation.encodeImage(eventos.get(i).getSlideshow().get(eventos.get(i).getSlideshow().size()-1).getArquivo());}%>
							<div class="portfolio-img event-img">
                                                            <img src="<%=img%>" class="img-responsive" style="min-height: 170px;" alt="Banner do evento"/>
                                                            <div class="over-image"></div>
							</div>
							<div class="portfolio-description">
                                                            
                                                            <h4><a href="/<%=dir%>/evento/?e=<%=eventos.get(i).getNome().toLowerCase().replace(" ", "_")+"_"+eventos.get(i).getCodEvento() %>"><%=eventos.get(i).getNome()%></a></h4>
							   <p><%= eventos.get(i).getCategoria()%></p>
								<a href="/<%=dir%>/evento/?e=<%=eventos.get(i).getNome().toLowerCase().replace(" ", "_")+"_"+eventos.get(i).getCodEvento() %>">
									<span>Explore</span>
								</a>
							</div>
							<div class="clearfix"> </div>
						</div>
					<%}}else{%> 
                                            <p style="text-align: center;margin-top: 2%;font-size: 20px;color: black; padding: 80px;">Não existem eventos disponíveis no momento. </p>
                                        <%}%>
					<!-- fim -->
                                 </div>
                        </div>
					
			<div class="w3layouts-partners">
				<h3>Outros Projetos</h3>
                                    <div class="container text-center">
                                        <ul>
                                            <li><a href="https://nookdear.com/register"><img class="img-responsive" src="/<%=dir%>/static/plugins/index/images/p-1.png" alt=""></a></li>
                                        </ul>
                                    </div>
				</div>	
		<!--//partners-->	
		<!-- mobile app -->
			<div class="agile-info-mobile-app">
				<div class="container">
					<div class="col-md-5 w3-app-left">
						<a href="mobileapp.html"><img src="/<%=dir%>/static/plugins/index/images/app2.png" alt="imagem do app"></a>
					</div>
					<div class="col-md-7 w3-app-right">
						<h3>Baixe o app <span>Facilmente</span> e tenha o Artemis na palma da sua mão.</h3>
						<p>De forma fácil e rápida.</p>
						<div class="agileits-dwld-app">
							<h6>Em breve! 
							<!--<h6>Baixe o App : 
								<a href="#"><i class="fa fa-apple"></i></a>
								<a href="#"><i class="fa fa-windows"></i></a>
								<a href="#"><i class="fa fa-android"></i></a> -->
                                                        </h6><span style="color: orange"> Aguardem...</span>
						</div>
					</div>
					<div class="clearfix"></div>
				</div>
			</div>
			<!-- //mobile app -->
		</div>
                                        
                <!-- corpo -->
                <jsp:include page="/${dir}/theme/sistema/footer.jsp"></jsp:include>
                <jsp:include page="/${dir}/theme/sistema/parts/js.jsp"></jsp:include>
    </body>
</html>
