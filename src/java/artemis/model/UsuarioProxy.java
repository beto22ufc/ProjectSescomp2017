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
    @Override
    public Usuario adicionaNivelUsuario(Usuario u, String nivel) throws IllegalAccessException{
        if(usuario.getTipo().contains("adminGeral") || usuario.getTipo().contains("adminEvento")){
            return super.adicionaNivelUsuario(u, nivel);
        }else{
            throw new IllegalAccessException("Acesso negado!");
        }
    }
    
    @Override
    public Usuario removeNivelUsuario(Usuario u, String nivel) throws IllegalAccessException{
        if(usuario.getTipo().contains("adminGeral") || usuario.getTipo().contains("adminEvento")){
            return super.removeNivelUsuario(u, nivel);
        }else{
            throw new IllegalAccessException("Acesso negado!");
        }
    }
    
    @Override
    public void removeInstituicao(Instituicao instituicao)throws IllegalAccessException{
        if(this.usuario.getTipo() !=null && this.usuario.getTipo().contains("adminSite")){
            super.removeInstituicao(instituicao);
        }else{
            throw new IllegalArgumentException("Acesso negado!");
        }
    }
    
    public void marcaPresencaInscricao(Atividade atividade, Inscricao inscricao) throws IllegalAccessException{
        if(this.usuario.getTipo()!=null && (this.usuario.getTipo().contains("organizador") || this.usuario.getTipo().contains("adminEvento")) && (atividade.getAdministradores().contains(usuario) || atividade.getOrganizadores().contains(usuario)) && atividade.getInscricaoAtividades().contains(inscricao)){
            super.marcaPresencaInscricao(inscricao);
        }else{
            throw new IllegalAccessException("Acesso negado!");
        }
    }
    
    public void marcaPresencaInscricao(Evento evento, Inscricao inscricao) throws IllegalAccessException{
        if(this.usuario.getTipo()!=null && (this.usuario.getTipo().contains("organizador") || this.usuario.getTipo().contains("adminEvento")) && (evento.getAdministradores().contains(usuario) || evento.getOrganizadores().contains(usuario)) && evento.getInscricoes().contains(inscricao)){
            super.marcaPresencaInscricao(inscricao);
        }else{
            throw new IllegalAccessException("Acesso negado!");
        }
    }
    
    public void validaInscricao(Atividade atividade, Inscricao inscricao) throws IllegalAccessException{
        if(this.usuario.getTipo()!=null && (this.usuario.getTipo().contains("organizador") || this.usuario.getTipo().contains("adminEvento")) && (atividade.getAdministradores().contains(usuario) || atividade.getOrganizadores().contains(usuario)) && atividade.getInscricaoAtividades().contains(inscricao)){
            super.validaInscricao(inscricao);
        }else{
            throw new IllegalAccessException("Acesso negado!");
        }
    }
    
    public void validaInscricao(Evento evento, Inscricao inscricao) throws IllegalAccessException{
        if(this.usuario.getTipo()!=null && (this.usuario.getTipo().contains("organizador") || this.usuario.getTipo().contains("adminEvento")) && (evento.getAdministradores().contains(usuario) || evento.getOrganizadores().contains(usuario)) && evento.getInscricoes().contains(inscricao)){
            super.validaInscricao(inscricao);
        }else{
            throw new IllegalAccessException("Acesso negado!");
        }
    }
}
