/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.beans;

import artemis.model.Atividade;
import artemis.model.Evento;
import artemis.model.Inscrevivel;
import artemis.model.Inscricao;
import artemis.model.InscricaoAtividade;
import artemis.model.Local;
import artemis.model.Usuario;

/**
 *
 * @author Wallison
 */
public class InscricaoAtividadeBeans extends InscricaoBeans{
    private AtividadeBeans atividade;

    public AtividadeBeans getAtividade() {
        return atividade;
    }

    public void setAtividade(AtividadeBeans atividade) {
        this.atividade = atividade;
    }
    
    @Override
    public Beans toBeans(Object o) {
        if(o != null){
            if(o instanceof InscricaoAtividade){
                InscricaoAtividade i = (InscricaoAtividade) o;
                this.setCodInscricao(i.getCodInscricao());
                Atividade atividade = (Atividade)i.getAtividade();
                AtividadeBeans ab = new AtividadeBeans();
                ab.toBeans(atividade);
                this.setAtividade(ab);
                this.setPresente(i.isPresente());
                this.setValida(i.isValidada());
                this.setData(i.getData());
                UsuarioBeans participante = new UsuarioBeans();
                participante.toBeans(i.getParticipante());
                this.setParticipante(participante);
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
        AtividadeBeans ab = (AtividadeBeans) this.getAtividade();
        Usuario participante = (Usuario) this.getParticipante().toBusiness();
        InscricaoAtividade i = new InscricaoAtividade((Atividade) this.getAtividade().toBusiness() , participante, this.getData());
        i.setPresente(this.isPresente());
        i.setValidada(i.isValidada());
        if(this.getCodInscricao()>0){
            i.setCodInscricao(this.getCodInscricao());
        }
        return i;
    }
}
