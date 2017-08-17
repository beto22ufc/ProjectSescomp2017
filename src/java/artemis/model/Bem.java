package artemis.model;

import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDate;
import javax.persistence.*;

@Converter(autoApply = true)
@Entity
@Table(name="bem")
public class Bem implements AttributeConverter<LocalDate, Date>{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="codBem")
    private long codBem;
    private String nome;
    private float preco;
    private boolean comprado;
    @Column
    private LocalDate fabricado;
    @Column
    private LocalDate validade;
    private String classificacao;
    private int tipo;

    public Bem(){

    }
	
    public Bem(long codBem, String nome, float preco, boolean comprado, LocalDate fabricado, LocalDate validade, String classificacao, int tipo){
        setCodBem(codBem);
        setNome(nome);
        setPreco(preco);
        setComprado(comprado);
        setFabricado(fabricado);
        setValidade(validade);
        setClassficacao(classificacao);
        setTipo(tipo);
    }
	
    public Bem(String nome, float preco, boolean comprado, LocalDate fabricado, LocalDate validade, String classificacao, int tipo){
        setNome(nome);
        setPreco(preco);
        setComprado(comprado);
        setFabricado(fabricado);
        setValidade(validade);
        setClassficacao(classificacao);
        setTipo(tipo);
    }
	
	public long getCodBem() {
		return codBem;
	}
	public void setCodBem(long codBem){
            this.codBem = codBem;
	}
	public String getNome() {
            return nome;
	}
	public void setNome(String nome){
            this.nome = nome;
	}
	public float getPreco() {
		return preco;
	}
	public void setPreco(float preco) {
		this.preco = preco;
	}
	public boolean isComprado() {
		return comprado;
	}
	public void setComprado(boolean comprado) {
		this.comprado = comprado;
	}
	public LocalDate getFabricado() {
		return fabricado;
	}
	public void setFabricado(LocalDate fabricado) {
		this.fabricado = fabricado;
	}
	public LocalDate getValidade() {
		return validade;
	}
	public void setValidade(LocalDate validade) {
		this.validade = validade;
	}
	public String getClassficacao() {
		return classificacao;
	}
	public void setClassficacao(String classficacao) {
		this.classificacao = classficacao;
	}
	public int getTipo() {
		return tipo;
	}
	public void setTipo(int tipo) {
		this.tipo = tipo;
	}
        public void novoBem(Bem bem){
            
        }	

    @Override
    public Date convertToDatabaseColumn(LocalDate attribute) {
        return (attribute == null ? null : Date.valueOf(attribute));
    }

    @Override
    public LocalDate convertToEntityAttribute(Date dbData) {
        return (dbData == null ? null : dbData.toLocalDate());
    }
}
