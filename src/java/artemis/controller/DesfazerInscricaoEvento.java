/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.controller;

import artemis.beans.EventoBeans;
import artemis.beans.InscricaoBeans;
import artemis.beans.UsuarioBeans;
import artemis.model.Evento;
import artemis.model.Facade;
import artemis.model.Inscricao;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Wallison
 */
@WebServlet(name = "DesfazerInscricao", urlPatterns = {"/desfazerInscricaoEvento"})
public class DesfazerInscricaoEvento extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String alert = "<script>alert(\'%data%\');</script>";
        String button = "";
        long codEvento = 0;
        long codInscricao = 0;
        try{
            if(request.getSession().getAttribute("usuario")!=null){
                UsuarioBeans usuario = (UsuarioBeans) request.getSession().getAttribute("usuario");
                Facade facade = new Facade(usuario);
                codEvento = Long.parseLong(request.getParameter("evento"));
                codInscricao = Long.parseLong(request.getParameter("inscricao"));
                EventoBeans evento = facade.getEvento(codEvento);
                InscricaoBeans inscricao = facade.getInscricao(codInscricao);
                System.out.println("Entrou aqui!");
                facade.removerInscricaoEvento(evento, inscricao);
                System.out.println("Entrou aqui!");
                alert = alert.replace("%data%", "Inscrição desfeita com sucesso!");
                button = "<a href=\"javascript:void(0);\" onclick=\"inscreveEvento("+codEvento+");\">Inscrever-se</a>";
                out.println(alert);
                out.println(button);
            }else{                
                alert = alert.replace("%data%", "Usuário não está autenticado!");
                button = "<a href=\"javascript:void(0);\" onclick=\"desfazInscricaoEvento("+codEvento+","+codInscricao+");\">Desfazer inscrição</a>";
                out.println(alert);
                out.println(button);
            }
        }catch(NumberFormatException e){
            alert = alert.replace("%data%", "Isso não é um código de evento!");
            button = "<a href=\"javascript:void(0);\" onclick=\"desfazInscricaoEvento("+codEvento+","+codInscricao+");\">Desfazer inscrição</a>";
            out.println(alert);
            out.println(button);
        }catch(NullPointerException e){
            alert = "<script>alert(\'"+e.getMessage()+"\');</script>";
            button = "<a href=\"javascript:void(0);\" onclick=\"desfazInscricaoEvento("+codEvento+","+codInscricao+");\">Desfazer inscrição</a>";
            out.println(alert);
            out.println(button);
        }catch(Exception e){
            alert = alert.replace("%data%", e.getMessage());
            button = "<a href=\"javascript:void(0);\" onclick=\"desfazInscricaoEvento("+codEvento+","+codInscricao+");\">Desfazer inscrição</a>";
            out.println(alert);
            out.println(button);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
