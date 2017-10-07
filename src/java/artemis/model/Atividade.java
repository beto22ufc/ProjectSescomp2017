/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.model;

import artemis.DAO.InscricaoDAOImpl;
import artemis.DAO.InstituicaoDAOImpl;
import artemis.DAO.PeriodoDAOImpl;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import javax.persistence.*;

/**
 *
 * @author Wallison
 */
@Entity
@Table(name="atividade")
public class Atividade implements Inscrevivel{
    @Id
    @Column(name="codAtividade")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long codAtividade;
    private String nome;
    private String descricao;
    @ManyToMany(targetEntity = Periodo.class, cascade = CascadeType.ALL)
    @JoinTable(name="periodos_atividade", joinColumns = {@JoinColumn(name = "atividade", referencedColumnName = "codAtividade")},
            inverseJoinColumns = {@JoinColumn(name = "periodo", referencedColumnName = "codPeriodo")})
    private List<Periodo> periodos;
    @ManyToOne
    @JoinColumn(name = "ministrante", referencedColumnName = "codUsuario")
    private Usuario ministrante;
    private String categoria;
    private int vagasInternas;
    private int vagasPublicas;
    private int limiteVagas;
    private int nivel;
    private int tipoPagamento;
    @ManyToMany(targetEntity = ReservaLocal.class)
    @JoinTable(name="locais_reservados", joinColumns = {@JoinColumn(name="atividade", referencedColumnName = "codAtividade")},
            inverseJoinColumns = {@JoinColumn(name = "reserva", referencedColumnName = "codReserva")})
    private List<ReservaLocal> locaisReservados;
    @ManyToMany(targetEntity = ReservaBem.class)
    @JoinTable(name="bens_reservados", joinColumns = {@JoinColumn(name="atividade", referencedColumnName = "codAtividade")},
            inverseJoinColumns = {@JoinColumn(name = "reserva", referencedColumnName = "codReserva")})
    private List<ReservaBem> bensReservados;
    @ManyToMany(targetEntity = Espera.class)
    @JoinTable(name="lista_de_espera", joinColumns = {@JoinColumn(name="atividade", referencedColumnName = "codAtividade")},
            inverseJoinColumns = {@JoinColumn(name="espera", referencedColumnName = "codEspera")})
    private List<Espera> listaDeEspera;
    @ManyToMany(targetEntity = Inscricao.class, cascade = CascadeType.ALL)
    @JoinTable(name="inscricoes_atividade", joinColumns = {@JoinColumn(name="atividade", referencedColumnName = "codAtividade")},
            inverseJoinColumns = {@JoinColumn(name="inscricao", referencedColumnName = "codInscricao")})
    private List<Inscricao> inscricaoAtividades;
    @ManyToMany(targetEntity = Usuario.class)
    @JoinTable(name="organizadores_atividade", joinColumns = {@JoinColumn(name="atividade", referencedColumnName = "codAtividade")},
            inverseJoinColumns = {@JoinColumn(name="organizador", referencedColumnName = "codUsuario")})
    private List<Usuario> organizadores;
    @ManyToMany(targetEntity = Usuario.class)
    @JoinTable(name="administradores_atividade", joinColumns = {@JoinColumn(name="atividade", referencedColumnName = "codAtividade")},
            inverseJoinColumns = {@JoinColumn(name="administrador", referencedColumnName = "codUsuario")})
    private List<Usuario> administradores;
    private String recursosSolicitados;
    private boolean temCertificado;
    
