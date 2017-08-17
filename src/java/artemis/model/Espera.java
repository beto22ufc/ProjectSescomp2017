/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.model;

import javax.persistence.*;

/**
 *
 * @author Wallison
 */
@Entity
@Table(name="espera")
public class Espera {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="codEspera")
    private long codEspera;
    @ManyToOne
    @JoinColumn(name="participante", referencedColumnName = "codUsuario")
    private Usuario participante;
    @ManyToOne
    @JoinColumn(name="atividade", referencedColumnName = "codAtividade")
    private Atividade atividade;
    private int posicao;

    public Espera(){}
    
    public Espera(long codEspera, Usuario participante, Atividade atividade, int posicao){
        setCodEspera(codEspera);
        setParticipante(participante);
        setPosicao(posicao);
        setAtividade(atividade);
    }
    
    public Espera(Usuario participante, Atividade atividade, int posicao){
        setParticipante(participante);
        setPosicao(posicao);
        setAtividade(atividade);
    }
    
    public long getCodEspera() {
        return codEspera;
    }

    public void setCodEspera(long codListaDeEspera) {
        if(codListaDeEspera>0)
            this.codEspera = codListaDeEspera;
        else
            throw new IllegalArgumentException("Código de lista de espera deve ser maior que zero!");
    }

    public Usuario getParticipante() {
        return participante;
    }

    public void setParticipante(Usuario participante) {
        if(participante != null)
            this.participante = participante;
        else
            throw new NullPointerException("Participante não pode ser nulo!");
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

    public int getPosicao() {
        return posicao;
    }

    public void setPosicao(int posticao) {
        if(posicao>0)
            this.posicao = posticao;
        else
            throw new NullPointerException("Posição deve ser maior que zero!");
    }
    
    
}
