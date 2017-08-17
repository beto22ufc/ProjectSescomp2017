/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.model;

import artemis.DAO.AtividadeDAOImpl;
import artemis.DAO.EventoDAOImpl;
import artemis.DAO.LocalizacaoDAOImpl;
import hibernate.HibernateUtil;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.List;
import javax.persistence.*;

/**
 *
 * @author Wallison
 */
@Entity
@Table(name="evento")
public class Evento implements Inscrevivel{
    @Id
    @Column(name="codEvento")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long codEvento;
    private String nome;
    private String descricao;
    private String categoria;
    @ManyToMany(targetEntity = Periodo.class, cascade = CascadeType.ALL)
    @JoinTable(name="periodos_evento", joinColumns = {@JoinColumn(name = "evento", referencedColumnName = "codEvento")},
            inverseJoinColumns = {@JoinColumn(name = "periodo", referencedColumnName = "codPeriodo")})
    private List<Periodo> periodos;
    @ManyToMany(targetEntity = InscricaoEvento.class, cascade = CascadeType.ALL)
    @JoinTable(name="inscricoes_evento", joinColumns = {@JoinColumn(name = "evento", referencedColumnName = "codEvento")},
            inverseJoinColumns = {@JoinColumn(name = "inscricao", referencedColumnName = "codInscricao")})
    private List<InscricaoEvento> inscricoes;
    @ManyToMany(targetEntity = Atividade.class, cascade = CascadeType.ALL)
    @JoinTable(name="atividades_evento", joinColumns = {@JoinColumn(name = "evento", referencedColumnName = "codEvento")},
            inverseJoinColumns = {@JoinColumn(name = "atividade", referencedColumnName = "codAtividade")})
    private List<Atividade> atividades;
    @ManyToMany(targetEntity = Usuario.class, cascade = CascadeType.ALL)
    @JoinTable(name="administradores_evento", joinColumns = {@JoinColumn(name = "evento", referencedColumnName = "codEvento")},
            inverseJoinColumns = {@JoinColumn(name = "administrador", referencedColumnName = "codUsuario")})
    private List<Usuario> administradores;
    @ManyToMany(targetEntity = Evento.class, cascade = CascadeType.ALL)
    @JoinTable(name="eventos_vinculados", joinColumns = {@JoinColumn(name = "evento", referencedColumnName = "codEvento")},
            inverseJoinColumns = {@JoinColumn(name = "vinculado", referencedColumnName = "codEvento")})
    private List<Evento> eventos;
    @ManyToOne
    @JoinColumn(name="localizacao", referencedColumnName = "codLocalizacao")
    private Localizacao localizacao;
    
    public Evento(){
    
    }
    public Evento(long codEvento, String nome, String descricao, List<Periodo> periodos){
        setCodEvento(codEvento);
        setNome(nome);
        setDescricao(descricao);
        setPeriodos(periodos);
    }
    public Evento(String nome, String descricao, List<Periodo> periodos){
        setNome(nome);
        setDescricao(descricao);
        setPeriodos(periodos);
    }

    public void desvinculaEvento(Evento evento){
    
    }
    
    public void desvinculaAtividade(Atividade atividade){
    
    }
    
    public void vinculaAtividade(Atividade atividade){
    
    }
    
    public void removeAtividade(Atividade atividade){
    
    }
    
    public void vinculaEvento(Evento evento){
    
    }
    
    public void removePeriodo(Periodo periodo){
    
    }
    
    public void atualizaEvento(Evento evento) throws IllegalAccessException{
        if(evento.colisaoPeriodos()) throw new IllegalArgumentException("Choque interno de periodos, os periodos do evento não podem ser conflitantes!");
        EventoDAOImpl edaoi = new EventoDAOImpl();
        edaoi.atualizarEvento(evento);
    }
    
