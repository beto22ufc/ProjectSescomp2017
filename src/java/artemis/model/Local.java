package artemis.model;

import javax.persistence.*;

@Entity
@Table(name="local")
public class Local{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="codLocal")
    private long codLocal;
    private String nome;
    private int capacidade;

    public Local(){

    }

    public Local(long codLocal, String nome, int capacidade){
        setCodLocal(codLocal);
        setNome(nome);
        setCapaciadade(capacidade);
    }

    public Local(String nome, int capacidade){
        setNome(nome);
        setCapaciadade(capacidade);
    }

    public long getCodLocal() {
        return codLocal;
    }

    public void setCodLocal(long codLocal) {
        if(codLocal>0)
            this.codLocal = codLocal;
        else
            throw new IllegalArgumentException("Código do local deve ser maior que zero!");
    }   
    
    public String getNome() {		
        return nome;
    }
    public void setNome(String nome) {
        this.nome = nome;
    }
    public int getCapacidade() {
        return capacidade;
    }
    public void setCapaciadade(int capaciadade) {
        this.capacidade = capaciadade;
    }
    public void novoLocal(Local local){
        
    }
}
