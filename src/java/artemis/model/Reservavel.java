/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.model;

import java.io.Serializable;
import javax.persistence.*;

/**
 *
 * @author Wallison
 */
@Entity
@Table(name="reservavel")
public abstract class Reservavel implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="codReservalvel")
    private long codReservavel;

    public long getCodReservavel() {
        return codReservavel;
    }

    public void setCodReservavel(long codReservavel) {
        if(codReservavel>0)
            this.codReservavel = codReservavel;
        else
            throw new IllegalArgumentException("Código de reservável não pode ser menor igual a zero!");
    }
    
    
    
}