    public Atividade novaAtividade(Atividade atividade) throws IllegalAccessException{
        if(atividade.colisaoPeriodos()) throw new IllegalArgumentException("Choque interno de periodos, os periodos da atividade não podem ser conflitantes!");
        AtividadeDAOImpl adaoi = new AtividadeDAOImpl();
        return adaoi.adicionarAtividade(atividade);
    }
    
    public void atualizaAtividade(Atividade atividade) throws IllegalAccessException{
        if(atividade.colisaoPeriodos()) throw new IllegalArgumentException("Choque interno de periodos, os periodos da atividade não podem ser conflitantes!");
        AtividadeDAOImpl adaoi = new AtividadeDAOImpl();
        adaoi.atualizarAtividade(atividade);
    }
    
    public void novoPeriodo(LocalDateTime inicio, LocalDateTime termino, ZoneId zoneId){
    
    }
    
    public Evento novoEvento(Evento evento) throws IllegalAccessException{
        if(evento.colisaoPeriodos()) throw new IllegalArgumentException("Choque interno de periodos, os periodos do evento não podem ser conflitantes!");
        EventoDAOImpl edaoi = new EventoDAOImpl();
        LocalizacaoDAOImpl ldaoi = new LocalizacaoDAOImpl();
        ldaoi.adicionarLocalizacao(evento.getLocalizacao());
        return edaoi.adicionarEvento(evento);
    }
    
    public void mudaPeriodo(Periodo novo, Periodo antigo){
    
    }
    
    public long getCodEvento() {
        return codEvento;
    }

    public void setCodEvento(long codEvento) {
        if(codEvento > 0)
            this.codEvento = codEvento;
        else
            throw new IllegalArgumentException("Código do inválido!");
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        if(nome == null)
            throw new NullPointerException("Nome de evento não pode ser vazio!");
        else if(nome.isEmpty())
            throw new NullPointerException("Nome de evento não pode ser vazio!");
        else        
            this.nome = nome;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        if(descricao == null)
            throw new NullPointerException("Inscrição nãi pode ser vazia!");
        else if(descricao.isEmpty())
            throw new NullPointerException("Inscrição nãi pode ser vazia!");
        else
            this.descricao = descricao;
    }

    public List<Periodo> getPeriodos() {
        return periodos;
    }

    public void setPeriodos(List<Periodo> periodos) {
        if(periodos != null)
            this.periodos = periodos;
        else 
            throw new NullPointerException("Lista de periodos inválida!");
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        if(categoria != null || !categoria.isEmpty())
            this.categoria = categoria;
        else
            throw new NullPointerException("Categoria não pode ser vazia!");
    }

    public List<InscricaoEvento> getInscricoes() {
        return inscricoes;
    }

    public void setInscricoes(List<InscricaoEvento> inscricoes) {
        if(inscricoes != null)
            this.inscricoes = inscricoes;
        else
            throw new NullPointerException("Lista de inscrições não pode ser vazia!");
    }

    public List<Atividade> getAtividades() {
        return atividades;
    }

    public void setAtividades(List<Atividade> atividades) {
        if(atividades != null)
            this.atividades = atividades;
        else
            throw new NullPointerException("Lista de atividades não pode ser vazia!");
    }

    public List<Usuario> getAdministradores() {
        return administradores;
    }

    public void setAdministradores(List<Usuario> administradores) {
        if(administradores != null)
            this.administradores = administradores;
        else
            throw new NullPointerException("Lista de administradores não pode ser vazia!");
    }

    public List<Evento> getEventos() {
        return eventos;
    }

    public void setEventos(List<Evento> eventos) {
        if(eventos != null)
            this.eventos = eventos;
        else
            throw new NullPointerException("Lista de eventos não pode ser nula!");
    }      

    public Localizacao getLocalizacao() {
        return localizacao;
    }

    public void setLocalizacao(Localizacao localizacao) {
        if(localizacao != null)
            this.localizacao = localizacao;
        else
            throw new NullPointerException("Localização não pode ser nula!");
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
