/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.model;

import artemis.DAO.AtividadeDAOImpl;
import artemis.DAO.EventoDAOImpl;
import artemis.DAO.ImagemDAOImpl;
import artemis.DAO.InscricaoDAOImpl;
import artemis.DAO.LocalizacaoDAOImpl;
import artemis.DAO.PeriodoDAOImpl;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.regex.Pattern;
import javax.persistence.*;
import org.apache.commons.mail.EmailException;
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

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
    @ManyToMany(targetEntity = Inscricao.class, cascade = CascadeType.ALL)
    @JoinTable(name="inscricoes_evento", joinColumns = {@JoinColumn(name = "evento", referencedColumnName = "codEvento")},
            inverseJoinColumns = {@JoinColumn(name = "inscricao", referencedColumnName = "codInscricao")})
    private List<Inscricao> inscricoes;
    @ManyToMany(targetEntity = Atividade.class)
    @JoinTable(name="atividades_evento", joinColumns = {@JoinColumn(name = "evento", referencedColumnName = "codEvento")},
            inverseJoinColumns = {@JoinColumn(name = "atividade", referencedColumnName = "codAtividade")})
    private List<Atividade> atividades;
    @ManyToMany(targetEntity = Usuario.class)
    @JoinTable(name="administradores_evento", joinColumns = {@JoinColumn(name = "evento", referencedColumnName = "codEvento")},
            inverseJoinColumns = {@JoinColumn(name = "administrador", referencedColumnName = "codUsuario")})
    private List<Usuario> administradores;
    @ManyToMany(targetEntity = Usuario.class)
    @JoinTable(name="organizadores_evento", joinColumns = {@JoinColumn(name = "evento", referencedColumnName = "codEvento")},
            inverseJoinColumns = {@JoinColumn(name = "organizador", referencedColumnName = "codUsuario")})
    private List<Usuario> organizadores;
    @ManyToMany(targetEntity = Evento.class)
    @JoinTable(name="eventos_vinculados", joinColumns = {@JoinColumn(name = "evento", referencedColumnName = "codEvento")},
            inverseJoinColumns = {@JoinColumn(name = "vinculado", referencedColumnName = "codEvento")})
    private List<Evento> eventos;
    @ManyToMany(targetEntity = Imagem.class, cascade = CascadeType.ALL)
    @JoinTable(name="slideshow_evento", joinColumns = {@JoinColumn(name = "evento", referencedColumnName = "codEvento")},
            inverseJoinColumns = {@JoinColumn(name = "imagem", referencedColumnName = "codImagem")})
    private List<Imagem> slideshow;
    @ManyToMany(targetEntity = Imagem.class, cascade = CascadeType.ALL)
    @JoinTable(name="galeria_evento", joinColumns = {@JoinColumn(name = "evento", referencedColumnName = "codEvento")},
            inverseJoinColumns = {@JoinColumn(name = "imagem", referencedColumnName = "codImagem")})
    private List<Imagem> galeria;
    private String email;
    @ManyToOne
    @JoinColumn(name="localizacao", referencedColumnName = "codLocalizacao")
    private Localizacao localizacao;
    @ManyToOne
    @JoinColumn(name="contas_sociais", referencedColumnName = "codContasSociais")
    private ContasSociais contasSociais;
    private String tema = "default";
    private boolean temCertificado = true;
    private boolean temInscricao = true;
    private float porcentagemMinimaGerarCertifciado;
    
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

    public List<Inscricao> getInscricoes() {
        return inscricoes;
    }

    public void setInscricoes(List<Inscricao> inscricoes) {
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

    public List<Imagem> getSlideshow() {
        return slideshow;
    }

    public void setSlideshow(List<Imagem> slideshow) {
        if(slideshow != null)
            this.slideshow = slideshow;
        else
            throw new NullPointerException("Slideshow não pode ser nulo!");
    }

    public List<Imagem> getGaleria() {
        return galeria;
    }

    public void setGaleria(List<Imagem> galeria) {
        if(galeria != null)
            this.galeria = galeria;
        else
            throw new NullPointerException("Galeria não pode ser nula!");
    }

    public String getEmail() {
        return email;
    }

    public ContasSociais getContasSociais() {
        return contasSociais;
    }

    public void setContasSociais(ContasSociais contasSociais) {
        if(contasSociais != null)
            this.contasSociais = contasSociais;
        else
            throw new NullPointerException("Contas sociais não pode ser nula!");
    }
    
    

    public void setEmail(String email) {
        Pattern pattern = Pattern.compile("^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\\\.[A-Z]{2,6}$",Pattern.CASE_INSENSITIVE);
        if(email == null)
            throw new NullPointerException("E-mail não pode ser vazio!");
        else if(email.isEmpty())
            throw new NullPointerException("E-mail não pode ser vazio!");
        else if(!EmailValidator.getInstance().validate(email))
            throw new IllegalArgumentException("E-mail inválido!");
        else    
            this.email = email;
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

    public String getTema() {
        return tema;
    }

    public void setTema(String tema) {
        if(tema != null && !tema.isEmpty())
            this.tema = tema;
        else
            throw new NullPointerException("Deve ser escolhido um tema!");
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
        if(porcentagemMinimaGerarCertifciado >= 0)
            this.porcentagemMinimaGerarCertifciado = porcentagemMinimaGerarCertifciado;
        else
            throw new NullPointerException("Por centeagem mínima para gerar o certificado deve ser maior ou igual a zero!");
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
    
    
    public void removeAtividade(Atividade atividade) throws EmailException, IllegalAccessException{
        Email email = new Email();
        InscricaoDAOImpl idao = new InscricaoDAOImpl();
        AtividadeDAOImpl adao = new AtividadeDAOImpl();
        for(int i=0;i<atividade.getInscricaoAtividades().size();i++){
            Inscricao inscricao = atividade.getInscricaoAtividades().get(i);
            email.setAssunto("Atividade cancelada!");
            email.setMessage("Pedimos desculpas, mas a atividade "+atividade.getNome()+" na qual o senhor estava inscrito foi cancelada, logo sua inscrição também.");
            email.setFromEmail(inscricao.getParticipante().getEmail());
            email.setNomeTo(inscricao.getParticipante().getNome());
            email.sendEmail();
            idao.removerInscricao(inscricao);
        }
        adao.removerAtividade(atividade);
    }
    
    public void removeEvento(Evento evento) throws EmailException, IllegalAccessException{
        EventoDAOImpl edao = new EventoDAOImpl();
        InscricaoDAOImpl idao = new InscricaoDAOImpl();
        Email email = new Email();
        for(Inscricao inscricao : evento.getInscricoes()){
            email.setAssunto("Evento cancelado!");
            email.setMessage("Pedimos desculpas, mas o evento "+evento.getNome()+" no qual o senhor estava inscrito foi cancelado, logo sua inscrição também.");
            email.setFromEmail(inscricao.getParticipante().getEmail());
            email.setNomeTo(inscricao.getParticipante().getNome());
            email.sendEmail();
            idao.removerInscricao(inscricao);
        }
        evento.getEventos().clear();
        edao.atualizarEvento(evento);
        for(Atividade atividade : evento.getAtividades()){
            evento.getAtividades().remove(atividade);
            removeAtividade(atividade);
        }
        edao.removerEvento(evento);
    }
    
    public void removeAtividade(Evento evento, Atividade atividade) throws EmailException, IllegalAccessException{
        AtividadeDAOImpl adao = new AtividadeDAOImpl();
        EventoDAOImpl edao = new EventoDAOImpl();
        if(evento!=null){
            for(int i=0;i<evento.getAtividades().size();i++){
                Atividade a = evento.getAtividades().get(i);
                if(a.getCodAtividade() == atividade.getCodAtividade()){
                    evento.getAtividades().remove(a);
                    break;
                }
            }
            edao.atualizarEvento(evento);
        }
        removeAtividade(atividade);
    }
        
    public void removePeriodo(Evento evento, Periodo periodo) throws EmailException{
        EventoDAOImpl edao = new EventoDAOImpl();
        PeriodoDAOImpl pdao = new PeriodoDAOImpl();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy hh:mm");
        Email email = new Email();
        for(int i=0;i<evento.getPeriodos().size();i++){
            Periodo p = evento.getPeriodos().get(i);
            if(p.getCodPeriodo() == periodo.getCodPeriodo()){
                evento.getPeriodos().remove(p);
                email.setAssunto("Atualização de horário!");
                email.setMessage("Houve uma alteração no horário do evento "+evento.getNome()+" no qual você está inscrito veja se não há choque com nenhum outro e se organize. Horário removido: Inicio: "+p.getInicio().format(formatter)+" termino: "+p.getTermino().format(formatter)+".");
                evento.notificaInscritos(email);
                break;
            }
        }
        edao.atualizarEvento(evento);
        pdao.removerPeriodo(periodo);
    }
    
    public void notificaInscritos(Email email) throws EmailException{
        for(int i=0;i<this.getInscricoes().size();i++){
            Inscricao inscricao = this.getInscricoes().get(i);
            Usuario participante = inscricao.getParticipante();
            email.setFromEmail(participante.getEmail());
            email.setNomeTo(participante.getNome());
            email.sendEmail();
        }
    }
    
    public void enviaEmailContato(String nome, String sobrenome, String menssagem, String telefone, String mail) throws EmailException{
        System.out.println(this.getEmail());
        Email email = new Email("Contato e-mail!", "De: "+nome+" "+sobrenome+"\nE-mail: "+mail+"\nTelefone: "+telefone+"\nMenssagem: "+menssagem, nome+" "+sobrenome, this.getEmail());
        email.sendEmail();
    }
    
    public void atualizaEvento(Evento evento) throws IllegalAccessException{
        if(evento.colisaoPeriodos()) throw new IllegalArgumentException("Choque interno de periodos, os periodos do evento não podem ser conflitantes!");
        List<List> choques = evento.getConflitosInscricoesAtualizacao();
        System.out.println("Evento: "+choques.get(0)+" "+choques.get(1));
        int chocados = choques.get(0).size();
        int chocadas = choques.get(1).size();
        if(chocados == 0 && chocadas ==1)throw new IllegalArgumentException("Não é possível realizar a atualização, pois isso irá gerar choques em inscrições de participantes!(Resolva esse problema)");
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
        List<List> choques = atividade.getConflitosInscricoesAtualizacao();
        int chocados = choques.get(0).size();
        int chocadas = choques.get(1).size();
        System.out.println("Atividade: "+choques.get(0)+" "+choques.get(1));
        if(chocados == 0 && chocadas ==1)throw new IllegalArgumentException("Não é possível realizar a atualização, pois isso irá gerar choques em inscrições de participantes!(Resolva esse problema)");
        AtividadeDAOImpl adaoi = new AtividadeDAOImpl();
        adaoi.atualizarAtividade(atividade);
    }
    
    public Evento novoEvento(Evento evento) throws IllegalAccessException{
        if(evento.colisaoPeriodos()) throw new IllegalArgumentException("Choque interno de periodos, os periodos do evento não podem ser conflitantes!");
        EventoDAOImpl edaoi = new EventoDAOImpl();
        LocalizacaoDAOImpl ldaoi = new LocalizacaoDAOImpl();
        ldaoi.adicionarLocalizacao(evento.getLocalizacao());
        return edaoi.adicionarEvento(evento);
    }    
    
    public Periodo getMenorPeriodo(){
        List<Periodo> periodos = this.getPeriodos();
        Periodo periodo = periodos.get(0);
        for(int i=1;i<periodos.size();i++){
            Periodo p = periodos.get(i);
            if(periodo.getInicio().isBefore(p.getInicio()) || periodo.getInicio().equals(p.getInicio())){
                continue;
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
    
    public void removePeriodo(Periodo periodo) throws IllegalAccessException{
        if(this.getPeriodos().size()>1){
            this.getPeriodos().remove(periodo);
            this.atualizaEvento(this);
            PeriodoDAOImpl pdao = new PeriodoDAOImpl();
            pdao.removerPeriodo(periodo);
        }else{
            throw new IllegalArgumentException("Evento contém só um período, portanto este período não pode ser removido!");
        }
    }
    
    public Inscricao criaInscricao(Inscricao inscricao) throws IllegalAccessException{
        if(this.isTemInscricao()){
            if(this.getInscricoes() != null && !this.getInscricoes().contains(inscricao)){
                this.getInscricoes().add(inscricao);
                this.atualizaEvento(this);
            }else{
                throw new EntityExistsException("Inscrição já existe!");
            }
            return inscricao;
        }else{
            throw new IllegalAccessException("Esse evento não tem inscrição!");
        }
    }
    
    public void removeInscricao(Inscricao inscricao, Usuario usuario) throws IllegalAccessException{
        InscricaoDAOImpl idao = new InscricaoDAOImpl();
        if(inscricao.getParticipante().equals(usuario)){
            if(this.getInscricoes().contains(inscricao)){
                this.getInscricoes().remove(inscricao);
                this.atualizaEvento(this);
                idao.removerInscricao(inscricao);
            }else{
                throw new IllegalArgumentException("Essa inscrição não exite!");
            }
        }else{
            throw new IllegalArgumentException("Essa inscrição não é sua!");
        }
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
                for(Inscricao ins : this.getInscricoes()){
                    if(inscricao.getParticipante().equals(ins.getParticipante())){
                        inscricoesAtividade.add(ins);
                        break;
                    }
                }
            }
        }
        for(Evento evento : eventos){
            for(Inscricao inscricao : evento.getInscricoes()){
                for(Inscricao ins : this.getInscricoes()){
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
    
    public float getParticipacao(Usuario participante){
        int total = this.getAtividades().size()+this.getEventos().size(), count =0;
        for(Evento evento : this.getEventos()){
            for(Inscricao inscricao : evento.getInscricoes()){
                if(inscricao.getParticipante().equals(participante)){
                    if(inscricao.isPresente()){
                        count++;
                    }
                    break;
                }
            }
        }
        for(Atividade atividade : this.getAtividades()){
            for(Inscricao inscricao : atividade.getInscricaoAtividades()){
                if(inscricao.getParticipante().equals(participante)){
                    total++;
                    if(inscricao.isPresente()){
                        count++;
                    }
                    break;
                }
            }
        }
        return (float)((float) count/total);
    }
    
    public void removeImagem(Imagem imagem){
        ImagemDAOImpl idao = new ImagemDAOImpl();
        idao.removerImagem(imagem);
    }
    
    public void removeImagemGaleria(Imagem imagem) throws IllegalAccessException{
        for(int i=0;i<this.getGaleria().size();i++){
            Imagem image = this.getGaleria().get(i);
            if(image.getCodImagem() == imagem.getCodImagem()){
                this.getGaleria().remove(i);
                this.atualizaEvento(this);
                removeImagem(imagem);
                break;
            }
        }
    }
    
    public void removeImagemSlideshow(Imagem imagem) throws IllegalAccessException{
        for(int i=0;i<this.getSlideshow().size();i++){
            Imagem image = this.getSlideshow().get(i);
            if(image.getCodImagem() == imagem.getCodImagem()){
                this.getSlideshow().remove(i);
                this.atualizaEvento(this);
                removeImagem(imagem);
                break;
            }
        }
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 53 * hash + (int) (this.codEvento ^ (this.codEvento >>> 32));
        return hash;
    }
    
    @Override
    public boolean equals(Object o){
        return (this.getCodEvento()==((Evento) o).getCodEvento());
    }
}
