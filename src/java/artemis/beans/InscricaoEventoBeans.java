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
import artemis.model.InscricaoEvento;
import artemis.model.Local;
import artemis.model.Usuario;

/**
 *
 * @author Wallison
 */
public class InscricaoEventoBeans extends InscricaoBeans{
    private EventoBeans evento;

    public EventoBeans getEvento() {
        return evento;
    }

    public void setEvento(EventoBeans evento) {
        this.evento = evento;
    }
    
    
    @Override
    public Beans toBeans(Object o) {
        if(o != null){
            if(o instanceof InscricaoEvento){
                InscricaoEvento i = (InscricaoEvento) o;
                this.setCodInscricao(i.getCodInscricao());
                Evento evento = (Evento) i.getEvento();
                EventoBeans eb = new EventoBeans();
                eb.toBeans(evento);
                this.setEvento(eb);
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
        Usuario participante = (Usuario) this.getParticipante().toBusiness();
        InscricaoEvento i = new InscricaoEvento((Evento)this.getEvento().toBusiness(), participante, this.getData());
        i.setPresente(this.isPresente());
        i.setValidada(i.isValidada());
        if(this.getCodInscricao()>0){
            i.setCodInscricao(this.getCodInscricao());
        }
        return i;
    }
}
