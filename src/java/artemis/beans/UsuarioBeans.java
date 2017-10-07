/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.beans;

import artemis.model.CPF;
import artemis.model.ContasSociais;
import artemis.model.Matricula;
import artemis.model.Usuario;
import java.io.File;
import java.io.Serializable;
import java.time.LocalDate;
import java.util.Objects;

/**
 *
 * @author Wallison
 */
public class UsuarioBeans implements Beans, Serializable{
    private long codUsuario;
    private MatriculaBeans matricula;
    private String nome;
    private String ocupacao;
    private String formacao;
    private String lattes;
    private String email;
    private File imagemPerfil;
    private CPF cpf;
    private String senha;
    private LocalDate cadastro;
    private int status;
    private String tipo;
    private LocalDate nascimento;
    private ContasSociaisBeans contasSociais;
    
    public UsuarioBeans(){
    
    }
    public UsuarioBeans(long codUsuario, MatriculaBeans matricula, String nome,String email, String senha,CPF cpf, LocalDate nascimento, String formacao, String lattes, String ocupacao, String tipo, int status, LocalDate cadastro) throws Exception{
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
    public UsuarioBeans(MatriculaBeans matricula, String nome,String email, String senha,CPF cpf, LocalDate nascimento, String formacao, String lattes, String ocupacao, String tipo, int status, LocalDate cadastro) throws Exception{
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
    public UsuarioBeans(String nome,String email, String senha,CPF cpf, LocalDate nascimento, String formacao, String lattes, String ocupacao, String tipo, int status, LocalDate cadastro) throws Exception{
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
    public UsuarioBeans(String email, String senha) throws Exception{
        setEmail(email);
        setSenha(senha);
    }

    public long getCodUsuario() {
        return codUsuario;
    }

    public void setCodUsuario(long codUsuario) {
        this.codUsuario = codUsuario;
    }

    public MatriculaBeans getMatricula() {
        return matricula;
    }

    public void setMatricula(MatriculaBeans matricula) {
        this.matricula = matricula;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getOcupacao() {
        return ocupacao;
    }

    public void setOcupacao(String ocupacao) {
        this.ocupacao = ocupacao;
    }

    public String getFormacao() {
        return formacao;
    }

    public void setFormacao(String formacao) {
        this.formacao = formacao;
    }

    public String getLattes() {
        return lattes;
    }

    public void setLattes(String lattes) {
        this.lattes = lattes;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public CPF getCpf() {
        return cpf;
    }

    public void setCpf(CPF cpf) {
        this.cpf = cpf;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public LocalDate getCadastro() {
        return cadastro;
    }

    public void setCadastro(LocalDate cadastro) {
        this.cadastro = cadastro;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public LocalDate getNascimento() {
        return nascimento;
    }

    public void setNascimento(LocalDate nascimento) {
        this.nascimento = nascimento;
    }

    public File getImagemPerfil() {
        return imagemPerfil;
    }

    public void setImagemPerfil(File imagemPerfil) {
        this.imagemPerfil = imagemPerfil;
    }

    public ContasSociaisBeans getContasSociais() {
        return contasSociais;
    }

    public void setContasSociais(ContasSociaisBeans contasSociais) {
        this.contasSociais = contasSociais;
    }
    

    @Override
    public Beans toBeans(Object o) {
        if(o != null){
            if(o instanceof Usuario){
                Usuario u = (Usuario) o;
                this.setCodUsuario(u.getCodUsuario());
                if(u.getMatricula() != null){
                    this.setMatricula((MatriculaBeans) new MatriculaBeans().toBeans(u.getMatricula()));
                }
                this.setNome(u.getNome());
                this.setCpf(u.getCpf());
                this.setEmail(u.getEmail());
                this.setSenha(u.getSenha());
                this.setStatus(u.getStatus());
                this.setTipo(u.getTipo());
                this.setOcupacao(u.getOcupacao());
                this.setFormacao(u.getFormacao());
                this.setLattes(u.getLattes());
                this.setNascimento(u.getNascimento());
                this.setCadastro(u.getCadastro());
                this.setImagemPerfil(u.getImagemPerfil());
                if(u.getContasSociais() != null){
                    this.setContasSociais((ContasSociaisBeans) new ContasSociaisBeans().toBeans(u.getContasSociais()));
                }
                return this;
            }else{
                throw new IllegalArgumentException("Isso não é um Usuário!");
            }
        }else{
            throw new NullPointerException("UsuárioBeans: Usuário não pode ser nulo!");
        }
    }

    @Override
    public Object toBusiness() {
        UsuarioBeans ub = (UsuarioBeans) this;
        Usuario u = new Usuario(ub.getEmail(), ub.getSenha());
        if(ub.getCodUsuario()>0){
            u.setCodUsuario(ub.getCodUsuario());
        }
        if(this.getMatricula() != null){
            System.out.println(this.getMatricula());
            u.setMatricula((Matricula) this.getMatricula().toBusiness());
        }
        if(ub.getFormacao() != null && !ub.getFormacao().isEmpty()){
            u.setFormacao(ub.getFormacao());
        }
        if(ub.getLattes()!= null && !ub.getLattes().isEmpty()){
            u.setLattes(ub.getLattes());
        }
        if(ub.getImagemPerfil() != null){
            u.setImagemPerfil(ub.getImagemPerfil());
        }
        if(ub.getCadastro() != null){
            u.setCadastro(ub.getCadastro());
        }
        if(ub.getOcupacao()!= null && !ub.getOcupacao().isEmpty()){
            u.setOcupacao(ub.getOcupacao());
        }
        if(ub.getTipo()!= null && !ub.getTipo().isEmpty()){
            u.setTipo(ub.getTipo());
        }
        if(ub.getStatus()>=0){
            u.setStatus(ub.getStatus());
        }
        if(ub.getCpf()!= null){
            u.setCpf(ub.getCpf());
        }
        if(ub.getNascimento()!= null){
            u.setNascimento(ub.getNascimento());
        }
        
        if(ub.getNome()!= null && !ub.getNome().isEmpty()){
            u.setNome(ub.getNome());
        }
        if(this.getContasSociais() != null){
            u.setContasSociais((ContasSociais) this.getContasSociais().toBusiness());
        }
        return u;
    }
    
    @Override
    public boolean equals(Object o){
        return (this.getEmail().equalsIgnoreCase(((UsuarioBeans) o).getEmail()));
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 89 * hash + Objects.hashCode(this.email);
        return hash;
    }
    
}
