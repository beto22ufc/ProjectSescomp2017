/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.model;

import artemis.DAO.EventoDAOImpl;
import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Objects;
import javax.persistence.*;

/**
 *
 * @author Wallison
 */
@Converter(autoApply = true)
@Entity
@Table(name="inscricao")
public class Inscricao implements AttributeConverter<LocalDate, Date>{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
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
    
    public List<List> verificaChoque(Evento evento){
        EventoDAOImpl edao = new EventoDAOImpl();
        List<Evento> eventos = edao.listaEventos();
        List<List> choques = Collections.synchronizedList(new ArrayList<List>());
        List<Atividade> chocadas = Collections.synchronizedList(new ArrayList<Atividade>());
        List<Evento> chocados = Collections.synchronizedList(new ArrayList<Evento>());
        Evento vinculado = null;
        for(int i=0;i<eventos.size();i++){
            Evento e = eventos.get(i);
            List<Evento> es = e.getEventos();
            for(Evento evt : es){
                if(evt.getCodEvento() == evento.getCodEvento()){
                    vinculado = e;
                    break;
                }
            }
            if(vinculado != null){
                break;
            }
        }
        if(vinculado!=null){
            for(int i=0;i<vinculado.getAtividades().size();i++){
                Atividade a = vinculado.getAtividades().get(i);
                List<Periodo> periodos = a.getPeriodos();
                for(int j=0;j<evento.getPeriodos().size();j++){
                    Periodo p = evento.getPeriodos().get(j);
                    if(p.detectaColisao(periodos).size()>0){
                        chocadas.add(a);
                        break;
                    }
                }
            }
            for(int i=0;i<vinculado.getEventos().size();i++){
                Evento e = vinculado.getEventos().get(i);
                List<Periodo> periodos = e.getPeriodos();
                if(e.getCodEvento() != evento.getCodEvento()){
                    for(int j=0;j<evento.getPeriodos().size();j++){
                        Periodo p = evento.getPeriodos().get(j);
                        if(p.detectaColisao(periodos).size()>0){
                            chocados.add(e);
                            break;
                        }
                    }
                }
            }
        }
        choques.add(chocadas);
        choques.add(chocados);
        return choques;
    }
    
    public List<List> verificaChoque(Atividade atividade){
        EventoDAOImpl edao = new EventoDAOImpl();
        List<Evento> eventos = edao.listaEventos();
        List<List> choques = Collections.synchronizedList(new ArrayList<List>());
        List<Atividade> chocadas = Collections.synchronizedList(new ArrayList<Atividade>());
        List<Evento> chocados = Collections.synchronizedList(new ArrayList<Evento>());
        Evento vinculado = null;
        for(int i=0;i<eventos.size();i++){
            Evento e = eventos.get(i);
            List<Atividade> as = e.getAtividades();
            for(int j=0;j<as.size();j++){
                Atividade a = as.get(j);
                if(a.getCodAtividade() == atividade.getCodAtividade()){
                    vinculado = e;
                    break;
                }
            }
            if(vinculado !=null){
                break;
            }
        }
        if(vinculado!=null){
            for(int i=0;i<vinculado.getAtividades().size();i++){
                Atividade a = vinculado.getAtividades().get(i);
                List<Periodo> periodos = a.getPeriodos();
                if(a.getCodAtividade() != atividade.getCodAtividade()){
                    for(int j=0;j<atividade.getPeriodos().size();j++){
                        Periodo p = atividade.getPeriodos().get(j);
                        if(p.detectaColisao(periodos).size()>0){
                            chocadas.add(a);
                            break;
                        }
                    }
                }
            }
            for(int i=0;i<vinculado.getEventos().size();i++){
                Evento e = vinculado.getEventos().get(i);
                List<Periodo> periodos = e.getPeriodos();
                for(int j=0;j<atividade.getPeriodos().size();j++){
                    Periodo p = atividade.getPeriodos().get(j);
                    if(p.detectaColisao(periodos).size()>0){
                        chocados.add(e);
                        break;
                    }
                }
                
            }
        }
        choques.add(chocadas);
        choques.add(chocados);
        return choques;
    }
    
    @Override
    public boolean equals(Object o){
        Inscricao inscricao = (Inscricao) o;
        return (this.getParticipante().equals(inscricao.getParticipante()));
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 89 * hash + Objects.hashCode(this.participante);
        return hash;
    }
    
}
