/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.model;

import artemis.DAO.AtividadeDAOImpl;
import artemis.DAO.EventoDAOImpl;
import artemis.DAO.InscricaoDAOImpl;
import artemis.DAO.InstituicaoDAOImpl;
import artemis.DAO.UsuarioDAOImpl;
import artemis.beans.ContaUsuario;
import hibernate.HibernateUtil;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;
import java.util.Objects;
import java.util.regex.Pattern;
import javax.persistence.AttributeConverter;
import javax.persistence.Column;
import javax.persistence.Converter;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import org.apache.commons.mail.EmailException;



/**
 *
 * @author Wallison
 */
@Converter(autoApply = true)
@Entity
@Table(name="usuario")
public class Usuario implements AttributeConverter<LocalDate, Date>, Serializable, ContaUsuario{
    @Id
    @Column(name="codUsuario")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long codUsuario;
    @ManyToOne
    @JoinColumn(name="matricula", referencedColumnName = "codMatricula")
    private Matricula matricula;
    private String nome;
    private String ocupacao;
    private String formacao;
    private String lattes;
    @Column(unique = true)
    private String email;
    @ManyToOne
    @JoinColumn(name="cpf", referencedColumnName = "cpf", unique = true, updatable = true, insertable = true)
    private CPF cpf;
    private String senha;
    @Column(name="imagemPerfil")
    private File imagemPerfil;
    @Column(name="cadastro")
    private LocalDate cadastro;
    private int status;
    private String tipo;
    @Column(name="nascimento")
    private LocalDate nascimento;
    @ManyToOne
    @JoinColumn(name = "contas_sociais", referencedColumnName = "codContasSociais", nullable = true)
    private ContasSociais contasSociais;
    
    public Usuario(){
    
    }
    
    public Usuario(long codUsuario, Matricula matricula, String nome,String login, String email, String senha,CPF cpf, LocalDate nascimento, String formacao, String lattes, String ocupacao, String tipo, int status, LocalDate cadastro) throws Exception{
        setCodUsuario(codUsuario);
        setMatricula(matricula);
        setNome(nome);
        setEmail(email);
        setSenha(senha);
        setCpf(cpf);
        setNascimento(nascimento);
        setFormacao(formacao);
        setLattes(lattes);
        setOcupacao(ocupacao);
        setTipo(tipo);
        setStatus(status);
        setCadastro(cadastro);
    }
    public Usuario(Matricula matricula, String nome,String email, String senha,CPF cpf, LocalDate nascimento, String formacao, String lattes, String ocupacao, String tipo, int status, LocalDate cadastro) throws Exception{
        setMatricula(matricula);
        setNome(nome);
        setEmail(email);
        setSenha(senha);
        setCpf(cpf);
        setNascimento(nascimento);
        setFormacao(formacao);
        setLattes(lattes);
        setOcupacao(ocupacao);
        setTipo(tipo);
        setStatus(status);
        setCadastro(cadastro);
    }
    public Usuario(String nome,String email, String senha,CPF cpf, LocalDate nascimento, String formacao, String lattes, String ocupacao, String tipo, int status, LocalDate cadastro) throws Exception{
        setNome(nome);
        setEmail(email);
        setSenha(senha);
        setCpf(cpf);
        setNascimento(nascimento);
        setFormacao(formacao);
        setLattes(lattes);
        setOcupacao(ocupacao);
        setTipo(tipo);
        setStatus(status);
        setCadastro(cadastro);
    }
    public Usuario(String email, String senha){
        setEmail(email);
        setSenha(senha);
    }
    
    
    public void adicionarUsuario(Usuario usuario){
    
    }
    
    public void atualizaDados(){
        //Atualizar dados do usuário
    }
    
    public void desativaConta(){
        //Desativar conta do usuário
    }
    
    public long getCodUsuario() {
        return codUsuario;
    }

    public void setCodUsuario(long codUsuario){
        if(codUsuario>0)
            this.codUsuario = codUsuario;
        else
            throw new IllegalArgumentException("Código do usuário deve ser maior que zero!");
    }

    public Matricula getMatricula() {
        return matricula;
    }

