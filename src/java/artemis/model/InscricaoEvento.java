/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.model;

import artemis.beans.PeriodoBeans;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import javax.persistence.*;

/**
 *
 * @author Wallison
 */
@Entity
@Table(name="inscricao_evento")
public class InscricaoEvento extends Inscricao{
    @ManyToOne
    @JoinColumn(name = "evento", referencedColumnName = "codEvento")
    private Evento evento;

    public InscricaoEvento(){}
    
    public InscricaoEvento(long codInscricao, Evento evento, Usuario participante, LocalDate data){
        setCodInscricao(codInscricao);
        setEvento(evento);
        setParticipante(participante);
        setData(data);
    }
    
    public InscricaoEvento(Evento evento, Usuario participante, LocalDate data){
        setEvento(evento);
        setParticipante(participante);
        setData(data);
    }
    
    public Evento getEvento() {
        return evento;
    }

    public void setEvento(Evento evento) {
        if(evento != null)
            this.evento = evento;
        else
            throw new NullPointerException("Evento não pode ser nulo!");
    }
    
	 //------------------------------ INICIO - GILBERTO -------------------------------------------------//
    
    public List<InscricaoEvento> verificaChoque(InscricaoEvento inscricao, List<InscricaoEvento> lista){
        List<InscricaoEvento> incricoesComChoque = Collections.synchronizedList(new ArrayList<>());
        List<Periodo>  periodosInscricao = inscricao.getEvento().getPeriodos();
        
        for(InscricaoEvento lista1 : lista){
            List<Periodo>  periodosCompare = lista1.getEvento().getPeriodos();
            for(Periodo pInscri : periodosInscricao){    
                for(Periodo p : periodosCompare){
                    if(p.detectaColisao(pInscri)){
                        incricoesComChoque.add(lista1);
                        break;
                    }
                }
            }
        }
        return incricoesComChoque;
    }
    //------------------------------ FINAL - GILBERTO -------------------------------------------------//
    
    
}
