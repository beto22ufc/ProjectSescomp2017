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
@Table(name="instituicao")
public class Instituicao {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="codInstituicao")
    private long codInstituicao;
    private String nome;
    @ManyToMany(targetEntity = Curso.class, cascade = CascadeType.ALL)
    @JoinTable(name= "instituicao_curso", joinColumns = {@JoinColumn(name="instituicao", referencedColumnName = "codInstituicao")}
       , inverseJoinColumns = {@JoinColumn(name="curso", referencedColumnName = "codCurso")})
    private List<Curso> cursos;
    @ManyToMany(targetEntity = Usuario.class, cascade = CascadeType.ALL)
    @JoinTable(name= "instituicao_associados", joinColumns = {@JoinColumn(name="instituicao", referencedColumnName = "codInstituicao")}
       , inverseJoinColumns = {@JoinColumn(name="usuario", referencedColumnName = "codUsuario")})
    private List<Usuario> associados;

    public Instituicao(){
    
    }
    
    public Instituicao(long codInstituicao, String nome, List<Curso> cursos){
        setCodInstituicao(codInstituicao);
        setNome(nome);
        setCursos(cursos);
    }
    
    public Instituicao(String nome, List<Curso> cursos){
        setNome(nome);
        setCursos(cursos);
    }
    
    public long getCodInstituicao() {
        return codInstituicao;
    }

    public void setCodInstituicao(long codInstituicao) {
        if(codInstituicao>0)
            this.codInstituicao = codInstituicao;
        else
            throw new IllegalArgumentException("Código de instituição deve ser maior que zero!");
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        if(nome != null && !nome.isEmpty())
            this.nome = nome;
        else 
            throw new NullPointerException("Nome de instituição nao pode ser vazio!");
    }

    public List<Curso> getCursos() {
        return cursos;
    }

    public void setCursos(List<Curso> cursos) {
        if(cursos != null)
            this.cursos = cursos;
        else
            throw new NullPointerException("Lista de cursos não pode ser nula!");
    }

    public List<Usuario> getAssociados() {
        return associados;
    }

    public void setAssociados(List<Usuario> associados) {
        if(associados != null)
            this.associados = associados;
        else
            throw new NullPointerException("Lista de associados não pode ser nula!");
    }
    
    
    
}
