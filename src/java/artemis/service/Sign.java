/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.service;

import artemis.DAO.ContaAtivacaoDAOImpl;
import artemis.DAO.UsuarioDAOImpl;
import artemis.model.Constantes;
import artemis.model.ContaAtivacao;
import artemis.model.Crip;
import artemis.model.Email;
import artemis.model.FileManipulation;
import artemis.model.Usuario;
import hibernate.HibernateUtil;
import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
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
        Usuario recuperado = this.getUsuarioDAOImpl().getUsuarioFromEmail(this.getUsuario().getEmail());
        if(recuperado != null){
            String senha = this.crip.dec(recuperado.getSenha());
            if(senha.equals(this.getUsuario().getSenha())){
                return recuperado;
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
    public void cadastra() throws EmailException, IOException{
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
            File file  = FileManipulation.getFileStream(FileManipulation.getStreamFromURL(""+Constantes.URL+"/ArtemisTCC/theme/sistema/email/confirm/index.html"), "html");
            String html = FileManipulation.fileToString(file);
            html = html.replace("#{keywords}", "Sistema de gerenciamento de eventos Artemis Events")
                    .replace("#{image01}", Constantes.URL+"/"+Constantes.DIR+"/theme/sistema/email/confirm/images/image01.png")
                    .replace("#{image02}", Constantes.URL+"/"+Constantes.DIR+"/theme/sistema/email/confirm/images/image02.png")
                    .replace("#{image03}", Constantes.URL+"/"+Constantes.DIR+"/theme/sistema/email/confirm/images/image03.png")
                    .replace("#{image04}", Constantes.URL+"/"+Constantes.DIR+"/theme/sistema/email/confirm/images/image04.jpg")
                    .replace("#{linkConfirmaConta}", Constantes.URL+"/"+Constantes.DIR+"/validarConta?cv="+conta.getCodigo()+"")
                    .replace("#{data}", ""+LocalDate.now().getYear());

            Email email = new Email("Cadastro realizado com sucesso! Ativar conta! ", html, this.getUsuario().getEmail(), this.getUsuario().getNome());
            email.sendEmailHtml();
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
