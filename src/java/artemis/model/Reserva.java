package artemis.model;

import java.time.LocalDateTime;
import java.util.List;
import javax.persistence.*;

@Entity
@Table(name="reserva")
@Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)
public abstract class Reserva {
    @Id
    @GeneratedValue(strategy = GenerationType.TABLE)
    @Column(name="codReserva")
    private long codReserva;
    @ManyToMany(targetEntity = Periodo.class, cascade = CascadeType.ALL)
    @JoinTable(name="periodos_reserva", joinColumns = {@JoinColumn(name="reserva", referencedColumnName = "codReserva")},
            inverseJoinColumns = {@JoinColumn(name="periodo", referencedColumnName = "codPeriodo")})
    private List<Periodo> periodos;
    private LocalDateTime data;

    public long getCodReserva() {
        return codReserva;
    }
    public void setCodReserva(long codReserva){
        this.codReserva = codReserva;
    }
    public List<Periodo> getPeriodos() {
        return periodos;
    }
    public void setPeriodos(List<Periodo> periodos) {
        this.periodos = periodos;
    }
    public LocalDateTime getData() {
        return data;
    }
    public void setData(LocalDateTime data) {
        this.data = data;
    }	
}
