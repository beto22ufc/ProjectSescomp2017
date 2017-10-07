/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.model;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.JDOMException;
import org.jdom2.input.SAXBuilder;

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

    public void setDiretorio(File diretorio) {
        if(diretorio == null)
            throw new NullPointerException("Direitório não pode ser nulo!");
        else
            this.diretorio = diretorio;
    }

    public boolean isSeccao() {
        return seccao;
    }

    public void setSeccao(boolean seccao) {
        this.seccao = seccao;
    }
    
    public static Tema getTema(String nome) throws IOException, JDOMException{
        File fileInfo = FileManipulation.getFileStream(FileManipulation.getStreamFromURL(Constantes.URL+"/"+Constantes.DIR+"/theme/evento/"+nome+"/info.xml"),".xml");
        Tema tema = new Tema();
        SAXBuilder builder = new SAXBuilder();
        Document doc = builder.build(fileInfo);
        Element root = (Element) doc.getRootElement();
        List pessoas = root.getChildren();
        Iterator i = pessoas.iterator();
        while( i.hasNext() ){
            Element pessoa = (Element) i.next();
            if(pessoa.getChildText("nome").equals(nome)){
                tema.setNome(pessoa.getChildText("nome"));
                tema.setVersao(pessoa.getChildText("versao"));
                tema.setSeccao(pessoa.getChildText("seccao").equals("true"));
                tema.setDiretorio(FileManipulation.getFileStream(FileManipulation.getStreamFromURL(Constantes.URL+"/"+Constantes.DIR+"/theme/evento/"+nome+"/"), "dir"));
                break;
            }
        }
        return tema;
    }
    
    public static List<String> getTemas() throws IOException, JDOMException{
        List<String> temas = Collections.synchronizedList(new ArrayList<String>());
        File fileInfo = FileManipulation.getFileStream(FileManipulation.getStreamFromURL(Constantes.URL+"/"+Constantes.DIR+"/theme/evento/temas.xml"),".xml");
        SAXBuilder builder = new SAXBuilder();
        Document doc = builder.build(fileInfo);
        Element root = (Element) doc.getRootElement();
        List pessoas = root.getChildren();
        Iterator i = pessoas.iterator();
        while( i.hasNext() ){
            Element pessoa = (Element) i.next();
            temas.add(pessoa.getChildText("nome"));              
        }
        return temas;
    }
}
