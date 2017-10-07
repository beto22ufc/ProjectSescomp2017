/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.beans;

import artemis.model.Tema;
import java.io.File;

/**
 *
 * @author Wallison
 */
public class TemaBeans implements Beans{
    private long codTema;
    private String nome;
    private String versao;
    private File diretorio;
    private boolean seccao;

    public long getCodTema() {
        return codTema;
    }

    public void setCodTema(long codTema) {
        this.codTema = codTema;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getVersao() {
        return versao;
    }

    public void setVersao(String versao) {
        this.versao = versao;
    }

    public File getDiretorio() {
        return diretorio;
    }

    public void setDiretorio(File diretorio) {
        this.diretorio = diretorio;
    }

    public boolean isSeccao() {
        return seccao;
    }

    public void setSeccao(boolean seccao) {
        this.seccao = seccao;
    }

    @Override
    public Beans toBeans(Object o) {
        if(o != null){
            if(o instanceof Tema){
                Tema tema = (Tema) o;
                this.setCodTema(tema.getCodTema());
                this.setNome(tema.getNome());
                this.setDiretorio(tema.getDiretorio());
                this.setSeccao(tema.isSeccao());
                this.setVersao(tema.getVersao());
                return this;
            }else{
                throw new IllegalArgumentException("Isso não é um Tema!");
            }
        }else{
            throw new NullPointerException("Tema não pode ser nulo!");
        }
    }

    @Override
    public Object toBusiness() {
        Tema tema = new Tema();
        if(this.getCodTema()>0){
            tema.setCodTema(this.getCodTema());
        }
        tema.setNome(this.getNome());
        tema.setDiretorio(this.getDiretorio());
        tema.setSeccao(this.isSeccao());
        tema.setVersao(this.getVersao());
        return tema;
    }
    
    
}
