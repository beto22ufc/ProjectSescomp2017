/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.beans;

import artemis.model.Atividade;
import artemis.model.Evento;
import artemis.model.InscricaoEvento;
import artemis.model.Localizacao;
import artemis.model.Periodo;
import artemis.model.Usuario;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 *
 * @author Wallison
 */
public class EventoBeans implements Beans, InscrevivelBeans{
    private long codEvento;
    private String nome;
    private String descricao;
    private List<PeriodoBeans> periodos;
    private String categoria;
    private List<InscricaoEventoBeans> inscricoes;
    private List<AtividadeBeans> atividades;
    private List<UsuarioBeans> administradores;
    private List<EventoBeans> eventos;
    private LocalizacaoBeans localizacao;
    
    public EventoBeans(){
    
    }
    public EventoBeans(long codEvento, String nome, String descricao, List<PeriodoBeans> periodos){
        setCodEvento(codEvento);
        setNome(nome);
        setDescricao(descricao);
        setPeriodos(periodos);
    }
    public EventoBeans(String nome, String descricao, List<PeriodoBeans> periodos){
        setNome(nome);
        setDescricao(descricao);
        setPeriodos(periodos);
    }

    public long getCodEvento() {
        return codEvento;
    }

    public void setCodEvento(long codEvento) {
        this.codEvento = codEvento;
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

    public List<PeriodoBeans> getPeriodos() {
        return periodos;
    }

    public void setPeriodos(List<PeriodoBeans> periodos) {
        this.periodos = periodos;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public List<InscricaoEventoBeans> getInscricoes() {
        return inscricoes;
    }

    public void setInscricoes(List<InscricaoEventoBeans> inscricoes) {
        this.inscricoes = inscricoes;
    }

    public List<AtividadeBeans> getAtividades() {
        return atividades;
    }

    public void setAtividades(List<AtividadeBeans> atividades) {
        this.atividades = atividades;
    }

    public List<UsuarioBeans> getAdministradores() {
        return administradores;
    }

    public void setAdministradores(List<UsuarioBeans> administradores) {
        this.administradores = administradores;
    }

    public List<EventoBeans> getEventos() {
        return eventos;
    }

    public void setEventos(List<EventoBeans> eventos) {
        this.eventos = eventos;
    }

    public LocalizacaoBeans getLocalizacao() {
        return localizacao;
    }

    public void setLocalizacao(LocalizacaoBeans localizacao) {
        this.localizacao = localizacao;
    }
    
    
    
    @Override
    public Beans toBeans(Object o) {
        if(o != null){
            if(o instanceof Evento){
                Evento e = (Evento) o;
                this.setCodEvento(e.getCodEvento());
                this.setNome(e.getNome());
                this.setDescricao(e.getDescricao());
                this.setCategoria(e.getCategoria());
                List<InscricaoEventoBeans> inscricoes = Collections.synchronizedList(new ArrayList<InscricaoEventoBeans>());
                List<PeriodoBeans> periodos = Collections.synchronizedList(new ArrayList<PeriodoBeans>());
                List<AtividadeBeans> atividades = Collections.synchronizedList(new ArrayList<AtividadeBeans>());
                List<UsuarioBeans> administradores = Collections.synchronizedList(new ArrayList<UsuarioBeans>());
                List<EventoBeans> eventos = Collections.synchronizedList(new ArrayList<EventoBeans>());
                InscricaoEventoBeans inscricaoBeans = null;
                for(int i=0;i<e.getInscricoes().size();i++){
                    inscricaoBeans = new InscricaoEventoBeans();
                    inscricaoBeans.toBeans(e.getInscricoes().get(i));
                    inscricoes.add(inscricaoBeans);
                }
                this.setInscricoes(inscricoes);
                inscricaoBeans = null;
                EventoBeans eventoBeans = null;
                for(int i=0;i<e.getEventos().size();i++){
                    eventoBeans = new EventoBeans();
                    eventoBeans.toBeans(e.getEventos().get(i));
                    eventos.add(eventoBeans);
                }
                this.setEventos(eventos);
                eventoBeans = null;
                 UsuarioBeans usuarioBeans = null;
                for(int i=0;i<e.getAdministradores().size();i++){
                    usuarioBeans = new UsuarioBeans();
                    usuarioBeans.toBeans(e.getAdministradores().get(i));
                    administradores.add(usuarioBeans);
                }
                this.setAdministradores(administradores);
                usuarioBeans = null;
                PeriodoBeans periodoBeans = null;
                for(int i=0;i<e.getPeriodos().size();i++){
                    periodoBeans = new PeriodoBeans();
                    periodoBeans.toBeans(e.getPeriodos().get(i));
                    periodos.add(periodoBeans);
                }
                periodoBeans = null;
                this.setPeriodos(periodos);
                AtividadeBeans atividadeBeans = null;
                for(int i=0;i<e.getAtividades().size();i++){
                    atividadeBeans = new AtividadeBeans();
                    atividadeBeans.toBeans(e.getAtividades().get(i));
                    atividades.add(atividadeBeans);
                }
                periodoBeans = null;
                this.setAtividades(atividades);
                LocalizacaoBeans localizacao = (LocalizacaoBeans) new LocalizacaoBeans().toBeans(e.getLocalizacao());
                this.setLocalizacao(localizacao);
                return this;
            }else{
                throw new IllegalArgumentException("Isso não é um Evento!");
            }
        }else{
            throw new NullPointerException("Evento não pode ser nulo!");
        }
    }

    @Override
    public Object toBusiness() {
        List<InscricaoEvento> inscricoes = Collections.synchronizedList(new ArrayList<InscricaoEvento>());
        List<Periodo> periodos = Collections.synchronizedList(new ArrayList<Periodo>());
        List<Atividade> atividades = Collections.synchronizedList(new ArrayList<Atividade>());
        List<Usuario> administradores = Collections.synchronizedList(new ArrayList<Usuario>());
        List<Evento> eventos = Collections.synchronizedList(new ArrayList<Evento>());
        if(this.getInscricoes()!= null){
            for(int i=0;i<this.getInscricoes().size();i++){
                inscricoes.add((InscricaoEvento)this.getInscricoes().get(i).toBusiness());
            }
        }
        if(this.getAdministradores()!= null){
            for(int i=0;i<this.getAdministradores().size();i++){
                administradores.add((Usuario)this.getAdministradores().get(i).toBusiness());
            }
        }
        if(this.getEventos() != null){
            for(int i=0;i<this.getEventos().size();i++){
                eventos.add((Evento)this.getEventos().get(i).toBusiness());
            }
        }
        if(this.getPeriodos() != null){
            for(int i=0;i<this.getPeriodos().size();i++){
                periodos.add((Periodo)this.getPeriodos().get(i).toBusiness());
            }
        }
        if(this.getAtividades() != null){
            for(int i=0;i<this.getAtividades().size();i++){
                atividades.add((Atividade)this.getAtividades().get(i).toBusiness());
            }
        }
        Evento e = new Evento(this.getNome(), this.getDescricao(), periodos);
        e.setPeriodos(periodos);
        e.setInscricoes(inscricoes);
        e.setAtividades(atividades);
        e.setAdministradores(administradores);
        e.setEventos(eventos);
        if(this.getCodEvento()>0){
            e.setCodEvento(this.getCodEvento());
        };
        if(this.getCategoria()!=null && !this.getCategoria().isEmpty()){
            e.setCategoria(this.getCategoria());
        }
        if(this.getLocalizacao()!= null){
            e.setLocalizacao((Localizacao) this.getLocalizacao().toBusiness());
        }
        return e;
    }
    
}

