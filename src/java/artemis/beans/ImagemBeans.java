/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.beans;

import artemis.model.Imagem;
import java.io.File;

/**
 *
 * @author Wallison
 */
public class ImagemBeans implements Beans{
    private long codImagem;
    private File arquivo;
    private String descricao;
    
    
    public ImagemBeans(){
    
    }
    
    public ImagemBeans(long codImagem, File arquivo, String descricao){
        setCodImagem(codImagem);
        setArquivo(arquivo);
        setDescricao(descricao);
    }
    
    public ImagemBeans(File arquivo, String descricao){
        setArquivo(arquivo);
        setDescricao(descricao);
    }

    public long getCodImagem() {
        return codImagem;
    }

    public void setCodImagem(long codImagem) {
        this.codImagem = codImagem;
    }

    public File getArquivo() {
        return arquivo;
    }

    public void setArquivo(File arquivo) {
        this.arquivo = arquivo;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    @Override
    public Beans toBeans(Object o) {
        if(o != null){
            if(o instanceof Imagem){
                Imagem i = (Imagem) o;
                this.setCodImagem(i.getCodImagem());
                this.setArquivo(i.getArquivo());
                this.setDescricao(i.getDescricao());
                return this;
            }else{
                throw new IllegalArgumentException("Isso não é uma imagem!");
            }                
        }else{
            throw new NullPointerException("Imagem não pode ser nula!");
        }
    }

    @Override
    public Object toBusiness() {
        Imagem i = new Imagem();
        if(this.getCodImagem()>0){
            i.setCodImagem(this.getCodImagem());
        }
        i.setArquivo(this.getArquivo());
        if(this.getDescricao()!= null){
            i.setDescricao(this.getDescricao());
        }
        return i;
    }
    
    
}
