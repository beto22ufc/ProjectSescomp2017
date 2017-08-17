/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.beans;

import artemis.model.ContaAtivacao;
import artemis.model.Usuario;
import java.time.LocalDateTime;

/**
 *
 * @author Wallison
 */
public class ContaAtivacaoBeans implements Beans{
    private long codContaAtivacao;
    private UsuarioBeans usuario;
    private String codigo;
    private LocalDateTime validade;
    
    public ContaAtivacaoBeans(){
    
    }
    
    public ContaAtivacaoBeans(long codContaAtivacao, UsuarioBeans usuario, String codigo, LocalDateTime validade){
        setCodContaAtivacao(codContaAtivacao);
        setUsuario(usuario);
        setCodigo(codigo);
        setValidade(validade);
    }
    
    public ContaAtivacaoBeans(UsuarioBeans usuario, String codigo, LocalDateTime validade){
        setUsuario(usuario);
        setCodigo(codigo);
        setValidade(validade);
    }

    public long getCodContaAtivacao() {
        return codContaAtivacao;
    }

    public void setCodContaAtivacao(long codContaAtivacao) {
        this.codContaAtivacao = codContaAtivacao;
    }

    public UsuarioBeans getUsuario() {
        return usuario;
    }

    public void setUsuario(UsuarioBeans usuario) {
        this.usuario = usuario;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public LocalDateTime getValidade() {
        return validade;
    }

    public void setValidade(LocalDateTime validade) {
        this.validade = validade;
    }

    @Override
    public Beans toBeans(Object o) {
        if(o != null){
            if(o instanceof ContaAtivacao){
                ContaAtivacao ca = (ContaAtivacao) o;
                this.setCodContaAtivacao(ca.getCodContaAtivacao());
                this.setUsuario((UsuarioBeans) new UsuarioBeans().toBeans(ca.getUsuario()));
                this.setCodigo(ca.getCodigo());
                this.setValidade(ca.getValidade());
                return this;
            }else{
                throw new IllegalArgumentException("Isso não é uma conta ativação!");
            }
        }else{
            throw new NullPointerException("Conta ativação não pode ser nula!");
        }
    }

    @Override
    public Object toBusiness() {
        ContaAtivacao ca = new ContaAtivacao((Usuario) this.getUsuario().toBusiness(), this.getCodigo(), this.getValidade());
        if(this.getCodContaAtivacao()>0){
            ca.setCodContaAtivacao(this.getCodContaAtivacao());
        }
        return ca;
    }
    
    
}
