/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.service;

import artemis.DAO.ContaAtivacaoDAOImpl;
import artemis.DAO.UsuarioDAOImpl;
import artemis.model.ContaAtivacao;
import artemis.model.Crip;
import artemis.model.Email;
import artemis.model.Usuario;
import hibernate.HibernateUtil;
import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;
import java.util.Random;
import org.apache.commons.mail.EmailException;


/**
 *
 * @author Wallison
 */
//@Service
public class Sign {
    
    private Usuario usuario;
    private UsuarioDAOImpl usuarioDAOImpl = new UsuarioDAOImpl();
    private ContaAtivacaoDAOImpl contaAtivacaoDAO = new ContaAtivacaoDAOImpl();
    private Crip crip = new Crip();
    
    public Sign(){
        
    }
    
    public Sign(Usuario usuario){
        setUsuario(usuario);
    }
    
    //@Transactional
    public Usuario entra(){
        this.getUsuarioDAOImpl().setSessionFactory(HibernateUtil.getSessionFactory());
        List<Usuario> usuarios = Collections.synchronizedList(this.getUsuarioDAOImpl().listaUsuarios());
        if(usuarios.contains(this.getUsuario())){
            Usuario u = usuarios.get(usuarios.indexOf(this.getUsuario()));
            String senha = this.crip.dec(u.getSenha());
            if(senha.equals(this.getUsuario().getSenha())){
                return u;
            }else{
                return null;
            }
        }else{
            return null;
        }
    }
    
    private boolean usuarioIsUnico(Usuario usuario, List<Usuario> usuarios){
        for(int i=0;i<usuarios.size();i++){
            Usuario u = usuarios.get(i);
            if(u.getEmail().equals(usuario.getEmail())){
                throw new IllegalArgumentException("E-mail já está cadastrado no nosso sistema!");
            }
            if(usuario.getCpf().getFormatedCpf().equals(u.getCpf().getFormatedCpf())){
                throw new IllegalArgumentException("CPF já está cadastrado no nosso sistema!");
            }
        }
        return true;
    }
    
    //@Transactional
    public void cadastra() throws EmailException{
        this.getUsuario().setSenha(this.crip.enc(this.getUsuario().getSenha()));
        this.getUsuarioDAOImpl().setSessionFactory(HibernateUtil.getSessionFactory());
        if(usuarioIsUnico(this.getUsuario(), this.getUsuarioDAOImpl().listaUsuarios())){
            this.getUsuarioDAOImpl().adicionaCPF(this.getUsuario().getCpf());
            this.getUsuarioDAOImpl().adicionarUsuario(this.getUsuario());
            ContaAtivacao conta = new ContaAtivacao();
            conta.setUsuario(this.getUsuario());
            conta.geraCodigoValidacao();
            conta.setValidade(LocalDateTime.now().plusHours(12));
            this.getContaAtivacaoDAO().setSessionFactory(HibernateUtil.getSessionFactory());
            this.getContaAtivacaoDAO().adicionarContaAtivacao(conta);
            Email email = new Email("Cadastro realizado com sucesso! Ativar conta!", "Ative sua conta!\nClique no link para ativar sua conta http://localhost:8084/ArtemisTCC/validarConta?cv="+conta.getCodigo()+""
                    + "\n(Obs.: Link válido até 12 horas após o cadastro)", this.getUsuario().getEmail(), this.getUsuario().getNome());
            email.sendEmail();
        }
    }
    
    public void recuperaSenha() throws EmailException{
        String senha = geraSenhaAleatoria();
        usuario.setSenha(crip.enc(senha));
        usuarioDAOImpl.adicionarUsuario(usuario);
        Email email = new Email("Recuperação de senha Artemis", "Olá senhor(a) "+usuario.getNome()+" sua senha foi"
                + " alterada para "+senha+", por favor realize o login e alteração da sua senha!", usuario.getEmail(), usuario.getNome());
        email.sendEmail();
    }
    
    private String geraSenhaAleatoria(){
        Random rand = new Random();
        return (String.valueOf(Long.toHexString(rand.nextLong()+System.currentTimeMillis())));
    }
    
    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        if(usuario != null)
            this.usuario = usuario;
        else
            throw new NullPointerException("Sign: Usuário não pode ser nulo!");
    }

    private UsuarioDAOImpl getUsuarioDAOImpl() {
        return usuarioDAOImpl;
    }

    private void setUsuarioDAOImpl(UsuarioDAOImpl usuarioDAOImpl) {
        this.usuarioDAOImpl = usuarioDAOImpl;
    }

    public ContaAtivacaoDAOImpl getContaAtivacaoDAO() {
        return contaAtivacaoDAO;
    }

    public void setContaAtivacaoDAO(ContaAtivacaoDAOImpl contaAtivacaoDAO) {
        this.contaAtivacaoDAO = contaAtivacaoDAO;
    }
    
    
    
    
}
