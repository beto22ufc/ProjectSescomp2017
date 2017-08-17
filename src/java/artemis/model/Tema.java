/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.model;

import java.io.File;
import java.io.FileNotFoundException;

/**
 *
 * @author Wallison
 */
public class Tema {
    
    private long codTema;
    private String nome;
    private String versao;
    private File diretorio;
    private boolean seccao;
    
    public Tema(){
    
    }
    
    public Tema(long codTema, String nome, String versao, File diretorio, boolean seccao) throws FileNotFoundException{
        setCodTema(codTema);
        setNome(nome);
        setVersao(versao);
        setDiretorio(diretorio);
        setSeccao(seccao);
    }
    
    public Tema(String nome, String versao, File diretorio, boolean seccao) throws FileNotFoundException{
        setNome(nome);
        setVersao(versao);
        setDiretorio(diretorio);
        setSeccao(seccao);
    }

    public long getCodTema() {
        return codTema;
    }

    public void setCodTema(long codTema) {
        if(codTema>0)
            this.codTema = codTema;
        else
            throw new IllegalArgumentException("Código do tema deve ser maior que zero!");
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        if(nome != null && !nome.isEmpty())
            this.nome = nome;
        else 
            throw new NullPointerException("Nome do tema não pode ser vazio!");
    }

    public String getVersao() {
        return versao;
    }

    public void setVersao(String versao) {
        if(versao != null && !versao.isEmpty())
            this.versao = versao;
        else
            throw new NullPointerException("Versão não pode ser vazia!");
    }

    public File getDiretorio() {
        return diretorio;
    }

    public void setDiretorio(File diretorio) throws FileNotFoundException {
        if(diretorio == null)
            throw new NullPointerException("Direitório não pode ser nulo!");
        else if(!diretorio.exists())
            throw new FileNotFoundException("Diretório de tema não exite!");
        else
            this.diretorio = diretorio;
    }

    public boolean isSeccao() {
        return seccao;
    }

    public void setSeccao(boolean seccao) {
        this.seccao = seccao;
    }
    
    
}
