/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.beans;

import artemis.model.Curso;
import artemis.model.Usuario;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 *
 * @author Wallison
 */
public class CursoBeans implements Beans, Serializable{
    private long codCurso;
    private String nome;
    private String descricao;
    //Anos
    private int duracao;

    public CursoBeans(){
    
    }
    
    public CursoBeans(long codCurso, String nome, String descricao, int duracao){
        setCodCurso(codCurso);
        setNome(nome);
        setDescricao(descricao);
        setDuracao(duracao);
    }
    
    public CursoBeans(long codCurso, String nome, int duracao){
        setCodCurso(codCurso);
        setNome(nome);
        setDuracao(duracao);
    }
    
    public CursoBeans(String nome, String descricao, int duracao){
        setNome(nome);
        setDescricao(descricao);
        setDuracao(duracao);
    }
    public CursoBeans(String nome, int duracao){
        setNome(nome);
        setDuracao(duracao);
    }
    
    public long getCodCurso() {
        return codCurso;
    }

    public void setCodCurso(long codCurso) {
        this.codCurso = codCurso;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public int getDuracao() {
        return duracao;
    }

    public void setDuracao(int duracao) {
        this.duracao = duracao;
    }

    @Override
    public Beans toBeans(Object o) {
        if(o != null){
            if(o instanceof Curso){
                Curso c = (Curso) o;
                this.setCodCurso(c.getCodCurso());
                this.setNome(c.getNome());
                this.setDescricao(c.getDescricao());
                this.setDuracao(c.getDuracao());
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
        UsuarioBeans ub = null;
        Curso c = new Curso(this.getNome(), this.getDuracao());
        if(this.getCodCurso()>0){
            c.setCodCurso(this.getCodCurso());
        }
        if(this.getDescricao() != null && !this.getDescricao().isEmpty()){
            c.setDescricao(this.getDescricao());
        }
        return c;
    }
    
    
}
