/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.model;

import artemis.DAO.CursoDAOImpl;
import artemis.DAO.UsuarioDAOImpl;
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
    private int duracao;
   
    public Curso(){
    
    }
    
    public Curso(long codCurso, String nome, String descricao, int duracao){
        setCodCurso(codCurso);
        setNome(nome);
        setDescricao(descricao);
        setDuracao(duracao);
    }
    
    public Curso(long codCurso, String nome, int duracao){
        setCodCurso(codCurso);
        setNome(nome);
        setDuracao(duracao);
    }
    
    public Curso(String nome, String descricao, int duracao){
        setNome(nome);
        setDescricao(descricao);
        setDuracao(duracao);
    }
    
    public Curso(String nome, int duracao){
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

    public int getDuracao() {
        return duracao;
    }

    public void setDuracao(int duracao) {
        if(duracao>0)
            this.duracao = duracao;
        else
            throw new NullPointerException("Curso deve durar pelo menos 1 ano!");
    }    
 
    public boolean alunoAssociado(){
        UsuarioDAOImpl udao = new UsuarioDAOImpl();
        List<Usuario> usuarios = udao.listaUsuarios();
        for(Usuario usuario : usuarios){
            if(usuario.getMatricula() !=null){
                if(usuario.getMatricula().getCurso().getCodCurso() == this.getCodCurso()){
                    return true;
                }
            }                
        }
        return false;    
    }
    
    public void atualizaCurso(Curso curso) throws IllegalAccessException{
        CursoDAOImpl cdao = new CursoDAOImpl();
        cdao.atualizarCurso(curso);
    }
}