    public Atividade(){
    
    }
    public Atividade(long codAtividade, String nome, String descricao, List<Periodo> periodos, Usuario ministrante, String categoria, int vagasInternas, int vagasPublicas, int limiteVagas, int nivel, List<ReservaLocal> locaisReservados, List<ReservaBem> bensReservados, List<Inscricao> inscricaoAtividades, List<Espera> listaDeEspera, int tipoPagamento){
        setCodAtividade(codAtividade);
        setNome(nome);
        setDescricao(descricao);
        setPeriodos(periodos);
        setMinistrante(ministrante);
        setVagasInternas(vagasInternas);
        setVagasPublicas(vagasPublicas);
        setCategoria(categoria);
        setBensReservados(bensReservados);
        setNivel(nivel);
        setLimiteVagas(limiteVagas);
        setLocaisReservados(locaisReservados);
        setInscricaoAtividades(inscricaoAtividades);
        setListaDeEspera(listaDeEspera);
        setTipoPagamento(tipoPagamento);
    }
    public Atividade(String nome, String descricao, List<Periodo> periodos, Usuario ministrante, String categoria, int vagasInternas, int vagasPublicas, int limiteVagas, int nivel, List<ReservaLocal> locaisReservados, List<ReservaBem> bensReservados, List<Inscricao> inscricaoAtividades, List<Espera> listaDeEspera, int tipoPagamento){
        setNome(nome);
        setDescricao(descricao);
        setPeriodos(periodos);
        setMinistrante(ministrante);
        setVagasInternas(vagasInternas);
        setVagasPublicas(vagasPublicas);
        setCategoria(categoria);
        setBensReservados(bensReservados);
        setNivel(nivel);
        setLimiteVagas(limiteVagas);
        setLocaisReservados(locaisReservados);
        setInscricaoAtividades(inscricaoAtividades);
        setListaDeEspera(listaDeEspera);
        setTipoPagamento(tipoPagamento);
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
        if(nome != null && !nome.isEmpty())
            this.nome = nome;
        else
            throw new NullPointerException("Nome de atividade não pode ser vazio!");
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        if(descricao != null && !descricao.isEmpty())
            this.descricao = descricao;
        else
            throw new NullPointerException("Descrição de atividade não pode ser vazia!");
    }

    public List<Periodo> getPeriodos() {
        return periodos;
    }

    public void setPeriodos(List<Periodo> periodos) {
        if(periodos != null && periodos.size()>0)
            this.periodos = periodos;
        else
            throw new NullPointerException("Lista de períodos não pode ser vazia!");
    }   

    public Usuario getMinistrante() {
        return ministrante;
    }

    public void setMinistrante(Usuario ministrante) {
        if(ministrante != null)
            this.ministrante = ministrante;
        else
            throw new NullPointerException("Deve ser informado um ministrante!");
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        if(categoria != null && !categoria.isEmpty())
            this.categoria = categoria;
        else
            throw new NullPointerException("Categoria de atividade não pode ser vazia!");
    }

    public int getVagasInternas() {
        return vagasInternas;
    }

    public void setVagasInternas(int vagasInternas) {
        if(vagasInternas>=0)
            this.vagasInternas = vagasInternas;
        else
            throw new IllegalArgumentException("Vagas internas devem ser maior igual a zero!");
    }

    public int getVagasPublicas() {
        return vagasPublicas;
    }

    public void setVagasPublicas(int vagasPublicas) {
        if(vagasPublicas>=0)
            this.vagasPublicas = vagasPublicas;
        else
            throw new IllegalArgumentException("Vagas públicas devem ser maior igual a zero!");
    }

    public int getLimiteVagas() {
        return limiteVagas;
    }

    public void setLimiteVagas(int limiteVagas) {
        if(limiteVagas>0)
            this.limiteVagas = limiteVagas;
        else
            throw new IllegalArgumentException("Quantidade de vagas deve ser maior que zero!");
    }

    public int getNivel() {
        return nivel;
    }

    public void setNivel(int nivel) {
        if(nivel>=0 && nivel<=3)
            this.nivel = nivel;
        else
            throw new IllegalArgumentException("Nível deve ser maior igual a zero e menor igual a três!");
    }

    public int getTipoPagamento() {
        return tipoPagamento;
    }

    public void setTipoPagamento(int tipoPagamento) {
        if(tipoPagamento>=0)
            this.tipoPagamento = tipoPagamento;
        else
            throw new IllegalArgumentException("Tipo pagamento dever ser maior que zero!");
    }

    public List<ReservaLocal> getLocaisReservados() {
        return locaisReservados;
    }

    public void setLocaisReservados(List<ReservaLocal> locaisReservados) {
        if(locaisReservados != null)
            this.locaisReservados = locaisReservados;
        else
            throw new NullPointerException("Lista de locais reservados não pode ser vazia!");
    }

