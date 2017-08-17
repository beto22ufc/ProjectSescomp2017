/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.service;

import artemis.DAO.UsuarioDAO;
import artemis.model.Usuario;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author Wallison
 */
@Service
public class BemVindoPaginaServiceImpl implements BemVindoPaginaService{
    private UsuarioDAO usuarioDAO;
    public void setUsuarioDAO(UsuarioDAO usuarioDAO){
        if(usuarioDAO != null)
            this.usuarioDAO = usuarioDAO;
        else 
            throw new NullPointerException("Argumento de conexão nulo!");
    }
    
    @Override
    @Transactional
    public void adicionarUsuario(Usuario usuario){
        this.usuarioDAO.adicionarUsuario(usuario);
    }
    
    @Override
    public void autenticar(Usuario usuario){}
}
