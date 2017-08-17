/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.model;

import java.time.LocalDateTime;
import java.util.List;
import javax.persistence.*;

/**
 *
 * @author Wallison
 */
@Entity
@Table(name="reserva_local")
@AssociationOverride(name="peridos_reserva", joinTable=@JoinTable(
             name="peridos_reserva_local",
             joinColumns=@JoinColumn(name="reserva", referencedColumnName = "codReserva"),
             inverseJoinColumns=@JoinColumn(name="local", referencedColumnName = "codLocal")
          ))
public class ReservaLocal extends Reserva{
    @ManyToOne
    @JoinColumn(name="local", referencedColumnName = "codLocal")
    private Local local;

    public ReservaLocal(){

    }

    public ReservaLocal(long codReserva, List<Periodo> periodos, Local local, LocalDateTime data){
        setCodReserva(codReserva);
        setPeriodos(periodos);
        setLocal(local);
        setData(data);
    }

    public ReservaLocal(List<Periodo> periodos, Local local, LocalDateTime data){
        setPeriodos(periodos);
        setLocal(local);
        setData(data);
    }
    
    public Local getLocal() {
        return local;
    }

    public void setLocal(Local local){
        if(local != null)
            this.local = local;
        else
            throw new NullPointerException("Local não pode ser nulo!");
    }
    
    
}