    public List<ReservaBem> getBensReservados() {
        return bensReservados;
    }

    public void setBensReservados(List<ReservaBem> bensReservados) {
        if(bensReservados != null)
            this.bensReservados = bensReservados;
        else
            throw new NullPointerException("Lista de bens reservados não pode ser vazia!");
    }

    public List<Espera> getListaDeEspera() {
        return listaDeEspera;
    }

    public void setListaDeEspera(List<Espera> listaDeEspera) {
        if(listaDeEspera != null)
            this.listaDeEspera = listaDeEspera;
        else
            throw new NullPointerException("Lista de espera não pode ser vazia!");
    }

    public List<Inscricao> getInscricaoAtividades() {
        return inscricaoAtividades;
    }

    public void setInscricaoAtividades(List<Inscricao> inscricaoAtividades) {
        if(inscricaoAtividades != null)
            this.inscricaoAtividades = inscricaoAtividades;
        else
            throw new NullPointerException("Lisa de inscrições não pode ser vazia!");
    }

    public List<Usuario> getOrganizadores() {
        return organizadores;
    }

    public void setOrganizadores(List<Usuario> organizadores) {
        if(organizadores != null)
            this.organizadores = organizadores;
        else
            throw new NullPointerException("Lista de organizadores não pode ser nula!");
    }

    public List<Usuario> getAdministradores() {
        return administradores;
    }

    public void setAdministradores(List<Usuario> administradores) {
        if(administradores != null)
            this.administradores = administradores;
        else
            throw new NullPointerException("Lista de administradores não pode ser nula!");
    } 

    public String getRecursosSolicitados() {
        return recursosSolicitados;
    }

    public void setRecursosSolicitados(String recursosSolicitados) {
        if(recursosSolicitados != null)
            this.recursosSolicitados = recursosSolicitados;
        else
            throw new NullPointerException("Recursos solicitados não pode nulo!");
    }

    public boolean isTemCertificado() {
        return temCertificado;
    }

    public void setTemCertificado(boolean temCertificado) {
        this.temCertificado = temCertificado;
    }
    
    
    
    public boolean colisaoPeriodos(){
        for(int i=0;i<this.getPeriodos().size();i++){
            Periodo p = this.getPeriodos().get(i);
            for(int j=i+1;j<this.getPeriodos().size();j++){
                Periodo p2 = this.getPeriodos().get(j);
                if(p.detectaColisao(p2)){
                    return true;
                }
            }
        }
        return false;
    }
    
    public void excluiReserva(Reserva reserva){
    
    }
    
    public void mudaPeriodo(Periodo novo, Periodo antigo){
        
    }
    
    public void novoPeriodo(LocalDateTime inicio, LocalDateTime termino, ZoneId zoneId){
    
    }
    
    public void reservaBem(Bem bem){
    
    }
    
    public void reservaLocal(Local local){
    
    }
    
    public void removeInscricao(Usuario usuario){
    
    }
    
    public void removePeriodo(Periodo periodo) throws IllegalAccessException{
        if(this.getPeriodos().size()>1){
            this.getPeriodos().remove(periodo);
            Evento evento = new Evento();
            evento.atualizaAtividade(this);
            PeriodoDAOImpl pdao = new PeriodoDAOImpl();
            pdao.removerPeriodo(periodo);
        }else{
            throw new IllegalArgumentException("Atividade contém só um período, portanto este período não pode ser removido!");
        }
    }
    
    public Inscricao criaInscricao(Inscricao inscricao) throws IllegalAccessException{
        if(this.getInscricaoAtividades() != null && !this.getInscricaoAtividades().contains(inscricao)){
            this.getInscricaoAtividades().add(inscricao);
            Evento evento = new Evento();
            evento.atualizaAtividade(this);
        }else{
            throw new EntityExistsException("Inscrição já existe!");
        }
        return inscricao;
    }
    
    public void removeInscricao(Inscricao inscricao, Usuario usuario) throws IllegalAccessException{
        InscricaoDAOImpl idao = new InscricaoDAOImpl();
        if(inscricao.getParticipante().equals(usuario)){
            if(this.getInscricaoAtividades().contains(inscricao)){
                this.getInscricaoAtividades().remove(inscricao);
                Evento evento = new Evento();
                evento.atualizaAtividade(this);
                idao.removerInscricao(inscricao);
            }else{
                throw new IllegalArgumentException("Essa inscrição não exite!");
            }
        }else{
            throw new IllegalArgumentException("Essa inscrição não é sua!");
        }
    }
    
