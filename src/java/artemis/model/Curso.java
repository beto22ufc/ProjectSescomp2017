/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.model;

import java.util.List;
import javax.persistence.*;

/**
 *
 * @author Wallison
 */
@Entity
@Table(name="curso")
public class Curso {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="codCurso")
    private long codCurso;
    private String nome;
    private String descricao;
    //Anos
    private byte duracao;
   
    public Curso(){
    
    }
    
    public Curso(long codCurso, String nome, String descricao, byte duracao){
        setCodCurso(codCurso);
        setNome(nome);
        setDescricao(descricao);
        setDuracao(duracao);
    }
    
    public Curso(long codCurso, String nome, byte duracao){
        setCodCurso(codCurso);
        setNome(nome);
        setDuracao(duracao);
    }
    
    public Curso(String nome, String descricao, byte duracao){
        setNome(nome);
        setDescricao(descricao);
        setDuracao(duracao);
    }
    
    public Curso(String nome, byte duracao){
        setNome(nome);
        setDuracao(duracao);
    }
    
    public long getCodCurso() {
        return codCurso;
    }

    public void setCodCurso(long codCurso) {
        if(codCurso >0)
            this.codCurso = codCurso;
        else
            throw new IllegalArgumentException("Código do curso deve ser maior que zero!");
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        if(nome != null && !nome.isEmpty())
            this.nome = nome;
        else
            throw new NullPointerException("Nome de curso não pode ser vazio!");
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        if(descricao != null && !descricao.isEmpty())
            this.descricao = descricao;
        else
            throw new NullPointerException("Descrição de curso não pode ser vazia!");
    }

    public byte getDuracao() {
        return duracao;
    }

    public void setDuracao(byte duracao) {
        if(duracao>0)
            this.duracao = duracao;
        else
            throw new NullPointerException("Curso deve durar pelo menos 1 ano!");
    }    
    
}
