/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.beans;

import artemis.model.Atividade;
import artemis.model.Espera;
import artemis.model.Usuario;

/**
 *
 * @author Wallison
 */
public class EsperaBeans implements Beans{
    private long codEspera;
    private UsuarioBeans participante;
    private AtividadeBeans atividade;
    private int posicao;

    public EsperaBeans(){}
    
    public EsperaBeans(long codEspera, UsuarioBeans participante, AtividadeBeans atividade, int posicao){
        setCodEspera(codEspera);
        setParticipante(participante);
        setPosicao(posicao);
        setAtividade(atividade);
    }
    
    public EsperaBeans(UsuarioBeans participante, AtividadeBeans atividade, int posicao){
        setParticipante(participante);
        setPosicao(posicao);
        setAtividade(atividade);
    }

    public long getCodEspera() {
        return codEspera;
    }

    public void setCodEspera(long codEspera) {
        this.codEspera = codEspera;
    }

    public UsuarioBeans getParticipante() {
        return participante;
    }

    public void setParticipante(UsuarioBeans participante) {
        this.participante = participante;
    }

    public AtividadeBeans getAtividade() {
        return atividade;
    }

    public void setAtividade(AtividadeBeans atividade) {
        this.atividade = atividade;
    }

    public int getPosicao() {
        return posicao;
    }

    public void setPosicao(int posicao) {
        this.posicao = posicao;
    }

    @Override
    public Beans toBeans(Object o) {
        if(o != null){
            if(o instanceof Espera){
                Espera lde = (Espera) o;
                this.setCodEspera(lde.getCodEspera());
                UsuarioBeans participante = (UsuarioBeans) new UsuarioBeans().toBeans(lde.getParticipante());
                this.setParticipante(participante);
                AtividadeBeans atividade = (AtividadeBeans) new AtividadeBeans().toBeans(lde.getAtividade());
                this.setAtividade(atividade);
                this.setPosicao(lde.getPosicao());
                return this;
            }else{
                throw new IllegalArgumentException("Isso não é uma lista de espera!");
            }
        }else{
            throw new NullPointerException("Lista de espera não pode ser nula!");
        }
    }

    @Override
    public Object toBusiness() {
        Espera lde = new Espera((Usuario) this.getParticipante().toBusiness(), (Atividade) this.getAtividade().toBusiness(), this.getPosicao());
        if(this.getCodEspera()>0){
            lde.setCodEspera(this.getCodEspera());
        }
        return lde;
    }
    
    
}
