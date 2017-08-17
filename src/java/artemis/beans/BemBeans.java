/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.beans;

import artemis.model.Bem;
import artemis.model.Local;
import java.time.LocalDate;
import java.util.Calendar;

/**
 *
 * @author ANGELO MATHEUS
 */
public class BemBeans implements Beans{
	private long codBem;
	private String nome;
	private float preco;
	private boolean comprado;
	private LocalDate fabricado;
	private LocalDate validade;
	private String classficacao;
	private int tipo;
	
	public BemBeans(){}
	
	public BemBeans(long codBem, String nome, float preco, boolean comprado, LocalDate fabricado, LocalDate validade, String classificacao, int tipo) {
		setCodBem(codBem);
		setNome(nome);
		setPreco(preco);
		setComprado(comprado);
		setFabricado(fabricado);
		setValidade(validade);
		setClassficacao(classificacao);
		setTipo(tipo);
	}
	
	public BemBeans(String nome, float preco, boolean comprado, LocalDate fabricado, LocalDate validade, String classificacao, int tipo){
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
	public void setCodBem(long codBem) {
		this.codBem = codBem;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
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
		return classficacao;
	}
	public void setClassficacao(String classficacao) {
		this.classficacao = classficacao;
	}
	public int getTipo() {
		return tipo;
	}
	public void setTipo(int tipo) {
		this.tipo = tipo;
	}  

    @Override
    public Beans toBeans(Object o) {
        if(o != null){
            if(o instanceof Bem){
                Bem b = (Bem) o;
                this.setCodBem(b.getCodBem());
                this.setComprado(b.isComprado());
                this.setNome(b.getNome());
                this.setPreco(b.getPreco());
                this.setValidade(b.getValidade());
                this.setTipo(b.getTipo());
                this.setFabricado(b.getFabricado());
                this.setClassficacao(b.getClassficacao());
                return this;
            }else{
                throw new IllegalArgumentException("Isso não é um Bem!");
            }
        }else{
            throw new NullPointerException("Bem não pode ser nulo!");
        }
    }

    @Override
    public Object toBusiness() {
        Bem b = new Bem(this.getNome(), this.getPreco(), this.isComprado(), this.getFabricado(), this.getValidade(), this.getClassficacao(), this.getTipo());
        if(this.getCodBem()>0){
            b.setCodBem(this.getCodBem());
        }
        return b;
    }
}
