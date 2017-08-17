/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.beans;

import artemis.model.Bem;
import artemis.model.Local;
import artemis.model.Periodo;
import artemis.model.Reserva;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;


/**
 *
 * @author ANGELO MATHEUS
 */
public abstract class ReservaBeans implements Beans{
    private long codReserva;
    private List<PeriodoBeans> periodoBeanses = new ArrayList<>();
    private LocalDateTime data;
    
    public long getCodReserva() {
        return codReserva;
    }
    public void setCodReserva(long codReserva) {
        this.codReserva = codReserva;
    }
    public List<PeriodoBeans> getPeriodosBeans() {
        return periodoBeanses;
    }
    public void setPeriodosBeans(List<PeriodoBeans> periodoBeanses) {
        this.periodoBeanses = periodoBeanses;
    }
    public LocalDateTime getData() {
        return data;
    }
    public void setData(LocalDateTime data) {
        this.data = data;
    }       
}
