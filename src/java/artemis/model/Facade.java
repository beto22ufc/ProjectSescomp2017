/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.model;

import artemis.DAO.AtividadeDAOImpl;
import artemis.DAO.ContaAtivacaoDAOImpl;
import artemis.DAO.EventoDAOImpl;
import artemis.DAO.InstituicaoDAOImpl;
import artemis.DAO.MatriculaDAOImpl;
import artemis.DAO.UsuarioDAOImpl;
import artemis.beans.*;
import artemis.service.Sign;
import hibernate.HibernateUtil;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import org.apache.commons.mail.EmailException;

/**
 *
 * @author Wallison
 */
public class Facade {
    private UsuarioBeans usuario;
    
    public Facade(){
    
    }
    
    public Facade(UsuarioBeans usuario){
        this.usuario = usuario;
    }
    
    public UsuarioBeans fazerLogin(UsuarioBeans ub){
        Sign sign = new Sign((Usuario) ub.toBusiness());
        Usuario u = sign.entra();
        if(u != null)
            return (UsuarioBeans) ub.toBeans(u);
        else{
            return null;
        }
    }
    
    public void fazerCadastro(UsuarioBeans ub) throws EmailException{
        Sign sign = new Sign((Usuario) ub.toBusiness());
        sign.cadastra();
    }
    
    public void atualizaUsuarioGeral(UsuarioBeans ub){
        Usuario u = (Usuario) ub.toBusiness();
        u.setStatus(1);
        u.atualizaInformacoesGerais();
    }
    
    public UsuarioBeans atualizaUsuarioSenha(UsuarioBeans ub, String antiga, String senhaNova){
        Crip crip = new Crip();
        if(crip.dec(ub.getSenha()).equals(antiga)){
            ub.setSenha(crip.enc(senhaNova));
        }else{
            throw new IllegalArgumentException("Senha antiga não confere!");
        }
        Usuario u = (Usuario) ub.toBusiness();
        u.setStatus(1);
        u.atualizaInformacoesGerais();
        return ub;
    }
    
    public UsuarioBeans atualizaUsuarioEmail(UsuarioBeans ub, String antigo, String emailNovo) throws EmailException{
        if(ub.getEmail().equals(antigo)){
            ub.setEmail(emailNovo);
        }else{
            throw new IllegalArgumentException("E-mail antigo não confere!");
        }
        Usuario u = (Usuario) ub.toBusiness();
        u.setStatus(0);
        u.atualizaInformacoesGerais();
        ContaAtivacaoDAOImpl cadaoi = new ContaAtivacaoDAOImpl();
        cadaoi.setSessionFactory(HibernateUtil.getSessionFactory());
        ContaAtivacao ca = new ContaAtivacao();
        ca.setUsuario(u);
        ca.setValidade(LocalDateTime.now().plusHours(12));
        ca.geraCodigoValidacao();
        cadaoi.adicionarContaAtivacao(ca);
        Email e = new Email("E-mail atualizado com sucesso! Ativar conta!", 
                    "Ative sua conta!\nClique no link para ativar sua conta "
                            + "http://localhost:8084/ArtemisTCC/validarConta?cv="+ca.getCodigo()+""
                    + "\n(Obs.: Link válido até 12 horas após o cadastro)", u.getEmail(), u.getNome());
            e.sendEmail();
        return ub;
    }
    
    public void validarConta(String cod){
        ContaAtivacaoDAOImpl cadaoi = new ContaAtivacaoDAOImpl();
        cadaoi.setSessionFactory(HibernateUtil.getSessionFactory());
        List<ContaAtivacao> contas = cadaoi.listaContasAtivacao();
        boolean codExiste = false;
        for(int i=0;i<contas.size();i++){
            ContaAtivacao conta = contas.get(i);
            if(conta.getCodigo().equals(cod)){
                codExiste = true;
                ZoneId zoneId = ZoneId.of("America/Sao_Paulo");
                ZonedDateTime zdtV = conta.getValidade().atZone(zoneId);
                ZonedDateTime zdtN = LocalDateTime.now().atZone(zoneId);
                UsuarioDAOImpl udaoi = new UsuarioDAOImpl();
                udaoi.setSessionFactory(HibernateUtil.getSessionFactory());
                if(zdtV.toEpochSecond()>=zdtN.toEpochSecond()){
                    conta.getUsuario().setStatus(1);
                    udaoi.atualizarUsuario(conta.getUsuario());
                }else{
                    cadaoi.removerContaAtivacao(conta);
                    udaoi.removeUsuario(conta.getUsuario());
                    throw new IllegalArgumentException("O tempo expirou! Seu código é inválido! Sua conta foi removida, é necessário criar uma nova!");
                }
            }
        }
        if(!codExiste) throw new IllegalArgumentException("Código informado é inválido!");
    }
    
