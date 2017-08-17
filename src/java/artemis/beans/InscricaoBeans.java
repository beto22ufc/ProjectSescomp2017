package artemis.beans;

import artemis.model.Atividade;
import artemis.model.Evento;
import artemis.model.Inscrevivel;
import artemis.model.Inscricao;
import artemis.model.Local;
import artemis.model.Usuario;
import java.time.LocalDate;


public abstract class InscricaoBeans implements Beans{
    private long codInscricao;
    private UsuarioBeans participante;
    private LocalDate data;
    private boolean valida = false;
    private boolean presente = false;

    public long getCodInscricao() {
        return codInscricao;
    }
    public void setCodInscricao(long codInscricao) {
        this.codInscricao = codInscricao;
    }
    public UsuarioBeans getParticipante() {
        return participante;
    }
    public void setParticipante(UsuarioBeans participante) {
        this.participante = participante;
    }
    public LocalDate getData() {
        return data;
    }
    public void setData(LocalDate data) {
        this.data = data;
    }
    public boolean isValida() {
        return valida;
    }
    public void setValida(boolean valida) {
        this.valida = valida;
    }
    public boolean isPresente() {
        return presente;
    }
    public void setPresente(boolean presente) {
        this.presente = presente;
    }         
}
