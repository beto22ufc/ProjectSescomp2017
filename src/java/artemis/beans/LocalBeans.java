/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.beans;

import artemis.model.Local;

/**
 *
 * @author ANGELO MATHEUS
 */
public class LocalBeans implements Beans{
    private long codLocal;
    private String nome;
    private int capacidade;

    public LocalBeans(){}
    public LocalBeans(long codLocal, String nome, int capacidade){
        setCodLocal(codLocal);
        setNome(nome);
        setCapacidade(capacidade);
    }
    public LocalBeans(String nome, int capacidade){
        setNome(nome);
        setCapacidade(capacidade);
    }
    
    public long getCodLocal() {
        return codLocal;
    }
    
    public void setCodLocal(long codLocal) {
        this.codLocal = codLocal;
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
    
    public void setCapacidade(int capacidade) {
        this.capacidade = capacidade;
    }

    @Override
    public Beans toBeans(Object o) {
        if(o != null){
            if(o instanceof Local){
                Local l = (Local) o;
                this.setCodLocal(l.getCodLocal());
                this.setNome(l.getNome());
                this.setCapacidade(l.getCapacidade());
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
        Local l = new Local();
        if(this.getCodLocal()>0){
            l.setCodLocal(this.getCodLocal());
        }
        if(this.getNome() != null || !this.getNome().isEmpty()){
            l.setNome(this.getNome());
        }
        if(this.getCapacidade()>=0){
            l.setCapaciadade(this.getCapacidade());
        }
        return l;
    }
}
