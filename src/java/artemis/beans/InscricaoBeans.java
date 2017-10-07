package artemis.beans;

import artemis.model.Inscricao;
import artemis.model.Usuario;
import java.time.LocalDate;


public class InscricaoBeans implements Beans{
    private long codInscricao;
    private UsuarioBeans participante;
    private LocalDate data;
    private boolean valida;
    private boolean presente;

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

    @Override
    public Beans toBeans(Object o) {
        if(o != null){
            if(o instanceof Inscricao){
                Inscricao i = (Inscricao) o;
                this.setCodInscricao(i.getCodInscricao());
                this.setPresente(i.isPresente());
                this.setValida(i.isValidada());
                this.setData(i.getData());
                UsuarioBeans p = new UsuarioBeans();
                if(i.getParticipante() != null){
                    p.toBeans(i.getParticipante());
                    this.setParticipante(p);
                }
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
        Inscricao i = new Inscricao();
        i.setPresente(this.isPresente());
        i.setValidada(this.isValida());
        i.setParticipante((Usuario) this.getParticipante().toBusiness());
        i.setData(this.getData());
        if(this.getCodInscricao()>0){
            i.setCodInscricao(this.getCodInscricao());
        }
        return i;
    }
}
