/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.model;

import javax.persistence.*;

/**
 *
 * @author Wallison
 */
@Entity
@Table(name="localizacao")
public class Localizacao {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="codLocalizacao")
    private long codLocalizacao;
    private String nome;
    private float lat;
    private float lng;
    
    public Localizacao(){}
    
    public Localizacao(long codLocalizacao, String nome, float lat, float lng){
        setCodLocalizacao(codLocalizacao);
        setNome(nome);
        setLat(lat);
        setLng(lng);
    }
    
    public Localizacao(String nome, float lat, float lng){
        setNome(nome);
        setLat(lat);
        setLng(lng);
    }
    
    public long getCodLocalizacao() {
        return codLocalizacao;
    }

    public void setCodLocalizacao(long codLocalizacao) {
        if(codLocalizacao>0)
            this.codLocalizacao = codLocalizacao;
        else
            throw new IllegalArgumentException("Código de localização não pode ser menor ou igual a zero!");
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        if(nome != null & !nome.isEmpty())
            this.nome = nome;
        else
            throw new NullPointerException("Nome não pode ser vazio!");
    }

    public float getLat() {
        return lat;
    }

    public void setLat(float lat) {
        this.lat = lat;
    }

    public float getLng() {
        return lng;
    }

    public void setLng(float lng) {
        this.lng = lng;
    }
    
    
}
