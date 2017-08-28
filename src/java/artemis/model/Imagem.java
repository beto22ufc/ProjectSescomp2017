/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.model;

import java.io.File;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 *
 * @author Wallison
 */
@Entity
@Table(name="imagem")
public class Imagem {
    @Id
    @Column(name = "codImagem")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long codImagem;
    @Column(name = "arquivo")
    private File arquivo;
    private String descricao;
    
    public Imagem(){
    
    }
    
    public Imagem(long codImagem, File arquivo, String descricao){
        setCodImagem(codImagem);
        setArquivo(arquivo);
        setDescricao(descricao);
    }
    
    public Imagem(File arquivo, String descricao){
        setArquivo(arquivo);
        setDescricao(descricao);
    }

    public long getCodImagem() {
        return codImagem;
    }

    public void setCodImagem(long codImagem) {
        if(codImagem>0)
            this.codImagem = codImagem;
        else
            throw new IllegalArgumentException("Código de imagem não pode ser menor igual a zero!");
    }

    public File getArquivo() {
        return arquivo;
    }

    public void setArquivo(File arquivo) {
        if(arquivo != null)
            this.arquivo = arquivo;
        else
            throw new NullPointerException("Arquivo de imagem não pode ser nulo!");
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        if(descricao != null)
            this.descricao = descricao;
        else
            throw new NullPointerException("Descrição não pode ser nula!");
    }
    
    
}