    public void reenviarEmail(String email) throws EmailException{
        UsuarioDAOImpl udaoi = new UsuarioDAOImpl();
        udaoi.setSessionFactory(HibernateUtil.getSessionFactory());
        ContaAtivacaoDAOImpl cadaoi = new ContaAtivacaoDAOImpl();
        cadaoi.setSessionFactory(HibernateUtil.getSessionFactory());
        List<ContaAtivacao> contas = cadaoi.listaContasAtivacao();
        List<Usuario> usuarios = udaoi.listaUsuarios();
        Usuario usuario = new Usuario(email, "1234568975");
        if(usuarios.contains(usuario)){
            usuario = usuarios.get(usuarios.indexOf(usuario));
        }else{
            throw new IllegalArgumentException("Usuário não está cadastrado no nosso sistema!");
        }
        if(usuario.getStatus()==0){
            for(int i=0;i<contas.size();i++){
                ContaAtivacao conta = contas.get(i);
                if(conta.getUsuario().equals(usuario)){
                    cadaoi.removerContaAtivacao(conta);
                }
            }
            ContaAtivacao conta = new ContaAtivacao();
            conta.setUsuario(usuario);
            conta.setValidade(LocalDateTime.now().plusMinutes(12));
            conta.geraCodigoValidacao();
            cadaoi.adicionarContaAtivacao(conta);
            Email e = new Email("Cadastro realizado com sucesso! Ativar conta!", 
                    "Ative sua conta!\nClique no link para ativar sua conta "
                            + "http://localhost:8084/ArtemisTCC/validarConta?cv="+conta.getCodigo()+""
                    + "\n(Obs.: Link válido até 12 horas após o cadastro)", usuario.getEmail(), usuario.getNome());
            e.sendEmail();
        }else{
            throw new IllegalArgumentException("Sua conta já está ativa!");
        }
    }
    
    public EventoBeans cadastraEvento(EventoBeans evento) throws IllegalAccessException{
        Evento e = (Evento) evento.toBusiness();
        EventoProxy ep = new EventoProxy((Usuario)usuario.toBusiness());
        return (EventoBeans) evento.toBeans(ep.novoEvento(e));
    }
    
    public void atualizaEvento(EventoBeans evento) throws IllegalAccessException{
        Evento e = (Evento) evento.toBusiness();
        EventoProxy ep = new EventoProxy((Usuario)usuario.toBusiness());
        ep.atualizaEvento(e);
    }
    
    public List<EventoBeans> getEventos(){
        EventoDAOImpl edaoi = new EventoDAOImpl();
        edaoi.setSessionFactory(HibernateUtil.getSessionFactory());
        List<EventoBeans> eventos = Collections.synchronizedList(new ArrayList<>());
        List<Evento> events = edaoi.listaEventos();
        for(int i=0;i<events.size();i++){
            eventos.add((EventoBeans) new EventoBeans().toBeans(events.get(i)));
        }
        return eventos;
    }
    
    public EventoBeans getEvento(long codEvento){
        EventoDAOImpl edaoi = new EventoDAOImpl();
        edaoi.setSessionFactory(HibernateUtil.getSessionFactory());
        return (EventoBeans) new EventoBeans().toBeans(edaoi.getEvento(codEvento));
    }
    
    public AtividadeBeans cadastraAtividade(AtividadeBeans atividade) throws IllegalAccessException{
        EventoProxy ep = new EventoProxy((Usuario) usuario.toBusiness());
        Atividade a = ep.novaAtividade((Atividade) atividade.toBusiness());
        return (AtividadeBeans) new AtividadeBeans().toBeans(a);
    }
    
