/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.controller;

import artemis.beans.UsuarioBeans;
import artemis.model.Constantes;
import artemis.model.Facade;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author Wallison
 */
@WebServlet(name = "PerfilImagemUpload", urlPatterns = {"/PerfilImagemUpload"})
public class PerfilImagemUpload extends HttpServlet {

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
       boolean isMultiPart = FileUpload.isMultipartContent(request);
        if(isMultiPart){
            try{
                DiskFileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);
                upload.setFileItemFactory(factory);
                List itens = upload.parseRequest(request);
                HttpSession session = request.getSession();
                UsuarioBeans usuario = (UsuarioBeans) session.getAttribute("usuario");
                int k=0;
                for(int i=0;i<itens.size();i++){
                    FileItem item = (FileItem) itens.get(i);
                    String campo = item.getFieldName();
                    String valor = item.getString();
                    if(item.isFormField()){
                        //Escolhe o que vai fazer com os campos normais
                    }else{
                        //Escolhe o que vai fazer com os campos files
                        if(item.get().length>0){
                            File temp = File.createTempFile("temp", ".jpg");
                            InputStream input = item.getInputStream();
                            OutputStream output = new FileOutputStream(temp);
                            int read = 0;
                            byte[] bytes = new byte[1024];
                            while ((read = input.read(bytes)) != -1) {
                                output.write(bytes, 0, read);
                            }
                            usuario.setImagemPerfil(temp);
                            output.flush();
                            output.close();
                            input.close();
                        }
                    }
                }
                Facade facade = new Facade();
                facade.atualizaUsuarioGeral(usuario);
                System.err.println("Obriado Deus!");
                request.setAttribute("msgFoto", "Foto atualizada com sucesso!");
                response.sendRedirect("/"+Constantes.DIR+"/painelUsuario/conta");
            }catch(FileUploadException e){
                e.printStackTrace();
            }catch(Exception e){
                e.printStackTrace();
            }
        }else{
        
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
