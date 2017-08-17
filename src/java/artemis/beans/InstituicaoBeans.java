/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.beans;

import artemis.model.Curso;
import artemis.model.Instituicao;
import artemis.model.Usuario;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 *
 * @author Wallison
 */
public class InstituicaoBeans implements Beans{
    private long codInstituicao;
    private String nome;
    private List<CursoBeans> cursos;
    private List<UsuarioBeans> associados;
    public InstituicaoBeans(){
    
    }
    
    public InstituicaoBeans(long codInstituicao, String nome, List<CursoBeans> cursos){
        setCodInstituicao(codInstituicao);
        setNome(nome);
        setCursos(cursos);
    }
    
    public InstituicaoBeans(String nome, List<CursoBeans> cursos){
        setNome(nome);
        setCursos(cursos);
    }
    
    public long getCodInstituicao() {
        return codInstituicao;
    }

    public void setCodInstituicao(long codInstituicao) {
        this.codInstituicao = codInstituicao;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public List<CursoBeans> getCursos() {
        return cursos;
    }

    public void setCursos(List<CursoBeans> cursos) {
        this.cursos = cursos;
    }

    public List<UsuarioBeans> getAssociados() {
        return associados;
    }

    public void setAssociados(List<UsuarioBeans> associados) {
        this.associados = associados;
    }
    
    

    @Override
    public Beans toBeans(Object o) {
        if(o != null){
            if(o instanceof Instituicao){
                Instituicao in = (Instituicao) o;
                this.setCodInstituicao(in.getCodInstituicao());
                this.setNome(in.getNome());
                List<CursoBeans> cursos = Collections.synchronizedList(new ArrayList<CursoBeans>());
                List<UsuarioBeans> associados = Collections.synchronizedList(new ArrayList<UsuarioBeans>());
                CursoBeans cb = null;
                for(int i=0;i<in.getCursos().size();i++){
                    cb = (CursoBeans) new CursoBeans().toBeans(in.getCursos().get(i));
                    cursos.add(cb);
                }
                this.setCursos(cursos);
                UsuarioBeans ub = null;
                for(int i=0;i<in.getAssociados().size();i++){
                    ub = (UsuarioBeans) new UsuarioBeans().toBeans(in.getAssociados().get(i));
                    associados.add(ub);
                }
                this.setAssociados(associados);
                return this;
            }else{
                throw new IllegalArgumentException("Isso não é uma Instituição!");
            }
        }else{
            throw new NullPointerException("Instituição não pode ser nula!");
        }
    }

    @Override
    public Object toBusiness() {
        List<Curso> cursos = Collections.synchronizedList(new ArrayList<Curso>());
        for(int i=0;i<this.getCursos().size();i++){
            cursos.add((Curso) this.getCursos().get(i).toBusiness());
        }
        List<Usuario> associados = Collections.synchronizedList(new ArrayList<Usuario>());
        for(int i=0;i<this.getAssociados().size();i++){
            associados.add((Usuario) this.getAssociados().get(i).toBusiness());
        }
        Instituicao in = new Instituicao(this.getNome(), cursos);
        in.setAssociados(associados);
        if(this.getCodInstituicao()>0){
            in.setCodInstituicao(this.getCodInstituicao());
        }
        return in;
    }
    
    
}
