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
public class LocalProxy extends Local{
    private Usuario usuario;
    
    public LocalProxy(){}
    
    public LocalProxy(Usuario usuario){
        this.usuario = usuario;
    }
    
    @Override
    public void novoLocal(Local local){
        if(getUsuario().getTipo().contains("admin")){
            super.novoLocal(local);
        }
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }
    
    
}
