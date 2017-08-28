/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.beans;

import artemis.model.ContasSociais;

/**
 *
 * @author Wallison
 */
public class ContasSociaisBeans implements Beans{
    private long codContasSociais;
    private String nookdear = "https://nookdear.com/";
    private String facebook = "https://facebook.com/";
    private String gplus = "https://plus.google.com/";
    private String twitter = "https://twitter.com/";
    private String linkedin = "https://linkedin.com/";

    public long getCodContasSociais() {
        return codContasSociais;
    }

    public void setCodContasSociais(long codContasSociais) {
        this.codContasSociais = codContasSociais;
    }

    public String getNookdear() {
        return nookdear;
    }

    public void setNookdear(String nookdear) {
        this.nookdear = nookdear;
    }

    public String getFacebook() {
        return facebook;
    }

    public void setFacebook(String facebook) {
        this.facebook = facebook;
    }

    public String getGplus() {
        return gplus;
    }

    public void setGplus(String gplus) {
        this.gplus = gplus;
    }

    public String getTwitter() {
        return twitter;
    }

    public void setTwitter(String twitter) {
        this.twitter = twitter;
    }

    public String getLinkedin() {
        return linkedin;
    }

    public void setLinkedin(String linkedin) {
        this.linkedin = linkedin;
    }

    @Override
    public Beans toBeans(Object o) {
        if(o != null){
            if(o instanceof ContasSociais){
                ContasSociais cs = (ContasSociais) o;
                this.setCodContasSociais(cs.getCodContasSociais());
                this.setNookdear(cs.getNookdear());
                this.setFacebook(cs.getFacebook());
                this.setGplus(cs.getGplus());
                this.setTwitter(cs.getTwitter());
                this.setLinkedin(cs.getLinkedin());
                return this;
            }else{
                throw new IllegalArgumentException("Isso não é uma conta social!");
            }
        }else{
            throw new NullPointerException("Contas sociais não podem ser nula!");
        }
    }

    @Override
    public Object toBusiness() {
        ContasSociais cs = new ContasSociais();
        if(this.getCodContasSociais() >0){
            cs.setCodContasSociais(this.getCodContasSociais());
        }
        if(this.getNookdear() != null){
            cs.setNookdear(this.getNookdear());
        }
        if(this.getFacebook() != null){
            cs.setFacebook(this.getFacebook());
        }
        if(this.getGplus() != null){
            cs.setGplus(this.getGplus());
        }
        if(this.getTwitter() != null){
            cs.setTwitter(this.getTwitter());
        }
        if(this.getLinkedin() != null){
            cs.setLinkedin(this.getLinkedin());
        }
        return cs;
    }
    
    
}