    public void setMatricula(Matricula matricula) {
        this.matricula = matricula;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome){
        if(nome == null)
            throw new NullPointerException("Nome do usuário não pode ser vazio!");
        else if(nome.isEmpty())
            throw new NullPointerException("Nome do usuário não pode ser vazio!");
        else if(nome.length()<2)
            throw new IllegalArgumentException("Nome de usuário muito curto!");
        //else if(!Pattern.matches("/[a-zA-Z\\u00C0-\\u00FF ]+/i", nome))
          //  throw new IllegalArgumentException("Digite o seu nome corretamente!");
        else
            this.nome = nome;
    }

    public String getOcupacao() {
        return ocupacao;
    }

    public void setOcupacao(String ocupacao) {
        if(ocupacao == null)
            throw new NullPointerException("Ocupação não pode ser vazia!");
        else if(ocupacao.isEmpty())
            throw new NullPointerException("Ocupação não pode ser vazia!");
        else if(ocupacao.length()<6)
            throw new IllegalArgumentException("Ocupação muito curta!");
        else 
            this.ocupacao = ocupacao;
    }

    public String getFormacao() {
        return formacao;
    }

    public void setFormacao(String formacao) {
        if(formacao == null)
            throw new NullPointerException("Formação não pode ser vazia!");
        else if(formacao.isEmpty())
            throw new NullPointerException("Formação não pode ser vazia!");
        else if(formacao.length()<6)
            throw new IllegalArgumentException("Formação muito curta!");
        else 
            this.formacao = formacao;
    }

    public String getLattes() {
        return lattes;
    }

    public void setLattes(String lattes){
        if(lattes == null)
            throw new NullPointerException("Link de curriculum plataforma Lattes não pode ser vazio!");
        else if(lattes.isEmpty())
            throw new NullPointerException("Link de curriculum plataforma Lattes não pode ser vazio!");
        else
            this.lattes = lattes;
    }

