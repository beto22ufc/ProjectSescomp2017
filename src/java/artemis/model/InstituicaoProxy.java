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
public class InstituicaoProxy extends Instituicao{
    private Usuario usuario;
    
    public InstituicaoProxy(Usuario usuario){
        setUsuario(usuario);
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        if(usuario!=null)
            this.usuario = usuario;
        else
            throw new NullPointerException("Usuário não pode ser nulo!");
    }
    
    public void removeCurso(Instituicao instituicao, Curso curso) throws IllegalAccessException{
        if(this.getUsuario().getTipo() !=null && this.getUsuario().getTipo().contains("adminSite")){
            instituicao.removeCurso(curso);
        }else{
            throw new IllegalAccessException("Acesso negado!");
        }
    }
    
}