    public void atualizaAtividade(AtividadeBeans atividade) throws IllegalAccessException{
        EventoProxy ep = new EventoProxy((Usuario) usuario.toBusiness());
        ep.atualizaAtividade((Atividade) atividade.toBusiness());
    }
    
    public long getCodFromParameter(String s){
        String[] parts = s.split("_");
        return Long.parseLong(parts[parts.length-1]);
    }
    
    public List<UsuarioBeans> getUsuarios(){
        UsuarioDAOImpl udaoi = new UsuarioDAOImpl();
        udaoi.setSessionFactory(HibernateUtil.getSessionFactory());
        List<UsuarioBeans> usuarios = Collections.synchronizedList(new ArrayList<>());
        List<Usuario> users = Collections.synchronizedList(udaoi.listaUsuarios());
        for(int i=0;i<users.size();i++){
            usuarios.add((UsuarioBeans) new UsuarioBeans().toBeans(users.get(i)));
        }
        return usuarios;
    }
    
    public List<InstituicaoBeans> getInstituicoes(){
        InstituicaoDAOImpl idaoi = new InstituicaoDAOImpl();
        idaoi.setSessionFactory(HibernateUtil.getSessionFactory());
        List<Instituicao> is =  Collections.synchronizedList(idaoi.listaInstituicoes());
        List<InstituicaoBeans> ib = Collections.synchronizedList(new ArrayList<>());
        for(int i=0;i<is.size();i++){
            ib.add((InstituicaoBeans) new InstituicaoBeans().toBeans(is.get(i)));
        }
        return ib;
    }
    
    
    public InstituicaoBeans getInstituicao(long codInstituicao){
        InstituicaoDAOImpl idaoi = new InstituicaoDAOImpl();
        idaoi.setSessionFactory(HibernateUtil.getSessionFactory());
        InstituicaoBeans instituicao = (InstituicaoBeans) new InstituicaoBeans().toBeans(idaoi.getInstituicao(codInstituicao));
        return instituicao;
    }
    
    public UsuarioBeans atualizaInstituicao(UsuarioBeans ub, InstituicaoBeans atual, InstituicaoBeans nova){
        if(atual != null){
            if(!(atual.getCodInstituicao()== nova.getCodInstituicao())){
                InstituicaoDAOImpl idaoi = new InstituicaoDAOImpl();
                idaoi.setSessionFactory(HibernateUtil.getSessionFactory());
                atual.getAssociados().remove(ub);
                nova.getAssociados().add(ub);
                MatriculaDAOImpl mdaoi = new MatriculaDAOImpl();
                mdaoi.setSessionFactory(HibernateUtil.getSessionFactory());
                mdaoi.removeMatricula((Matricula) ub.getMatricula().toBusiness());
                ub.setMatricula(null);
                UsuarioDAOImpl udaoi = new UsuarioDAOImpl();
                udaoi.setSessionFactory(HibernateUtil.getSessionFactory());
                udaoi.atualizarUsuario((Usuario) ub.toBusiness());
                idaoi.atualizarInstituicao((Instituicao) atual.toBusiness());
                idaoi.atualizarInstituicao((Instituicao) nova.toBusiness());
            }
        }else{
            InstituicaoDAOImpl idaoi = new InstituicaoDAOImpl();
            idaoi.setSessionFactory(HibernateUtil.getSessionFactory());
            nova.getAssociados().add(ub);
            idaoi.atualizarInstituicao((Instituicao) nova.toBusiness());
        }
        return ub;
    }
    
    public UsuarioBeans getUsuario(long codUsuario){
        UsuarioDAOImpl udaoi = new UsuarioDAOImpl();
        return (UsuarioBeans) new UsuarioBeans().toBeans(udaoi.getUsuario(codUsuario));
    }
    
    public List<AtividadeBeans> getAtividades(){
        AtividadeDAOImpl adaoi = new AtividadeDAOImpl();
        List<Atividade> as =  Collections.synchronizedList(adaoi.listaAtividades());
        List<AtividadeBeans> ab = Collections.synchronizedList(new ArrayList<>());
        for(int i=0;i<as.size();i++){
            ab.add((AtividadeBeans) new AtividadeBeans().toBeans(as.get(i)));
        }
        return ab;
    }
    
}
