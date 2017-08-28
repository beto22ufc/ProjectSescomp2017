/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.beans;

import artemis.model.Atividade;
import artemis.model.Espera;
import artemis.model.Inscricao;
import artemis.model.Periodo;
import artemis.model.Reserva;
import artemis.model.ReservaBem;
import artemis.model.ReservaLocal;
import artemis.model.Usuario;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;


public class AtividadeBeans implements Beans, InscrevivelBeans{
    private long codAtividade;
    private String nome;
    private String descricao;
    private List<PeriodoBeans> periodoBeanses;
    private UsuarioBeans ministrante;
    private String categoria;
    private int vagasInternas;
    private int vagasPublicas;
    private int limiteVagas;
    private int nivel;
    private int tipoPagamento;
    private List<InscricaoBeans> inscricoes;
    private List<ReservaLocalBeans> locaisReservados;
    private List<ReservaBemBeans> bensReservados;
    private List<EsperaBeans> listaDeEspera;
    private List<UsuarioBeans> administradores;
    private List<UsuarioBeans> organizadores;
    private String recursosSolicitados;
	
    public AtividadeBeans(){}
    public AtividadeBeans(long codAtividade, String nome, String descricao, List<PeriodoBeans> periodoBeanses, UsuarioBeans ministrante, 
    		String categoria, int vagasInternas, int vagasPublicas, int limiteVagas, int nivel, int tipoPagamentos, List<ReservaLocalBeans> locaisReservados, List<ReservaBemBeans> bensReservados, List<EsperaBeans>listeDeEspera
    		){
    	setCodAtividade(codAtividade);
    	setNome(nome);
    	setDescricao(descricao);
    	setHorarios(periodoBeanses);
    	setBensReservados(bensReservados);
    	setCategoria(categoria);
    	setLimiteVagas(tipoPagamentos);
    	setListaDeEspera(listeDeEspera);
    	setLocaisReservados(locaisReservados);
    	setNivel(nivel);
    	setMinistrante(ministrante);
    	setVagasPublicas(vagasPublicas);
    	setVagasInternas(vagasInternas);
    	setTipoPagamento(tipoPagamentos);
    }
    
    public AtividadeBeans(String nome, String descricao, List<PeriodoBeans> horarios, UsuarioBeans ministrante, 
    		String categoria, int vagasInternas, int vagasPublicas, int limiteVagas, int nivel, int tipoPagamentos, List<ReservaLocalBeans> locaisReservados, List<ReservaBemBeans> bensReservados, List<EsperaBeans>listeDeEspera
    		){
    	setNome(nome);
    	setDescricao(descricao);
    	setHorarios(horarios);
    	setBensReservados(bensReservados);
    	setCategoria(categoria);
    	setLimiteVagas(tipoPagamentos);
    	setListaDeEspera(listeDeEspera);
    	setLocaisReservados(locaisReservados);
    	setNivel(nivel);
    	setMinistrante(ministrante);
    	setVagasPublicas(vagasPublicas);
    	setVagasInternas(vagasInternas);
    	setTipoPagamento(tipoPagamentos);
    }
    
    
    public long getCodAtividade() {
        return codAtividade;
    }
    public void setCodAtividade(long codAtividade) {
        this.codAtividade = codAtividade;
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
    public List<PeriodoBeans> getHorarios() {
        return periodoBeanses;
    }
    public void setHorarios(List<PeriodoBeans> periodoBeanses) {
        this.periodoBeanses = periodoBeanses;
    }
    public UsuarioBeans getMinistrante() {
        return ministrante;
    }
    public void setMinistrante(UsuarioBeans ministrante) {
        this.ministrante = ministrante;
    }
    public String getCategoria() {
        return categoria;
    }
    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }
    public int getVagasInternas() {
        return vagasInternas;
    }
    public void setVagasInternas(int vagasInternas) {
        this.vagasInternas = vagasInternas;
    }
    public int getVagasPublicas() {
        return vagasPublicas;
    }
    public void setVagasPublicas(int vagasPublicas) {
        this.vagasPublicas = vagasPublicas;
    }
    public int getLimiteVagas() {
        return limiteVagas;
    }
    public void setLimiteVagas(int limiteVagas) {
        this.limiteVagas = limiteVagas;
    }
    public int getNivel() {
        return nivel;
    }
    public void setNivel(int nivel) {
        this.nivel = nivel;
    }
    public int getTipoPagamento() {
        return tipoPagamento;
    }
    public void setTipoPagamento(int tipoPagamento) {
        this.tipoPagamento = tipoPagamento;
    }
    public List<ReservaLocalBeans> getLocaisReservados() {
        return locaisReservados;
    }
    public void setLocaisReservados(List<ReservaLocalBeans> locaisReservados) {
        this.locaisReservados = locaisReservados;
    }
    public List<ReservaBemBeans> getBensReservados() {
        return bensReservados;
    }
    public void setBensReservados(List<ReservaBemBeans> bensReservados) {
        this.bensReservados = bensReservados;
    }
    public List<EsperaBeans> getListaDeEspera() {
        return listaDeEspera;
    }
    public void setListaDeEspera(List<EsperaBeans> listaDeEspera) {
        this.listaDeEspera = listaDeEspera;
    }

