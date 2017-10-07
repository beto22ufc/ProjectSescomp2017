package artemis.model;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;

import org.apache.commons.mail.EmailException;

public class EventoProxy extends Evento{
    private Usuario usuario;

    public EventoProxy(){}
    public EventoProxy(Usuario usuario){
            this.usuario = usuario;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }
	
    @Override
    public void removeAtividade(Evento evento, Atividade atividade) throws EmailException, IllegalAccessException{
        if(getUsuario().getTipo()!= null && getUsuario().getTipo().contains("adminEvento") && atividade.getAdministradores().contains(this.getUsuario())){
            super.removeAtividade(evento,atividade);
        }else{
            throw new IllegalAccessException("Acesso negado!");
        }
    }
    

    
    @Override
    public void removePeriodo(Evento evento,Periodo periodo) throws EmailException{
        if(getUsuario().getTipo().contains("admin")){
            super.removePeriodo(evento, periodo);
        }
    }
    
    @Override
    public Atividade novaAtividade(Atividade atividade) throws IllegalAccessException{
        if(getUsuario().getTipo().contains("adminEvento")){
            return super.novaAtividade(atividade);
        }else{
            throw new IllegalAccessException("Acesso negado!");
        }
    }

    @Override
    public void removeEvento(Evento evento) throws IllegalAccessException, EmailException{
        if(this.getUsuario().getTipo() != null && this.getUsuario().getTipo().contains("adminEvento") && evento.getAdministradores().contains(this.getUsuario())){
            super.removeEvento(evento);
        }else{
            throw new IllegalAccessException("Acesso negado!");
        }
    }
    
    @Override
    public Evento novoEvento(Evento evento) throws IllegalAccessException{
        if(getUsuario().getTipo().contains("adminEvento")){
            return super.novoEvento(evento);
        }else{
            throw new IllegalAccessException("Acesso negado! Você não é um administrador de evento!");
        }
    }
    
    @Override
    public void atualizaEvento(Evento evento)throws IllegalAccessException{
        if(getUsuario().getTipo() != null && getUsuario().getTipo().contains("adminEvento") && evento.getAdministradores().contains(getUsuario())){
            super.atualizaEvento(evento);
        }else{
            throw new IllegalAccessException("Acesso negado!");
        }
    }
    
    @Override
    public void atualizaAtividade(Atividade atividade)throws IllegalAccessException{
        if(getUsuario().getTipo() != null && getUsuario().getTipo().contains("adminEvento") && atividade.getAdministradores().contains(getUsuario())){
            super.atualizaAtividade(atividade);
        }else{
            throw new IllegalAccessException("Acesso negado!");
        }
    }  
    
    public void removeImagemSlideshow(Evento evento, Imagem imagem) throws IllegalAccessException{
        if(getUsuario().getTipo() != null && getUsuario().getTipo().contains("adminEvento") && evento.getAdministradores().contains(getUsuario())){
            evento.removeImagemSlideshow(imagem);
        }else{
            throw new IllegalAccessException("Acesso negado!");
        }
    }
    public void removeImagemGaleria(Evento evento, Imagem imagem) throws IllegalAccessException{
        if(getUsuario().getTipo() != null && getUsuario().getTipo().contains("adminEvento") && evento.getAdministradores().contains(getUsuario())){
            evento.removeImagemGaleria(imagem);
        }else{
            throw new IllegalAccessException("Acesso negado!");
        }
    }
}
