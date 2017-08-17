/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.model;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
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
    private ZonedDateTime zdtT = null;
    private ZonedDateTime zdtI = null;
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
            zdtI = inicio.atZone(this.zoneId);
            if(termino != null){
                zdtT = this.termino.atZone(this.zoneId);
                if(zdtT.toInstant().toEpochMilli() > zdtI.toInstant().toEpochMilli()){
                    this.inicio = inicio;
                }else{
                    throw new IllegalArgumentException("Inicio não pode ser maior que o termino do pediodo!");
                }
            }else{
                zdtT = LocalDateTime.now().atZone(this.zoneId);
                if(zdtI.toInstant().toEpochMilli() > zdtT.toInstant().toEpochMilli()){
                    this.inicio = inicio;
                }else{
                    throw new IllegalArgumentException("Inicio de periodo não pode ser menor do que o tempo atual!");
                }
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
            zdtT = termino.atZone(this.zoneId);
            if(inicio != null){
                zdtI = this.inicio.atZone(this.zoneId);
                if(zdtT.toInstant().toEpochMilli() > zdtI.toInstant().toEpochMilli()){
                    this.termino = termino;
                }else{
                    throw new IllegalArgumentException("Termino não de ser menor que o inicio do periodo!");
                }
            }else{
                zdtI = LocalDateTime.now().atZone(this.zoneId);
                if(zdtT.toInstant().toEpochMilli() > zdtI.toInstant().toEpochMilli()){
                    this.termino = termino;
                }else{
                    throw new IllegalArgumentException("Termino de periodo não pode ser menor do que o tempo atual!");
                }
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
                PeriodosEmchoque.add(lista1);
            }
        }
        return PeriodosEmchoque;
    }

    public boolean detectaColisao(Periodo outroPeriodo){
        //começa depois do inicio e termina antes do fim        
        if((outroPeriodo.getInicio().isAfter(this.getInicio()) || outroPeriodo.getInicio().isEqual(this.getInicio())) && (outroPeriodo.getInicio().isBefore(this.getTermino()) || outroPeriodo.getInicio().isEqual(this.getTermino()))){
            return true;
        }
        //começa antes do inicio e termina depois do inicio
        if((outroPeriodo.getTermino().isAfter(this.getInicio()) || outroPeriodo.getTermino().isEqual(this.getInicio())) && (outroPeriodo.getTermino().isBefore(this.getTermino()) || outroPeriodo.getTermino().isEqual(this.getTermino()))){
            return true;
        }
        //começa antes do fim e termina depois
        if((outroPeriodo.getInicio().isBefore(this.getTermino()) || outroPeriodo.getInicio().isEqual(this.getTermino())) && (outroPeriodo.getTermino().isAfter(this.getTermino()) || outroPeriodo.getTermino().isEqual(this.getTermino()))){
            return true;
        }
        //começa antes do inicio e termina depois do fim
        if((outroPeriodo.getInicio().isBefore(this.getInicio()) || outroPeriodo.getInicio().isEqual(this.getInicio())) && (outroPeriodo.getTermino().isAfter(this.getTermino()) || outroPeriodo.getTermino().isEqual(this.getTermino()))){
            return true;
        }
        return false;
    }
    
    //------------------------------ FINAL - GILBERTO -------------------------------------------------//
    
    
}