    public List<PeriodoBeans> getPeriodoBeanses() {
        return periodoBeanses;
    }

    public void setPeriodoBeanses(List<PeriodoBeans> periodoBeanses) {
        this.periodoBeanses = periodoBeanses;
    }

    public List<InscricaoBeans> getInscricoes() {
        return inscricoes;
    }

    public void setInscricoes(List<InscricaoBeans> inscricoes) {
        this.inscricoes = inscricoes;
    }

    public List<UsuarioBeans> getAdministradores() {
        return administradores;
    }

    public void setAdministradores(List<UsuarioBeans> administradores) {
        this.administradores = administradores;
    }

    public List<UsuarioBeans> getOrganizadores() {
        return organizadores;
    }

    public void setOrganizadores(List<UsuarioBeans> organizadores) {
        this.organizadores = organizadores;
    }

    public String getRecursosSolicitados() {
        return recursosSolicitados;
    }

    public void setRecursosSolicitados(String recursosSolicitados) {
        this.recursosSolicitados = recursosSolicitados;
    }
        
    
    

    @Override
    public Beans toBeans(Object o) {
        if(o != null){
            if(o instanceof Atividade){
                Atividade a = (Atividade) o;
                this.setCodAtividade(a.getCodAtividade());
                this.setNome(a.getNome());
                this.setDescricao(a.getDescricao());
                this.setLimiteVagas(a.getLimiteVagas());
                this.setNivel(a.getNivel());
                this.setVagasInternas(a.getVagasInternas());
                this.setVagasPublicas(a.getVagasPublicas());
                this.setTipoPagamento(a.getTipoPagamento());
                this.setCategoria(a.getCategoria());
                UsuarioBeans ub = null;
                if(a.getMinistrante()!=null){
                   ub = (UsuarioBeans) (new UsuarioBeans().toBeans(a.getMinistrante()));
                }
                this.setMinistrante(ub);
                List<InscricaoBeans> inscricoes = Collections.synchronizedList(new ArrayList<InscricaoBeans>());
                List<PeriodoBeans> periodos = Collections.synchronizedList(new ArrayList<PeriodoBeans>());
                List<ReservaBemBeans> bensReservados = Collections.synchronizedList(new ArrayList<ReservaBemBeans>());
                List<ReservaLocalBeans> locaisReservados = Collections.synchronizedList(new ArrayList<ReservaLocalBeans>());
                List<EsperaBeans> listaDeEsperaBeans = Collections.synchronizedList(new ArrayList<EsperaBeans>());
                List<UsuarioBeans> administradores = Collections.synchronizedList(new ArrayList<UsuarioBeans>());
                List<UsuarioBeans> organizadores = Collections.synchronizedList(new ArrayList<UsuarioBeans>());
                UsuarioBeans ubs = null;
                if(a.getAdministradores()!= null){
                    for(int i=0;i<a.getAdministradores().size();i++){
                        ubs = (UsuarioBeans) (new UsuarioBeans().toBeans(a.getAdministradores().get(i)));
                        administradores.add(ubs);
                    }
                }
                this.setAdministradores(administradores);
                if(a.getOrganizadores()!= null){
                    for(int i=0;i<a.getOrganizadores().size();i++){
                        ubs = (UsuarioBeans) (new UsuarioBeans().toBeans(a.getOrganizadores().get(i)));
                        organizadores.add(ubs);
                    }
                }
                this.setOrganizadores(organizadores);
                InscricaoBeans inscricaoBeans = null;
                if(a.getInscricaoAtividades() != null){
                    for(int i=0;i<a.getInscricaoAtividades().size();i++){
                        inscricaoBeans = (InscricaoBeans) (new InscricaoBeans().toBeans(a.getInscricaoAtividades().get(i)));
                        inscricoes.add(inscricaoBeans);
                    }
                }
                this.setInscricoes(inscricoes);
                PeriodoBeans periodoBeans = null;
                if(a.getPeriodos() != null){
                    for(int i=0;i<a.getPeriodos().size();i++){
                        periodoBeans = (PeriodoBeans) (new PeriodoBeans().toBeans(a.getPeriodos().get(i)));
                        periodos.add(periodoBeans);
                    }
                }
                this.setPeriodoBeanses(periodos);
                ReservaLocalBeans reservaLocalBeans = null;
                ReservaBemBeans reservaBemBeans = null;
                if(a.getBensReservados() != null){
                    for(int i=0;i<a.getBensReservados().size();i++){
                        reservaBemBeans = (ReservaBemBeans) (new ReservaBemBeans().toBeans(a.getBensReservados().get(i)));
                        bensReservados.add(reservaBemBeans);
                    }
                }
                this.setBensReservados(bensReservados);
                this.setRecursosSolicitados(a.getRecursosSolicitados());
                EsperaBeans esperaBeans = null;
                if(a.getListaDeEspera() != null){
                    for(int i=0;i<a.getListaDeEspera().size();i++){
                        esperaBeans = (EsperaBeans) (new EsperaBeans().toBeans(a.getListaDeEspera().get(i)));
                        listaDeEsperaBeans.add(esperaBeans);
                    }
                }
                this.setListaDeEspera(listaDeEsperaBeans);
                if(a.getLocaisReservados() != null){
                    for(int i=0;i<a.getLocaisReservados().size();i++){
                        reservaLocalBeans = (ReservaLocalBeans) (new ReservaLocalBeans().toBeans(a.getLocaisReservados().get(i)));
                        locaisReservados.add(reservaLocalBeans);
                    }
                }
                this.setLocaisReservados(locaisReservados);
                return this;
            }else{
                throw new IllegalArgumentException("Isso não é uma Atividade!");
            }
        }else{
            throw new NullPointerException("Atividade não pode ser nula!");
        }
    }

