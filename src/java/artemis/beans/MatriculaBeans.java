/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.beans;

import artemis.model.Curso;
import artemis.model.Matricula;

/**
 *
 * @author Wallison
 */
public class MatriculaBeans implements Beans{
    private long codMatricula;
    private int numero;
    private CursoBeans curso;
    //Semestre atual
    private byte periodo;
    
    public MatriculaBeans(){}
    
    public MatriculaBeans(long codMatricula, int numero, CursoBeans curso, byte periodo){
        setCodMatricula(codMatricula);
        setNumero(numero);
        setCurso(curso);
        setPeriodo(periodo);
    }
    
    public MatriculaBeans(int numero, CursoBeans curso, byte periodo){
        setNumero(numero);
        setCurso(curso);
        setPeriodo(periodo);
    }

    public long getCodMatricula() {
        return codMatricula;
    }

    public void setCodMatricula(long codMatricula) {
        this.codMatricula = codMatricula;
    }

    public int getNumero() {
        return numero;
    }

    public void setNumero(int numero) {
        this.numero = numero;
    }

    public CursoBeans getCurso() {
        return curso;
    }

    public void setCurso(CursoBeans curso) {
        this.curso = curso;
    }

    public byte getPeriodo() {
        return periodo;
    }

    public void setPeriodo(byte periodo) {
        this.periodo = periodo;
    }

    @Override
    public Beans toBeans(Object o) {
        if(o != null){
            if(o instanceof Matricula){
                Matricula m = (Matricula) o;
                this.setCodMatricula(m.getCodMatricula());
                this.setNumero(m.getNumero());
                this.setPeriodo(this.getPeriodo());
                this.setCurso((CursoBeans)new CursoBeans().toBeans(m.getCurso()));
                return this;
            }else{
                throw new IllegalArgumentException("Isso não é uma matrícula!");
            }
        }else{
            throw new NullPointerException("MatriculaBeans: Matrícula não pode ser nula!");
        }
    }

    @Override
    public Object toBusiness() {
        Matricula m = new Matricula(this.getNumero(), (Curso) this.getCurso().toBusiness(), this.getPeriodo());
        if(this.getCodMatricula()>0){
            m.setCodMatricula(this.getCodMatricula());
        }
        return m;
    }
    
    
}
