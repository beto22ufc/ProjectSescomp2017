/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.controller;

import artemis.beans.AtividadeBeans;
import artemis.beans.EventoBeans;
import artemis.beans.InscricaoBeans;
import artemis.beans.InstituicaoBeans;
import artemis.beans.UsuarioBeans;
import artemis.model.Atividade;
import artemis.model.Constantes;
import artemis.model.Evento;
import artemis.model.Facade;
import artemis.model.Inscricao;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.LocalDateTime;
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
@WebServlet(name = "InscreveAtividade", urlPatterns = {"/inscreveAtividade"})
public class InscreveAtividade extends HttpServlet {

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
        String alertHref = "<script>alert(\'%data%\');location.href=\"%data2%\";</script>";
        String button = "";
        long codAtividade = 0;
        try{
            if(request.getSession().getAttribute("usuario")!=null){
                UsuarioBeans usuario = (UsuarioBeans) request.getSession().getAttribute("usuario");
                Facade facade = new Facade(usuario);
                codAtividade = Long.parseLong(request.getParameter("atividade"));
                AtividadeBeans atividade = facade.getAtividade(codAtividade);
                InscricaoBeans inscricao = new InscricaoBeans();
                inscricao.setParticipante(usuario);
                inscricao.setData(LocalDate.now());
                if(atividade.getTipoPagamento() ==1){
                    inscricao.setValida(true);
                }
                Inscricao ins = new Inscricao();
                List<List> choques = ins.verificaChoque((Atividade) atividade.toBusiness());
                int chocadas = choques.get(0).size(),chocados = choques.get(1).size();
                if((atividade.getVagasInternas()-facade.inscritosInternos(atividade)) >0 || (atividade.getVagasPublicas()-facade.inscritosExternos(atividade))>0){
                    InstituicaoBeans usuarioIns = facade.getInstituicao(usuario);
                    InstituicaoBeans atividadeIns = facade.getInstituicao(atividade);
                    if((usuarioIns != null  && atividadeIns.getCodInstituicao()==usuarioIns.getCodInstituicao() && ((atividade.getVagasInternas()-facade.inscritosInternos(atividade)) >0))
                            || ((usuarioIns != null  && atividadeIns.getCodInstituicao()!=usuarioIns.getCodInstituicao() && (atividade.getVagasPublicas()-facade.inscritosExternos(atividade))>0 )
                            || (usuarioIns == null && (atividade.getVagasPublicas()-facade.inscritosExternos(atividade))>0 ))){
                        if(facade.getMenorPeriodo(atividade).getInicio().isAfter(LocalDateTime.now())){
                            if(chocadas == 0 && chocados == 0){
                                inscricao = facade.fazerInscricaoAtividade(atividade, inscricao);
                                facade.adicionaNivelUsuario(usuario, "participante");
                                alert = alert.replace("%data%", "Inscrição realizada com sucesso!");
                                button = "<a href=\"javascript:void(0);\" onclick=\"desfazInscricaoAtividade("+codAtividade+","+inscricao.getCodInscricao()+");\">Desfazer inscrição</a>";
                                out.println(alert);
                                out.println(button);
                            }else{
                                alert = "<script>alert(\'Os horários dessa atividade colidiram com o das outras atividades e eventos do evento no qual este está vinculado!\');</script>";
                                button = "<a href=\"javascript:void(0);\" onclick=\"inscreveAtividade("+codAtividade+");\">Inscrever-se</a>";
                                out.println(alert);
                                out.println(button);
                            }
                        }else{
                            alert = alert.replace("%data%", "Essa atividade já foi iniciada, não sendo possível realizar mais inscrição!");
                                button = "<a href=\"javascript:void(0);\" onclick=\"inscreveAtividade("+codAtividade+");\">Inscrever-se</a>";
                                out.println(alert);
                                out.println(button);
                        }
                    }else{
                        alert = alert.replace("%data%", "Sem vagas na sua classe, interno/externo!");
                        button = "Sem vagas na sua classe, interno/externo!";
                        out.println(alert);
                        out.println(button);
                    }
                }else{
                    alert = alert.replace("%data%", "Não há mais vagas!");
                    button = "Sem vagas!";
                    out.println(alert);
                    out.println(button);
                }
            }else{                
                alertHref = alertHref.replace("%data%", "Usuário não autenticado, realize o login!");
                alertHref = alertHref.replace("%data2%", Constantes.URL+"/"+Constantes.DIR+"/login");
                button = "<a href=\"javascript:void(0);\" onclick=\"inscreveAtividade("+codAtividade+");\">Inscrever-se</a>";
                out.println(alertHref);
                out.println(button);
            }
        }catch(NumberFormatException e){
            alert = alert.replace("%data%", "Isso não é um código de atividade!");
            button = "<a href=\"javascript:void(0);\" onclick=\"inscreveAtividade("+codAtividade+");\">Inscrever-se</a>";
            out.println(alert);
            out.println(button);
        }catch(NullPointerException e){
            alert = "<script>alert(\'"+e.getMessage()+"\');</script>";
            button = "<a href=\"javascript:void(0);\" onclick=\"inscreveAtividade("+codAtividade+");\">Inscrever-se</a>";
            out.println(alert);
            out.println(button);
        }catch(Exception e){
            e.printStackTrace();
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
