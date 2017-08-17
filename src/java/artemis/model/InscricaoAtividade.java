/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.model;

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
@Table(name="inscricao_atividade")
public class InscricaoAtividade extends Inscricao{
    @ManyToOne
    @JoinColumn(name="atividade", referencedColumnName = "codAtividade")
    private Atividade atividade;

    public InscricaoAtividade(){}
    
    public InscricaoAtividade(long codInscricao, Atividade atividade, Usuario participante, LocalDate data){
        setCodInscricao(codInscricao);
        setAtividade(atividade);
        setParticipante(participante);
        setData(data);
    }
    
    public InscricaoAtividade(Atividade atividade, Usuario participante, LocalDate data){
        setAtividade(atividade);
        setParticipante(participante);
        setData(data);
    }
    public Atividade getAtividade() {
        return atividade;
    }

    public void setAtividade(Atividade atividade) {
        if(atividade != null)
            this.atividade = atividade;
        else
            throw new NullPointerException("Atividade não pode ser nula!");
    }
	    
     //------------------------------ INICIO - GILBERTO -------------------------------------------------//
    
    public List<InscricaoAtividade> verificaChoque(InscricaoAtividade inscricao, List<InscricaoAtividade> lista){
        List<InscricaoAtividade> incricoesComChoque = Collections.synchronizedList(new ArrayList<>());
        List<Periodo>  periodosInscricao = inscricao.getAtividade().getPeriodos();
        
        for(InscricaoAtividade lista1 : lista){
            List<Periodo>  periodosCompare = lista1.getAtividade().getPeriodos();
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