    public String getEmail() {
        return email;
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

    public CPF getCpf() {
        return cpf;
    }

    public void setCpf(CPF cpf) {
        if(cpf == null)
            throw new NullPointerException("CPF não pode ser não nulo!");
        else
            this.cpf = cpf;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha){
        if(senha == null)
            throw new NullPointerException("Senha não informada!");
        else if(senha.isEmpty())
            throw new NullPointerException("Senha não informada!");
        else if(senha.length()<=7)
            throw new IllegalArgumentException("Senha deve no mínimo 8 caracteres!");
        this.senha = senha;
    }

    public LocalDate getCadastro() {
        return cadastro;
    }

    public void setCadastro(LocalDate cadastro) {
        if(cadastro == null)
            throw new NullPointerException("Cadastro não informado!");
        else
            this.cadastro = cadastro;
        
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        if(status<2 && status>-1)
            this.status = status;
        else 
           throw new IllegalArgumentException("Status do usuário incorreto!");
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        if(tipo == null)
            throw new NullPointerException("Tipo de usuário não informado!");
        else if(tipo.isEmpty())
            throw new NullPointerException("Tipo de usuário não informado!");
        else
            this.tipo = tipo;
    }

    public LocalDate getNascimento() {
        return nascimento;
    }

    public void setNascimento(LocalDate nascimento) {
        if(nascimento == null)
            throw new NullPointerException("Data de nascimento não informada!");
        else
            this.nascimento = nascimento;
    }

    @Override
    public Date convertToDatabaseColumn(LocalDate attribute) {
        return (attribute == null ? null : Date.valueOf(attribute));
    }

    @Override
    public LocalDate convertToEntityAttribute(Date dbData) {
        return (dbData == null ? null : dbData.toLocalDate());
    }

    public File getImagemPerfil() {
        return imagemPerfil;
    }

    public void setImagemPerfil(File imagemPerfil) {
        if(imagemPerfil != null)
            this.imagemPerfil = imagemPerfil;
        else
            throw new NullPointerException("Imagem do perfil não pode ser vazia!");
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
    
    @Override
    public boolean equals(Object o){
        return (this.getEmail().equalsIgnoreCase(((Usuario) o).getEmail()));
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 89 * hash + Objects.hashCode(this.email);
        return hash;
    }

    @Override
    public void atualizaInformacoesGerais() {
        UsuarioDAOImpl udaoi = new UsuarioDAOImpl();
        udaoi.setSessionFactory(HibernateUtil.getSessionFactory());
        Usuario usuario = udaoi.getUsuario(this.getCodUsuario());
        if(usuario.getCpf().getFormatedCpf().equals(this.getCpf().getFormatedCpf())){
            //udaoi.adicionaCPF(this.getCpf());
            udaoi.atualizarUsuario(this);
        }else{
            udaoi.adicionaCPF(this.getCpf());
            udaoi.atualizarUsuario(this);
        }
    }

    @Override
    public void atualizaInformacoesInstitucionais() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    public Usuario adicionaNivelUsuario(Usuario u, String nivel) throws IllegalAccessException{
        UsuarioDAOImpl udaoi = new UsuarioDAOImpl();
        if(u.getTipo() != null){
            if(!u.getTipo().contains(nivel)){
                u.setTipo(u.getTipo()+","+nivel);
            }
        }else{
            u.setTipo(nivel);
        }
        udaoi.atualizarUsuario(u);
        return u;
    }
    
    public Usuario removeNivelUsuario(Usuario u, String nivel) throws IllegalAccessException{
        UsuarioDAOImpl udaoi = new UsuarioDAOImpl();
        if(u.getTipo()!=null){
            if(u.getTipo().contains(nivel)){
                u.setTipo(u.getTipo().replace(","+nivel, ""));
                udaoi.atualizarUsuario(u);        
            }
        }
        return u;
    }
    
    public void removeUsuario(Usuario usuario) throws EmailException, IllegalAccessException{
        EventoDAOImpl edao = new EventoDAOImpl();
        AtividadeDAOImpl adao = new AtividadeDAOImpl();
        InscricaoDAOImpl idao = new InscricaoDAOImpl();
        InstituicaoDAOImpl idaoi = new InstituicaoDAOImpl();
        List<Evento> eventos = edao.listaEventos();
        List<Atividade> atividades = adao.listaAtividades();
        List<Inscricao> inscricoes = idao.listaInscricoes();
        List<Instituicao> instituicoes = idaoi.listaInstituicoes();
        Evento e = new Evento();
        for(Atividade atividade : atividades){
            atividade.getAdministradores().contains(usuario);
            atividade.getOrganizadores().contains(usuario);
            if(atividade.getAdministradores().size()==0){
                atividade.getOrganizadores().clear();
                e.removeAtividade(atividade);
            }
        }
        for(Evento evento : eventos){
            evento.getAdministradores().contains(usuario);
            evento.getOrganizadores().contains(usuario);
            if(evento.getAdministradores().size()==0){
                evento.getOrganizadores().clear();
                //Falta fazer o remove evento
            }
        }
    }
    
    public void removeInstituicao(Instituicao instituicao) throws IllegalAccessException{
        InstituicaoDAOImpl idao = new InstituicaoDAOImpl();
        if(instituicao.getAssociados().size() ==0 && instituicao.getEventos().size() == 0 && instituicao.getAtividades().size() ==0){
            for(Curso curso : instituicao.getCursos()){
                instituicao.removeCurso(curso);
            }
            idao.removerInstituicao(instituicao);
        }else{
            throw new IllegalArgumentException("Instituição não pode ser exluída, pois existe(m) associado(s), atividade(s) e/ou evento(s) associados a ela!");
        }
    }
    
    public void marcaPresencaInscricao(Inscricao inscricao) throws IllegalAccessException{
        InscricaoDAOImpl idao = new InscricaoDAOImpl();
        inscricao.setPresente(true);
        idao.atualizarInscricao(inscricao);
    }
    
    public void validaInscricao(Inscricao inscricao) throws IllegalAccessException{
        InscricaoDAOImpl idao = new InscricaoDAOImpl();
        inscricao.setValidada(true);
        idao.atualizarInscricao(inscricao);
    }
    
    public static byte[] serialize(Object obj) throws IOException {
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        ObjectOutputStream os = new ObjectOutputStream(out);
        os.writeObject(obj);
        return out.toByteArray();
}
    public static Object deserialize(byte[] data) throws IOException, ClassNotFoundException {
        ByteArrayInputStream in = new ByteArrayInputStream(data);
        ObjectInputStream is = new ObjectInputStream(in);
        return is.readObject();
    }
    
    public static byte[] stringToByte(String value){
        String[] byteValues = value.substring(1, value.length() - 1).split(",");
        byte[] bytes = new byte[byteValues.length];

        for (int i=0, len=bytes.length; i<len; i++) {
           bytes[i] = Byte.parseByte(byteValues[i].trim());     
        }
        return bytes;
    }
    
    public static String byteToString(byte[] bytes){
        return new String(bytes);
    }
}
