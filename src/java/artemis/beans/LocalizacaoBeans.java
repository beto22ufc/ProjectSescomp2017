/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.beans;

import artemis.model.Localizacao;

/**
 *
 * @author Wallison
 */
public class LocalizacaoBeans implements Beans{
    private long codLocalizacao;
    private String nome;
    private float lat;
    private float lng;
    
    public LocalizacaoBeans(){}
    
    public LocalizacaoBeans(long codLocalizacao, String nome, float lat, float lng){
        setCodLocalizacao(codLocalizacao);
        setNome(nome);
        setLat(lat);
        setLng(lng);
    }
    
    public LocalizacaoBeans(String nome, float lat, float lng){
        setNome(nome);
        setLat(lat);
        setLng(lng);
    }

    public long getCodLocalizacao() {
        return codLocalizacao;
    }

    public void setCodLocalizacao(long codLocalizacao) {
        this.codLocalizacao = codLocalizacao;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
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

    @Override
    public Beans toBeans(Object o) {
        if(o != null){
            if(o instanceof Localizacao){
                Localizacao localizacao = (Localizacao) o;
                this.setCodLocalizacao(localizacao.getCodLocalizacao());
                this.setNome(localizacao.getNome());
                this.setLat(localizacao.getLat());
                this.setLng(localizacao.getLng());
                return this;
            }else{
                throw new NullPointerException("Isso não é uma localização!");
            }
        }else{
            throw new NullPointerException("Localização não pode ser nula!");
        }
    }

    @Override
    public Object toBusiness() {
        Localizacao localizacao = new Localizacao(this.getNome(), this.getLat(), this.getLng());
        if(this.getCodLocalizacao()>0){
            localizacao.setCodLocalizacao(this.getCodLocalizacao());
        }
        return localizacao;
    }
    
    
}
