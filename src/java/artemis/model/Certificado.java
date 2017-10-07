/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.model;

/**
 *
 * @author Wallison
 */
public class Certificado {
    private long codCertificado;
    private Inscricao inscricao;
    private String codVerificador;
    
    
    public long getCodCertificado() {
        return codCertificado;
    }

    public void setCodCertificado(long codCertificado) {
        this.codCertificado = codCertificado;
    }

    public Inscricao getInscricao() {
        return inscricao;
    }

    public void setInscricao(Inscricao inscricao) {
        this.inscricao = inscricao;
    }

    public String getCodVerificador() {
        return codVerificador;
    }

    public void setCodVerificador(String codVerificador) {
        this.codVerificador = codVerificador;
    }
    
    
}