    public int inscritosInternos(){
        InstituicaoDAOImpl idao = new InstituicaoDAOImpl();
        List<Instituicao> instituicoes = idao.listaInstituicoes();
        int count = 0;
        Instituicao ins = null;
        for(Instituicao instituicao : instituicoes){
            if(instituicao.getAtividades() !=null && instituicao.getAtividades().contains(this)){
                ins = instituicao;
                break;
            }
        }
        for(int i=0;i<this.getInscricaoAtividades().size();i++){
            Inscricao inscricao = this.getInscricaoAtividades().get(i);
            if(ins != null && ins.getAssociados() !=null && ins.getAssociados().contains(inscricao.getParticipante())){
                count++;
            }
        }
        return count;
    }
    
    public int inscritosExternos(){
        InstituicaoDAOImpl idao = new InstituicaoDAOImpl();
        List<Instituicao> instituicoes = idao.listaInstituicoes();
        int count = 0;
        Instituicao ins = null;
        for(Instituicao instituicao : instituicoes){
            if(instituicao.getAtividades() !=null && instituicao.getAtividades().contains(this)){
                ins = instituicao;
                break;
            }
        }
        for(Inscricao inscricao : this.getInscricaoAtividades()){
            if(ins !=null && ins.getAssociados() !=null && !ins.getAssociados().contains(inscricao.getParticipante())){
                count++;
            }
        }
        return count;
    }
    
    public Periodo getMenorPeriodo(){
        List<Periodo> periodos = this.getPeriodos();
        Periodo periodo = periodos.get(0);
        for(int i=1;i<periodos.size();i++){
            Periodo p = periodos.get(i);
            if(periodo.getInicio().isBefore(p.getInicio()) || periodo.getInicio().equals(p.getInicio())){
            }else{
                periodo = p;
            }
        }
        return periodo;
    }
    
    public Periodo getMaiorPeriodo(){
        List<Periodo> periodos = this.getPeriodos();
        Periodo periodo = periodos.get(0);
        for(int i=1;i<periodos.size();i++){
            Periodo p = periodos.get(i);
            if(periodo.getInicio().isAfter(p.getInicio()) || periodo.getInicio().equals(p.getInicio())){
            }else{
                periodo = p;
            }
        }
        return periodo;
    }
    
    public List<List> getConflitosInscricoesAtualizacao(){
        Inscricao i = new Inscricao();
        List<List> choques = Collections.synchronizedList(new ArrayList<List>());
        List<Inscricao> inscricoesAtividade = Collections.synchronizedList(new ArrayList<Inscricao>());
        List<Inscricao> inscricoesEvento = Collections.synchronizedList(new ArrayList<Inscricao>());
        List<List> conflitos = i.verificaChoque(this);
        List<Atividade> atividades = conflitos.get(0);
        List<Evento> eventos = conflitos.get(1);
        for(Atividade atividade : atividades){
            for(Inscricao inscricao : atividade.getInscricaoAtividades()){
                for(Inscricao ins : this.getInscricaoAtividades()){
                    if(inscricao.getParticipante().equals(ins.getParticipante())){
                        inscricoesAtividade.add(ins);
                        break;
                    }
                }
            }
        }
        for(Evento evento : eventos){
            for(Inscricao inscricao : evento.getInscricoes()){
                for(Inscricao ins : this.getInscricaoAtividades()){
                    if(inscricao.getParticipante().equals(ins.getParticipante())){
                        inscricoesEvento.add(ins);
                        break;
                    }
                }
            }
        }
        choques.add(inscricoesAtividade);
        choques.add(inscricoesEvento);
        return choques;
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 71 * hash + (int) (this.codAtividade ^ (this.codAtividade >>> 32));
        return hash;
    }
    
    @Override
    public boolean equals(Object o){
        return (this.getCodAtividade() == ((Atividade) o).getCodAtividade());
    }
}
