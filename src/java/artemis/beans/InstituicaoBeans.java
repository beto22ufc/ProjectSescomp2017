/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.beans;

import artemis.model.Atividade;
import artemis.model.Curso;
import artemis.model.Evento;
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
    private List<EventoBeans> eventos;
    private List<AtividadeBeans> atividades;
    
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

    public List<EventoBeans> getEventos() {
        return eventos;
    }

    public void setEventos(List<EventoBeans> eventos) {
        this.eventos = eventos;
    }

    public List<AtividadeBeans> getAtividades() {
        return atividades;
    }

    public void setAtividades(List<AtividadeBeans> atividades) {
        this.atividades = atividades;
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
                List<EventoBeans> eventos = Collections.synchronizedList(new ArrayList<EventoBeans>());
                List<AtividadeBeans> atividades = Collections.synchronizedList(new ArrayList<AtividadeBeans>());
                CursoBeans cb = null;
                for(int i=0;i<in.getCursos().size();i++){
                    cb = (CursoBeans) new CursoBeans().toBeans(in.getCursos().get(i));
                    cursos.add(cb);
                }
                this.setCursos(cursos);
                AtividadeBeans ab = null;
                for(int i=0;i<in.getAtividades().size();i++){
                    ab = (AtividadeBeans) new AtividadeBeans().toBeans(in.getAtividades().get(i));
                    atividades.add(ab);
                }
                this.setAtividades(atividades);
                EventoBeans eb = null;
                for(int i=0;i<in.getEventos().size();i++){
                    eb = (EventoBeans) new EventoBeans().toBeans(in.getEventos().get(i));
                    eventos.add(eb);
                }
                this.setEventos(eventos);
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
        if(this.getCursos()!=null){
            for(int i=0;i<this.getCursos().size();i++){
                cursos.add((Curso) this.getCursos().get(i).toBusiness());
            }
        }
        List<Usuario> associados = Collections.synchronizedList(new ArrayList<Usuario>());
        if(this.getAssociados() != null){
            for(int i=0;i<this.getAssociados().size();i++){
                associados.add((Usuario) this.getAssociados().get(i).toBusiness());
            }
        }
        List<Evento> eventos = Collections.synchronizedList(new ArrayList<Evento>());
        if(this.getEventos()!=null){
            for(int i=0;i<this.getEventos().size();i++){
                eventos.add((Evento) this.getEventos().get(i).toBusiness());
            }
        }
        List<Atividade> atividades = Collections.synchronizedList(new ArrayList<Atividade>());
        if(this.getAtividades()!=null){
            for(int i=0;i<this.getAtividades().size();i++){
                atividades.add((Atividade) this.getAtividades().get(i).toBusiness());
            }
        }
        Instituicao in = new Instituicao(this.getNome(), cursos);
        in.setAssociados(associados);
        in.setEventos(eventos);
        in.setAtividades(atividades);
        if(this.getCodInstituicao()>0){
            in.setCodInstituicao(this.getCodInstituicao());
        }
        return in;
    }
    
    
}
