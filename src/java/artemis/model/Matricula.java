/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.model;

import javax.persistence.*;

/**
 *
 * @author Wallison
 */
@Entity
@Table(name="matricula")
public class Matricula {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "codMatricula")
    private long codMatricula;
    @Column(unique = true)
    private int numero;
    @ManyToOne
    @JoinColumn(name = "curso", referencedColumnName = "codCurso")
    private Curso curso;
    //Semestre atual
    private int periodo;
    
    public Matricula(){}
    
    public Matricula(long codMatricula, int numero, Curso curso, int periodo){
        setCodMatricula(codMatricula);
        setNumero(numero);
        setCurso(curso);
        setPeriodo(periodo);
    }
    
    public Matricula(int numero, Curso curso, int periodo){
        setNumero(numero);
        setCurso(curso);
        setPeriodo(periodo);
    }

    public long getCodMatricula() {
        return codMatricula;
    }

    public void setCodMatricula(long codMatricula) {
        if(codMatricula>0)
            this.codMatricula = codMatricula;
        else
            throw new IllegalArgumentException("Código da matrícula deve ser maior que zero!");
    }

    public int getNumero() {
        return numero;
    }

    public void setNumero(int numero) {
        if(numero >100000)
            this.numero = numero;
        else
            throw new IllegalArgumentException("Número de matrícula dever ao menos seis digitos!");
    }

    public Curso getCurso() {
        return curso;
    }

    public void setCurso(Curso curso) {
        if(curso != null)
            this.curso = curso;
        else
            throw new NullPointerException("Curso não pode ser nulo!");
    }

    public int getPeriodo() {
        return periodo;
    }

    public void setPeriodo(int periodo) {
        if(periodo>0)
            this.periodo = periodo;
        else
            throw new IllegalArgumentException("Periodo deve ser maior que zero!");
    }
    
    
}
