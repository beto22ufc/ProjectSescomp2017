/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.controller;

import artemis.beans.AtividadeBeans;
import artemis.beans.InscricaoBeans;
import artemis.beans.UsuarioBeans;
import artemis.model.Facade;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Wallison
 */
@WebServlet(name = "MarcaPresencaAtividadeQRCode", urlPatterns = {"/MarcaPresencaAtividadeQRCode"})
public class MarcaPresencaAtividadeQRCode extends HttpServlet {

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
        try{
            
            HttpSession session = request.getSession();
            UsuarioBeans usuario = (UsuarioBeans) session.getAttribute("usuario");
            Facade facade = new Facade(usuario);
            UsuarioBeans participante = facade.getQRCodeForUsuario(request.getParameter("p"));
            AtividadeBeans atividade = facade.getAtividade(Long.parseLong(request.getParameter("atividade")));
            InscricaoBeans inscricao = null;
            for(InscricaoBeans i : atividade.getInscricoes()){
                if(i.getParticipante().equals(participante)){
                    inscricao = i;
                    break;
                }
            }
            if(inscricao !=null){
                facade.marcaPresencaInscricaoAtividade(atividade, inscricao);
                out.println("Presença confirmada com sucesso!");
            }else{
                out.println("Inscrição não existe!");
            }
        }catch(NumberFormatException e){
            out.println(e.getMessage());
        }catch(NullPointerException e){
            out.println(e.getMessage());
        }catch(IllegalArgumentException e){
            out.println(e.getMessage());
        }catch(IllegalAccessException e){
            out.println(e.getMessage());
        }catch(Exception e){
            out.println(e.getMessage());
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
