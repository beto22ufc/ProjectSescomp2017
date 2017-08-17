/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.model;

import java.sql.Date;
import java.time.LocalDate;
import javax.persistence.*;

/**
 *
 * @author Wallison
 */
@Converter(autoApply = true)
@Entity
@Table(name="inscricao")
@Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)
public abstract class Inscricao implements AttributeConverter<LocalDate, Date>{
    @Id
    @GeneratedValue(strategy = GenerationType.TABLE)
    @Column(name="codInscricao")
    private long codInscricao;
    @ManyToOne
    @JoinColumn(name="participante", referencedColumnName = "codUsuario", unique = false)
    private Usuario participante;
    @Column
    private LocalDate data;
    private boolean presente;
    private boolean validada;
    
    public long getCodInscricao() {
        return codInscricao;
    }

    public void setCodInscricao(long codInscricao) {
        if(codInscricao >0)
            this.codInscricao = codInscricao;
        else
            throw new IllegalArgumentException("Código de inscrição deve ser maior que zero!");
    }
    
    public Usuario getParticipante() {
        return participante;
    }

    public void setParticipante(Usuario participante) {
        if(participante !=null)
            this.participante = participante;
        else
            throw new NullPointerException("Deve ser informado um usuário para se increver!");
    }

    public LocalDate getData() {
        return data;
    }

    public void setData(LocalDate data) {
        if(data != null)
            this.data = data;
        else
            throw new NullPointerException("Deve ser informada a data de inscrição!");
    }

    public boolean isPresente() {
        return presente;
    }

    public void setPresente(boolean presente) {
        this.presente = presente;
    }

    public boolean isValidada() {
        return validada;
    }

    public void setValidada(boolean validada) {
        this.validada = validada;
    }

    @Override
    public Date convertToDatabaseColumn(LocalDate attribute) {
        return (attribute == null ? null : Date.valueOf(data));
    }

    @Override
    public LocalDate convertToEntityAttribute(Date dbData) {
        return (dbData == null ? null : dbData.toLocalDate());
    }
    
    
}
