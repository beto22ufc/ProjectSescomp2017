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
public class BemProxy extends Bem{
    private Usuario usuario;
    
    public BemProxy(){
    
    }
    public BemProxy(Usuario usuario){
        this.usuario = usuario;
    }
    
    @Override
    public void novoBem(Bem bem){
        if(getUsuario().getTipo().contains("admin")){
            super.novoBem(bem);
        }
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }
    
    
}
