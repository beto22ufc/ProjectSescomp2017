package artemis.model;

import java.time.LocalDateTime;
import java.time.ZoneId;

public class AtividadeProxy extends Atividade{
    private Usuario usuario;
	
    public AtividadeProxy()
    {}

    public AtividadeProxy(Usuario usuario){
            this.usuario = usuario;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }
	
    @Override
    public void excluiReserva(Reserva reserva){
        if(getUsuario().getTipo().contains("admin")){
            super.excluiReserva(reserva);
        }
    }
    @Override
    public void mudaPeriodo(Periodo novo, Periodo antigo){
    
    } 
    @Override
    public void novoPeriodo(LocalDateTime inicio, LocalDateTime termino, ZoneId zoneId){
        if(getUsuario().getTipo().contains("admin")){
            super.novoPeriodo(inicio, termino, zoneId);
        }
    }
    @Override
    public void reservaBem(Bem bem){
        if(getUsuario().getTipo().contains("admin")){
            super.reservaBem(bem);
        }
    }
    @Override
    public void reservaLocal(Local local){
        if(getUsuario().getTipo().contains("admin")){
            super.reservaLocal(local);
        }
    }	
    @Override
    public void removeInscricao(Usuario usuario){
        if(getUsuario().getTipo().contains("participante")){
            super.removeInscricao(usuario);
        }
    }
}
