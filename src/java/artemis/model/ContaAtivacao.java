/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.model;

import artemis.DAO.ContaAtivacaoDAO;
import artemis.DAO.ContaAtivacaoDAOImpl;
import hibernate.HibernateUtil;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;
import java.util.Random;
import javax.persistence.AttributeConverter;
import javax.persistence.Column;
import javax.persistence.Converter;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 *
 * @author Wallison
 */
@Converter(autoApply = true)
@Entity
@Table(name="conta_ativacao")
public class ContaAtivacao implements AttributeConverter<LocalDateTime, Timestamp>{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "codContaAtivacao")
    private long codContaAtivacao;
    @ManyToOne
    @JoinColumn(name="usuario", referencedColumnName = "codUsuario")
    private Usuario usuario;
    @Column(unique = true)
    private String codigo;
    @Column
    private LocalDateTime validade;
    
    public ContaAtivacao(){
    
    }
    
    public ContaAtivacao(long codContaAtivacao, Usuario usuario, String codigo, LocalDateTime validade){
        setCodContaAtivacao(codContaAtivacao);
        setUsuario(usuario);
        setCodigo(codigo);
        setValidade(validade);
    }
    
    public ContaAtivacao(Usuario usuario, String codigo, LocalDateTime validade){
        setUsuario(usuario);
        setCodigo(codigo);
        setValidade(validade);
    }

    public long getCodContaAtivacao() {
        return codContaAtivacao;
    }

    public void setCodContaAtivacao(long codContaAtivacao) {
        if(codContaAtivacao>0)
            this.codContaAtivacao = codContaAtivacao;
        else
            throw new IllegalArgumentException("Código de ativação não pode ser menor que zero!");
    }   

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        if(usuario != null)
            this.usuario = usuario;
        else
            throw new NullPointerException("Usuário não pode ser nulo!");
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        if(codigo != null && !codigo.isEmpty())
            this.codigo = codigo;
        else
            throw new NullPointerException("Link não pode ser nulo!");
    }

    public LocalDateTime getValidade() {
        return validade;
    }

    public void setValidade(LocalDateTime validade) {
        if(validade != null)
            this.validade = validade;
        else
            throw new NullPointerException("Validade não pode ser nula!");
    }

    @Override
    public Timestamp convertToDatabaseColumn(LocalDateTime attribute) {
        return (attribute == null) ? null : Timestamp.valueOf(attribute);
    }

    @Override
    public LocalDateTime convertToEntityAttribute(Timestamp dbData) {
        return (dbData == null) ? null : dbData.toLocalDateTime();
    }
    
    public void geraCodigoValidacao(){
        Random rand = new Random();
        String cod = "";
        Crip crip = new Crip("c0d1g04t1V4c40");
        boolean exists = true;
        ContaAtivacaoDAOImpl contaAtivacaoDAO = new ContaAtivacaoDAOImpl();
        contaAtivacaoDAO.setSessionFactory(HibernateUtil.getSessionFactory());
        List<ContaAtivacao> contas = contaAtivacaoDAO.listaContasAtivacao();
        do{
            cod = crip.enc(String.valueOf(Long.toHexString(rand.nextLong()+System.currentTimeMillis())));
            this.setCodigo(cod);
        }while(contas != null && contas.contains(this));
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 61 * hash + Objects.hashCode(this.codigo);
        return hash;
    }
     
    @Override
    public boolean equals(Object o){
        return (((ContaAtivacao) o).getCodigo().equals(this.getCodigo()));
    }
}
