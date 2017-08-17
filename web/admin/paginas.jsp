if(paginaNome.equals("criarEvento")){
    %>
    <jsp:include page="./pags/criarEvento.jsp"></jsp:include>
    <%
        }else if(paginaNome.equals("listarEventos")){
    %>
       <jsp:include page="./pags/listarEventos.jsp"></jsp:include> 
    <% 
        }
    %>
