package artemis.model;

import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Calendar;

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
    public void desvinculaEvento(Evento evento){
        if(getUsuario().getTipo().contains("admin")){
            super.desvinculaEvento(evento);
        }
    }
	
    @Override
    public void desvinculaAtividade(Atividade atividade){
        if(getUsuario().getTipo().contains("admin")){
            super.desvinculaAtividade(atividade);
        }
    }
    
    @Override
    public void vinculaAtividade(Atividade atividade){
        if(getUsuario().getTipo().contains("admin")){
            super.vinculaAtividade(atividade);
        }
    }
	
    @Override
    public void removeAtividade(Atividade atividade){
        if(getUsuario().getTipo().contains("admin")){
            super.removeAtividade(atividade);
        }
    }
    
    @Override
    public void vinculaEvento(Evento evento){
        if(getUsuario().getTipo().contains("admin")){
            super.vinculaEvento(evento);
        }
    }
    
    @Override
    public void removePeriodo(Periodo periodo){
        if(getUsuario().getTipo().contains("admin")){
            super.removePeriodo(periodo);
        }
    }
    
    @Override
    public Atividade novaAtividade(Atividade atividade) throws IllegalAccessException{
        if(getUsuario().getTipo().contains("admin")){
            return super.novaAtividade(atividade);
        }else{
            throw new IllegalAccessException("Acesso negado!");
        }
    }
    
    @Override
    public void novoPeriodo(LocalDateTime inicio, LocalDateTime termino, ZoneId zoneId){
        if(getUsuario().getTipo().contains("adminEvento")){
           super.novoPeriodo(inicio, termino, zoneId);
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
        if(getUsuario().getTipo().contains("adminEvento")){
            super.atualizaEvento(evento);
        }else{
            throw new IllegalAccessException("Acesso negado!");
        }
    }
    
    @Override
    public void atualizaAtividade(Atividade atividade)throws IllegalAccessException{
        if(getUsuario().getTipo().contains("adminEvento")){
            super.atualizaAtividade(atividade);
        }else{
            throw new IllegalAccessException("Acesso negado!");
        }
    }
    
    @Override
    public void mudaPeriodo(Periodo novo, Periodo antigo){
        if(getUsuario().getTipo().contains("admin")){
            super.mudaPeriodo(novo, antigo);
        }
    }        
}
