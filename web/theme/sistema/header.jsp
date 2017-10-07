<%-- 
    Document   : header
    Created on : 31/08/2017, 16:55:09
    Author     : Usuario
--%>
<%@page import="artemis.beans.UsuarioBeans"%>
<!-- header -->
<%
    String dir = config.getServletContext().getInitParameter("dir");
%>
	<header>
            <!-- header-top-->
            <div class="w3ls-header"><!--header-one--> 
                <div class="w3ls-header-right">
                    <ul>
                        <%
                            if(session.getAttribute("usuario") !=null){
                        %>
                        <li class="dropdown head-dpdn">
                            <a href="/<%=dir%>/painelUsuario" aria-expanded="false"><i class="fa fa-user" aria-hidden="true"></i> <%=((UsuarioBeans) session.getAttribute("usuario")).getNome() %></a>
                        </li>
                        <li class="dropdown head-dpdn">
                            <a href="/<%=dir%>/sair" aria-expanded="false"><i class="fa fa-sign-out" aria-hidden="true"></i> Sair</a>
                        </li>
                        <%  }else{%>
                        <li class="dropdown head-dpdn">
                            <a href="/<%=dir%>/login" aria-expanded="false"><i class="fa fa-user" aria-hidden="true"></i> Login</a>
                        </li>

                        <li class="dropdown head-dpdn">
                                <a href="/<%=dir%>/cadastro"><i class="fa fa-user-plus" aria-hidden="true"></i> Cadastro</a>
                        </li>
                        <%  }%>
                    </ul>
                </div>

                <div class="clearfix"> </div> 
            </div>
            <!-- header-top-->
            <!-- header-bottom-->
            <div class="container">
                <div class="agile-its-header">
                    <div class="logo">
                        <h1><a href="/<%=dir%>/" style="color: orange;"><span style="color:black;">Ar</span>temis</a></h1>
                    </div>
                    <!--
                    <div class="agileits_search">
                        <form action="#" method="post">
                            <input name="Search" type="text" placeholder="Faça sua busca aqui..." required="" />
                            <select id="agileinfo_search" name="agileinfo_search" required="">
                                <option value="">Todas as categorias</option>
                                <option value="sociais">Eventos Socias</option>
                                <option value="profissiionais">Eventos Profissionais</option>
                                <option value="artisticos">Eventos Artísticos</option>
                                <option value="culturais">Eventos Culturais</option>
                                <option value="religiosos">Eventos Religiosos</option>
                            </select>
                            <button type="submit" class="btn btn-default" aria-label="Left Align">
                                <i class="fa fa-search" aria-hidden="true"> </i>
                            </button>
                        </form>
                    <!--<a class="post-w3layouts-ad" href="post-ad.html">Post Free Ad</a> 
                    </div>-->	
                    <div class="clearfix"></div>
                </div>
            </div>
	</header>
	<!-- //header -->
