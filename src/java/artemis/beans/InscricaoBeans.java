package artemis.beans;

import artemis.model.Atividade;
import artemis.model.Evento;
import artemis.model.Inscrevivel;
import artemis.model.Inscricao;
import artemis.model.Local;
import artemis.model.Usuario;
import java.time.LocalDate;


public class InscricaoBeans implements Beans{
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

    @Override
    public Beans toBeans(Object o) {
        if(o != null){
            if(o instanceof Inscricao){
                Inscricao i = (Inscricao) o;
                this.setCodInscricao(i.getCodInscricao());
                this.setPresente(i.isPresente());
                this.setValida(i.isValidada());
                this.setData(i.getData());
                UsuarioBeans participante = new UsuarioBeans();
                System.out.println("Oi");
                if(i.getParticipante() != null){
                    System.out.println("Oi");
                    participante.toBeans(i.getParticipante());
                    System.out.println("Oi");
                    this.setParticipante(participante);
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
        i.setValidada(i.isValidada());
        System.out.println("Olá");
        i.setParticipante((Usuario) this.getParticipante().toBusiness());
        System.out.println("Olá");
        i.setData(this.getData());
        System.out.println("Olá");
        if(this.getCodInscricao()>0){
            i.setCodInscricao(this.getCodInscricao());
        }
        return i;
    }
}
