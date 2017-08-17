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
@Table(name="reserva_bem")
@AssociationOverride(name="peridos_reserva", joinTable=@JoinTable(
             name="peridos_reserva_bem",
             joinColumns=@JoinColumn(name="reserva", referencedColumnName = "codReserva"),
             inverseJoinColumns=@JoinColumn(name="bem", referencedColumnName = "codBem")
          ))
public class ReservaBem extends Reserva{
    @ManyToOne
    @JoinColumn(name="bem", referencedColumnName = "codBem")
    private Bem bem;

    public ReservaBem(){

    }

    public ReservaBem(long codReserva, List<Periodo> periodos, Bem bem, LocalDateTime data){
        setCodReserva(codReserva);
        setPeriodos(periodos);
        setBem(bem);
        setData(data);
    }

    public ReservaBem(List<Periodo> periodos, Bem bem, LocalDateTime data){
        setPeriodos(periodos);
        setBem(bem);
        setData(data);
    }
    
    public Bem getBem() {
        return bem;
    }

    public void setBem(Bem bem) {
        if(bem != null)
            this.bem = bem;
        else
            throw new NullPointerException("Bem não pode ser nulo!");
    }
    
    
}
