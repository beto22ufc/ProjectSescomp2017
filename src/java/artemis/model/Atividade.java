/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.model;

import java.time.LocalDateTime;
import java.time.ZoneId;
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
    @ManyToMany(targetEntity = ReservaLocal.class, cascade = CascadeType.ALL)
    @JoinTable(name="locais_reservados", joinColumns = {@JoinColumn(name="atividade", referencedColumnName = "codAtividade")},
            inverseJoinColumns = {@JoinColumn(name = "reserva", referencedColumnName = "codReserva")})
    private List<ReservaLocal> locaisReservados;
    @ManyToMany(targetEntity = ReservaBem.class, cascade = CascadeType.ALL)
    @JoinTable(name="bens_reservados", joinColumns = {@JoinColumn(name="atividade", referencedColumnName = "codAtividade")},
            inverseJoinColumns = {@JoinColumn(name = "reserva", referencedColumnName = "codReserva")})
    private List<ReservaBem> bensReservados;
    @ManyToMany(targetEntity = Espera.class, cascade = CascadeType.ALL)
    @JoinTable(name="lista_de_espera", joinColumns = {@JoinColumn(name="atividade", referencedColumnName = "codAtividade")},
            inverseJoinColumns = {@JoinColumn(name="espera", referencedColumnName = "codEspera")})
    private List<Espera> listaDeEspera;
    @ManyToMany(targetEntity = InscricaoAtividade.class, cascade = CascadeType.ALL)
    @JoinTable(name="inscricoes_atividade", joinColumns = {@JoinColumn(name="atividade", referencedColumnName = "codAtividade")},
            inverseJoinColumns = {@JoinColumn(name="inscricao", referencedColumnName = "codInscricao")})
    private List<InscricaoAtividade> inscricaoAtividades;
    @ManyToMany(targetEntity = Usuario.class, cascade = CascadeType.ALL)
    @JoinTable(name="organizadores_atividade", joinColumns = {@JoinColumn(name="atividade", referencedColumnName = "codAtividade")},
            inverseJoinColumns = {@JoinColumn(name="organizador", referencedColumnName = "codUsuario")})
    private List<Usuario> organizadores;
    @ManyToMany(targetEntity = Usuario.class, cascade = CascadeType.ALL)
    @JoinTable(name="administradores_atividade", joinColumns = {@JoinColumn(name="atividade", referencedColumnName = "codAtividade")},
            inverseJoinColumns = {@JoinColumn(name="administrador", referencedColumnName = "codUsuario")})
    private List<Usuario> administradores;
   
    
    public Atividade(){
    
    }
    public Atividade(long codAtividade, String nome, String descricao, List<Periodo> periodos, Usuario ministrante, String categoria, int vagasInternas, int vagasPublicas, int limiteVagas, int nivel, List<ReservaLocal> locaisReservados, List<ReservaBem> bensReservados, List<InscricaoAtividade> inscricaoAtividades, List<Espera> listaDeEspera, int tipoPagamento){
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
    public Atividade(String nome, String descricao, List<Periodo> periodos, Usuario ministrante, String categoria, int vagasInternas, int vagasPublicas, int limiteVagas, int nivel, List<ReservaLocal> locaisReservados, List<ReservaBem> bensReservados, List<InscricaoAtividade> inscricaoAtividades, List<Espera> listaDeEspera, int tipoPagamento){
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

    public List<InscricaoAtividade> getInscricaoAtividades() {
        return inscricaoAtividades;
    }

    public void setInscricaoAtividades(List<InscricaoAtividade> inscricaoAtividades) {
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
    
}