    @Override
    public Object toBusiness(){
        Atividade a = new Atividade();
        if(this.getCodAtividade()>0){
            a.setCodAtividade(this.getCodAtividade());
        }
        a.setNome(this.getNome());
        a.setDescricao(this.getDescricao());
        a.setLimiteVagas(this.getLimiteVagas());
        a.setNivel(this.getNivel());
        a.setVagasInternas(this.getVagasInternas());
        a.setVagasPublicas(this.getVagasPublicas());
        a.setTipoPagamento(this.getTipoPagamento());
        a.setCategoria(this.getCategoria());
        if(this.getMinistrante() != null){
            Usuario u = (Usuario) this.getMinistrante().toBusiness();
            a.setMinistrante(u);
        }
        List<Inscricao> inscricoes = Collections.synchronizedList(new ArrayList<Inscricao>());
        List<Periodo> periodos = Collections.synchronizedList(new ArrayList<Periodo>());
        List<ReservaBem> bensReservados = Collections.synchronizedList(new ArrayList<ReservaBem>());
        List<ReservaLocal> locaisReservados = Collections.synchronizedList(new ArrayList<ReservaLocal>());
        List<Espera> listaDeEspera = Collections.synchronizedList(new ArrayList<Espera>());
        List<Usuario> administradores = Collections.synchronizedList(new ArrayList<Usuario>());
        List<Usuario> organizadores = Collections.synchronizedList(new ArrayList<Usuario>());
        if(this.getAdministradores()!=null){
            for(int i=0;i<this.getAdministradores().size();i++){
                administradores.add((Usuario) this.getAdministradores().get(i).toBusiness());
            }
        }
        a.setAdministradores(administradores);
        if(this.getOrganizadores() != null){
            for(int i=0;i<this.getOrganizadores().size();i++){
                organizadores.add((Usuario) this.getOrganizadores().get(i).toBusiness());
            }
        }
        a.setOrganizadores(organizadores);
        if(this.getInscricoes()!= null){
            for(int i=0;i<this.getInscricoes().size();i++){
                inscricoes.add((Inscricao) this.getInscricoes().get(i).toBusiness());
            }
        }
        a.setInscricaoAtividades(inscricoes);
        if(this.getPeriodoBeanses() != null){
            for(int i=0;i<this.getPeriodoBeanses().size();i++){
                periodos.add((Periodo) this.getPeriodoBeanses().get(i).toBusiness());
            }
        }
        a.setPeriodos(periodos);
        if(this.getListaDeEspera() != null){
            for(int i=0;i<this.getListaDeEspera().size();i++){
                listaDeEspera.add((Espera) this.getListaDeEspera().get(i).toBusiness());
            }
        }
        a.setListaDeEspera(listaDeEspera);
        if(this.getBensReservados()!=null){
            for(int i=0;i<this.getBensReservados().size();i++){
                bensReservados.add((ReservaBem) this.getBensReservados().get(i).toBusiness());
            }
        }
        if(this.getLocaisReservados() != null){
            for(int i=0;i<this.getLocaisReservados().size();i++){
                locaisReservados.add((ReservaLocal) this.getLocaisReservados().get(i).toBusiness());
            }
        }
        if(this.getRecursosSolicitados() != null){
            a.setRecursosSolicitados(this.getRecursosSolicitados());
        }
        a.setLocaisReservados(locaisReservados);
        a.setBensReservados(bensReservados);
        return a;
    }
	   
}
