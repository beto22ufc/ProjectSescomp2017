/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.model;

/**
 *
 * @author Wallison
 */
public class UsuarioProxy extends Usuario{
    private Usuario usuario;
    
    public UsuarioProxy(Usuario usuario){
        setUsuario(usuario);
    }
    public void setUsuario(Usuario usuario){
        if(usuario != null)
            this.usuario = usuario;
        else
            throw new NullPointerException("Usuário não pode ser nulo");
    }
    
    @Override
    public void adicionarUsuario(Usuario usuario){
        super.adicionarUsuario(usuario);
    }
    @Override
    public void atualizaDados(){
        super.atualizaDados();
    }
}