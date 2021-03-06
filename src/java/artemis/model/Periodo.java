/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.model;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Objects;
import javax.persistence.AttributeConverter;
import javax.persistence.Column;
import javax.persistence.Converter;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 *
 * @author Wallison
 */
/**
 *
 * @author Wallison
 */
@Converter(autoApply = true)
@Entity
@Table(name="periodo")
public class Periodo implements AttributeConverter<LocalDateTime, Timestamp>{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="codPeriodo")
    private long codPeriodo;
    @Column
    private LocalDateTime inicio;
    @Column
    private LocalDateTime termino;
    //Default
    private ZoneId zoneId = ZoneId.of("America/Sao_Paulo");
    public Periodo(){
    
    }

    public Periodo(long codPeriodo, LocalDateTime inicio, LocalDateTime termino){
        setCodPeriodo(codPeriodo);
        setInicio(inicio);
        setTermino(termino);
    }
    public Periodo(LocalDateTime inicio, LocalDateTime termino){
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
        if(inicio != null){
            if(this.getTermino()!= null){
                if((inicio.isBefore(this.getTermino()) || inicio.equals(this.getTermino()))){
                    this.inicio = inicio;
                }else{
                    throw new IllegalArgumentException("Inicio não pode ser maior que o termino!");
                }
            }else{
                this.inicio = inicio;
            }
        }else{
            throw new NullPointerException("Inicio de periodo não pode ser nulo!");
        }
    }

    public LocalDateTime getTermino() {
        return termino;
    }

    public void setTermino(LocalDateTime termino) {
        if(termino != null){
            if(this.getInicio()!= null){
                if((termino.isAfter(this.getInicio()) || termino.equals(this.getInicio()))){
                    this.termino = termino;
                }else{
                    throw new IllegalArgumentException("Termino não pode ser menor que o inicio!");
                }
            }else{
                this.termino = termino;
            }
        }else{
            throw new NullPointerException("Termino de periodo não pode ser nulo!");
        }
    }

    public ZoneId getZoneId() {
        return zoneId;
    }

    public void setZoneId(ZoneId zoneId) {
        if(zoneId != null)
            this.zoneId = zoneId;
        else
            throw new NullPointerException("Id da zona não pode ser vazio!");
    }

    @Override
    public Timestamp convertToDatabaseColumn(LocalDateTime attribute) {
        return (attribute == null ? null : Timestamp.valueOf(attribute));
    }

    @Override
    public LocalDateTime convertToEntityAttribute(Timestamp dbData) {
        return (dbData == null ? null : dbData.toLocalDateTime());
    }
    
     
    //------------------------------ INICIO - GILBERTO -------------------------------------------------//
    
    public List<Periodo> detectaColisao(List<Periodo> lista){
        List<Periodo> PeriodosEmchoque = Collections.synchronizedList(new ArrayList<>());
        for (Periodo lista1 : lista) {
            if(this.detectaColisao(lista1)){
                System.out.println("Periodo 1: "+this.toString()+" Periodo 2: "+lista1.toString());
                PeriodosEmchoque.add(lista1);
            }
        }
        return PeriodosEmchoque;
    }
    
    public boolean contido(Periodo p){
        return this.getInicio().isAfter(p.getInicio()) && this.getTermino().isBefore(p.getTermino());
    }

    public boolean detectaColisao(Periodo outroPeriodo){
        //começa depois do inicio e termina antes do fim        
        if((outroPeriodo.getInicio().isAfter(this.getInicio())) && (outroPeriodo.getTermino().isBefore(this.getTermino()))){
            return true;
        }
        //começa antes do inicio e termina depois do inicio
        if((outroPeriodo.getTermino().isAfter(this.getInicio())) && (outroPeriodo.getTermino().isBefore(this.getTermino()))){
            return true;
        }
        //começa antes do fim e termina depois
        if((outroPeriodo.getInicio().isBefore(this.getTermino())) && (outroPeriodo.getTermino().isAfter(this.getTermino()))){
            return true;
        }
        //começa antes do inicio e termina depois do fim
        return (outroPeriodo.getInicio().isBefore(this.getInicio())) && (outroPeriodo.getTermino().isAfter(this.getTermino()));
    }
    
    //------------------------------ FINAL - GILBERTO -------------------------------------------------//
    
    @Override
    public String toString(){
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yy hh:mm");
        return "Código: "+getCodPeriodo()+" inicio: "+getInicio().format(formatter)+" termino: "+getTermino().format(formatter);
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 47 * hash + (int) (this.codPeriodo ^ (this.codPeriodo >>> 32));
        hash = 47 * hash + Objects.hashCode(this.inicio);
        hash = 47 * hash + Objects.hashCode(this.termino);
        return hash;
    }
    
    @Override
    public boolean equals(Object o){
        Periodo p = (Periodo) o;
        return (this.getCodPeriodo() == p.getCodPeriodo() && this.getInicio().equals(p.getInicio()) && this.getTermino().equals(p.getTermino()));
    }
}
