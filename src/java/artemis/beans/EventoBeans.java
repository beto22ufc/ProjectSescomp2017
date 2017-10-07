/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.beans;

import artemis.model.Atividade;
import artemis.model.ContasSociais;
import artemis.model.Evento;
import artemis.model.Imagem;
import artemis.model.Inscricao;
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
    private List<InscricaoBeans> inscricoes;
    private List<AtividadeBeans> atividades;
    private List<UsuarioBeans> administradores;
    private List<UsuarioBeans> organizadores;
    private List<EventoBeans> eventos;
    private List<ImagemBeans> galeria;
    private List<ImagemBeans> slideshow;
    private String email;
    private LocalizacaoBeans localizacao;
    private ContasSociaisBeans contasSociais;
    private String tema = "default";
    private boolean temCertificado = true;
    private boolean temInscricao = true;
    private float porcentagemMinimaGerarCertifciado;
    
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

    public List<InscricaoBeans> getInscricoes() {
        return inscricoes;
    }

    public void setInscricoes(List<InscricaoBeans> inscricoes) {
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

    public List<ImagemBeans> getGaleria() {
        return galeria;
    }

    public void setGaleria(List<ImagemBeans> galeria) {
        this.galeria = galeria;
    }

    public List<ImagemBeans> getSlideshow() {
        return slideshow;
    }

    public void setSlideshow(List<ImagemBeans> slideshow) {
        this.slideshow = slideshow;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public ContasSociaisBeans getContasSociais() {
        return contasSociais;
    }

    public void setContasSociais(ContasSociaisBeans contasSociais) {
        this.contasSociais = contasSociais;
    }

    public List<UsuarioBeans> getOrganizadores() {
        return organizadores;
    }

    public void setOrganizadores(List<UsuarioBeans> organizadores) {
        this.organizadores = organizadores;
    }

    public String getTema() {
        return tema;
    }

    public void setTema(String tema) {
        this.tema = tema;
    }

    public boolean isTemCertificado() {
        return temCertificado;
    }

    public void setTemCertificado(boolean temCertificado) {
        this.temCertificado = temCertificado;
    }

    public boolean isTemInscricao() {
        return temInscricao;
    }

    public void setTemInscricao(boolean temInscricao) {
        this.temInscricao = temInscricao;
    }

    public float getPorcentagemMinimaGerarCertifciado() {
        return porcentagemMinimaGerarCertifciado;
    }

    public void setPorcentagemMinimaGerarCertifciado(float porcentagemMinimaGerarCertifciado) {
        this.porcentagemMinimaGerarCertifciado = porcentagemMinimaGerarCertifciado;
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
                this.setPorcentagemMinimaGerarCertifciado(e.getPorcentagemMinimaGerarCertifciado());
                this.setTemCertificado(e.isTemCertificado());
                this.setTemInscricao(e.isTemInscricao());
                this.setTema(e.getTema());
                List<InscricaoBeans> inscricoes = Collections.synchronizedList(new ArrayList<InscricaoBeans>());
                List<PeriodoBeans> periodos = Collections.synchronizedList(new ArrayList<PeriodoBeans>());
                List<AtividadeBeans> atividades = Collections.synchronizedList(new ArrayList<AtividadeBeans>());
                List<UsuarioBeans> administradores = Collections.synchronizedList(new ArrayList<UsuarioBeans>());
                List<UsuarioBeans> organizadores = Collections.synchronizedList(new ArrayList<UsuarioBeans>());
                List<EventoBeans> eventos = Collections.synchronizedList(new ArrayList<EventoBeans>());
                List<ImagemBeans> slideshow = Collections.synchronizedList(new ArrayList<ImagemBeans>());
                List<ImagemBeans> galeria = Collections.synchronizedList(new ArrayList<ImagemBeans>());
                ImagemBeans imagemBeans = null;
                if(e.getSlideshow() != null){
                    for(int i=0;i<e.getSlideshow().size();i++){
                        imagemBeans = new ImagemBeans();
                        imagemBeans.toBeans(e.getSlideshow().get(i));
                        slideshow.add(imagemBeans);
                    }
                }
                if(e.getGaleria() != null){
                    for(int i=0;i<e.getGaleria().size();i++){
                        imagemBeans = new ImagemBeans();
                        imagemBeans.toBeans(e.getGaleria().get(i));
                        galeria.add(imagemBeans);
                    }
                }
                InscricaoBeans inscricaoBeans = null;
                for(int i=0;i<e.getInscricoes().size();i++){
                    inscricaoBeans = new InscricaoBeans();
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
                for(int i=0;i<e.getOrganizadores().size();i++){
                    usuarioBeans = new UsuarioBeans();
                    usuarioBeans.toBeans(e.getOrganizadores().get(i));
                    organizadores.add(usuarioBeans);
                }
                this.setOrganizadores(organizadores);
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
                this.setEmail(e.getEmail());
                if(e.getContasSociais() != null){
                    this.setContasSociais((ContasSociaisBeans) new ContasSociaisBeans().toBeans(e.getContasSociais()));
                }
                LocalizacaoBeans localizacao = (LocalizacaoBeans) new LocalizacaoBeans().toBeans(e.getLocalizacao());
                this.setLocalizacao(localizacao);
                this.setGaleria(galeria);
                this.setSlideshow(slideshow);
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
        List<Inscricao> inscricoes = Collections.synchronizedList(new ArrayList<Inscricao>());
        List<Periodo> periodos = Collections.synchronizedList(new ArrayList<Periodo>());
        List<Atividade> atividades = Collections.synchronizedList(new ArrayList<Atividade>());
        List<Usuario> administradores = Collections.synchronizedList(new ArrayList<Usuario>());
        List<Usuario> organizadores = Collections.synchronizedList(new ArrayList<Usuario>());
        List<Evento> eventos = Collections.synchronizedList(new ArrayList<Evento>());
        List<Imagem> galeria = Collections.synchronizedList(new ArrayList<Imagem>());
        List<Imagem> slideshow = Collections.synchronizedList(new ArrayList<Imagem>());
        if(this.getSlideshow() != null){
            for(int i=0;i<this.getSlideshow().size();i++){
                slideshow.add((Imagem) this.getSlideshow().get(i).toBusiness());
            }   
        }
        if(this.getGaleria()!= null){
            for(int i=0;i<this.getGaleria().size();i++){
                galeria.add((Imagem) this.getGaleria().get(i).toBusiness());
            }   
        }
        
        if(this.getInscricoes()!= null){
            for(int i=0;i<this.getInscricoes().size();i++){
                inscricoes.add((Inscricao)this.getInscricoes().get(i).toBusiness());
            }
        }
        if(this.getAdministradores()!= null){
            for(int i=0;i<this.getAdministradores().size();i++){
                administradores.add((Usuario)this.getAdministradores().get(i).toBusiness());
            }
        }
        if(this.getOrganizadores()!= null){
            for(int i=0;i<this.getOrganizadores().size();i++){
                organizadores.add((Usuario)this.getOrganizadores().get(i).toBusiness());
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
        e.setOrganizadores(organizadores);
        e.setEventos(eventos);
        e.setGaleria(galeria);
        e.setSlideshow(slideshow);
        e.setPorcentagemMinimaGerarCertifciado(this.getPorcentagemMinimaGerarCertifciado());
        e.setTemCertificado(this.isTemCertificado());
        e.setTemInscricao(this.isTemInscricao());
        e.setTema(this.getTema());
        if(this.getCodEvento()>0){
            e.setCodEvento(this.getCodEvento());
        };
        if(this.getCategoria()!=null && !this.getCategoria().isEmpty()){
            e.setCategoria(this.getCategoria());
        }
        if(this.getLocalizacao()!= null){
            e.setLocalizacao((Localizacao) this.getLocalizacao().toBusiness());
        }
        if(this.getEmail() != null){
            e.setEmail(this.getEmail());
        }
        if(this.getContasSociais() != null){
            e.setContasSociais((ContasSociais) this.getContasSociais().toBusiness());
        }
        return e;
    }
   
    @Override
    public boolean equals(Object o){
        return (this.getCodEvento()==((EventoBeans) o).getCodEvento());
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 97 * hash + (int) (this.codEvento ^ (this.codEvento >>> 32));
        return hash;
    }
}

