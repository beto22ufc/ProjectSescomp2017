/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.beans;

import artemis.model.Periodo;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Objects;

/**
 *
 * @author Wallison
 */
public class PeriodoBeans implements Beans{
    private long codPeriodo;
    private LocalDateTime inicio;
    private LocalDateTime termino;
    private ZoneId zoneId = ZoneId.of("America/Sao_Paulo");

    public PeriodoBeans(){
    
    }
    
    public PeriodoBeans(long codPeriodo, LocalDateTime inicio, LocalDateTime termino){
        setCodPeriodo(codPeriodo);
        setInicio(inicio);
        setTermino(termino);
    }
    public PeriodoBeans(LocalDateTime inicio, LocalDateTime termino){
        setInicio(inicio);
        setTermino(termino);
    }
    
    public long getCodPeriodo() {
        return codPeriodo;
    }

    public void setCodPeriodo(long codPeriodo) {
        this.codPeriodo = codPeriodo;
    }

    public LocalDateTime getInicio() {
        return inicio;
    }

    public void setInicio(LocalDateTime inicio) {
        this.inicio = inicio;
    }

    public LocalDateTime getTermino() {
        return termino;
    }

    public void setTermino(LocalDateTime termino) {
        this.termino = termino;
    }

    public ZoneId getZoneId() {
        return zoneId;
    }

    public void setZoneId(ZoneId zoneId) {
        this.zoneId = zoneId;
    }

    @Override
    public Beans toBeans(Object o) {
        if(o != null){
            if(o instanceof Periodo){
                Periodo p = (Periodo) o;
                this.setCodPeriodo(p.getCodPeriodo());
                this.setInicio(p.getInicio());
                this.setTermino(p.getTermino());
                this.setZoneId(p.getZoneId());
                return this;
            }else{
                throw new IllegalArgumentException("Isso não é um Local!");
            }
        }else{
            throw new NullPointerException("Local não pode ser nulo!");
        }
    }

    @Override
    public Object toBusiness() {
        Periodo p = new Periodo(this.getInicio(), this.getTermino());
        if(this.getCodPeriodo()>0){
            p.setCodPeriodo(this.getCodPeriodo());
        }
        p.setZoneId(this.getZoneId());
        return p;
    }
    
    @Override
    public boolean equals(Object o){
        PeriodoBeans p = (PeriodoBeans) o;
        return (this.getCodPeriodo() == p.getCodPeriodo() && this.getInicio().equals(p.getInicio()) && this.getTermino().equals(p.getTermino()));
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 67 * hash + (int) (this.codPeriodo ^ (this.codPeriodo >>> 32));
        hash = 67 * hash + Objects.hashCode(this.inicio);
        hash = 67 * hash + Objects.hashCode(this.termino);
        return hash;
    }
    
    @Override
    public String toString(){
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy hh:mm");
        return getInicio().format(formatter)+" às "+getTermino().format(formatter);
    }
}
