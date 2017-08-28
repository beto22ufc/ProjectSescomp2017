/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.model;

import java.io.Serializable;
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
@Table(name = "contas_sociais")
public class ContasSociais implements Serializable {
    @Id
    @Column(name = "codContasSociais")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
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
        if(nookdear != null && nookdear.contains(this.getNookdear()))
            this.nookdear = nookdear;
        else
            this.nookdear+=nookdear;
    }

    public String getFacebook() {
        return facebook;
    }

    public void setFacebook(String facebook) {
        if(facebook != null && facebook.contains(this.getFacebook()))
            this.facebook = facebook;
        else
            this.facebook += facebook;
    }

    public String getGplus() {
        return gplus;
    }

    public void setGplus(String gplus) {
        if(gplus != null && gplus.contains(this.getGplus()))
            this.gplus = gplus;
        else
            this.gplus += gplus;
    }

    public String getTwitter() {
        return twitter;
    }

    public void setTwitter(String twitter) {
        if(twitter != null && twitter.contains(this.getTwitter()))
            this.twitter = twitter;
        else
            this.twitter += twitter;
    }

    public String getLinkedin() {
        return linkedin;
    }

    public void setLinkedin(String linkedin) {
        if(linkedin != null &&linkedin.contains(this.getLinkedin()))
            this.linkedin = linkedin;
        else
            this.linkedin += linkedin;
    }
    
    
}
