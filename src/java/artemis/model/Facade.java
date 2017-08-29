/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.model;

import artemis.DAO.AtividadeDAOImpl;
import artemis.DAO.ContaAtivacaoDAOImpl;
import artemis.DAO.ContasSociaisDAOImpl;
import artemis.DAO.EventoDAOImpl;
import artemis.DAO.InscricaoDAOImpl;
import artemis.DAO.InstituicaoDAOImpl;
import artemis.DAO.MatriculaDAOImpl;
import artemis.DAO.UsuarioDAOImpl;
import artemis.beans.*;
import artemis.service.Sign;
import hibernate.HibernateUtil;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
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
    
    public UsuarioBeans adicionaNivelUsuario(UsuarioBeans u, String nivel) throws IllegalAccessException{
        UsuarioProxy up = new UsuarioProxy((Usuario)usuario.toBusiness());
        return (UsuarioBeans) new UsuarioBeans().toBeans(up.adicionaNivelUsuario((Usuario) u.toBusiness(), nivel));
    }
    
    public UsuarioBeans removeNivelUsuario(UsuarioBeans u, String nivel) throws IllegalAccessException{
        UsuarioProxy up = new UsuarioProxy((Usuario)usuario.toBusiness());
        return (UsuarioBeans) new UsuarioBeans().toBeans(up.removeNivelUsuario((Usuario) u.toBusiness(), nivel));
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
    
    public AtividadeBeans getAtividade(long codAtividade){
        AtividadeDAOImpl dao = new AtividadeDAOImpl();
        return (AtividadeBeans) new AtividadeBeans().toBeans(dao.getAtividade(codAtividade));
    }
    
    public void recuperaSenha(String c) throws EmailException, Exception{
        UsuarioDAOImpl dao = new  UsuarioDAOImpl();
        CPF cpf = new CPF(c);
        Usuario usuario = null;
        List<Usuario> usuarios = dao.listaUsuarios();
        for(int i=0;i<usuarios.size();i++){
            Usuario u = usuarios.get(i);
            if(u.getCpf().getFormatedCpf().equals(cpf.getFormatedCpf())){
                usuario = u;
            }
        }
        if(usuario != null){
            Sign sign = new Sign(usuario);
            sign.recuperaSenha();
        }else
            throw new NullPointerException("Não exite usuário cadastrado com esse e-mail!");
    }
    
    public String getAtividadesEventosJSON(EventoBeans evento){
        String data = "";
        for(int i=0;i<evento.getAtividades().size();i++){
            AtividadeBeans atividade = evento.getAtividades().get(i);
            for(int j=0;j<atividade.getPeriodoBeanses().size();j++){
                PeriodoBeans periodo = atividade.getPeriodoBeanses().get(j);
                data += "{title: \'"+atividade.getNome()+"\', start: \'"+periodo.getInicio().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME)+"\', "
                        + "end: \'"+periodo.getTermino().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME)+"\',"+
                        "backgroundColor: \'#00a65a\',"+ 
                        "borderColor: \'#00a65a\'}";
                if(j+1<atividade.getPeriodoBeanses().size()){
                    data += ",";
                }
            }
            if(i+1<evento.getAtividades().size()){
                data += ",";
            }
        }
        if(evento.getEventos().size()>0){
            data += ",";
        }
        for(int i=0;i<evento.getEventos().size();i++){
            EventoBeans e = evento.getEventos().get(i);
            for(int j=0;j<e.getPeriodos().size();j++){
                PeriodoBeans periodo = e.getPeriodos().get(j);
                data += "{title: \'"+e.getNome()+"\', start: \'"+periodo.getInicio().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME)+"\', "
                        + "end: \'"+periodo.getTermino().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME)+"\',"+
                        "backgroundColor: \'#0073b7\',"+ 
                        "borderColor: \'#0073b7\'}";
                if(j+1<e.getPeriodos().size()){
                    data += ",";
                }
            }
        }
        return data;
    }
    
    public List<UsuarioBeans> getMinistrantes(EventoBeans e){
        List<AtividadeBeans> atividades = e.getAtividades();
        List<UsuarioBeans> ministrantes = Collections.synchronizedList(new ArrayList<>());
        for(int i=0;i<atividades.size();i++){
            AtividadeBeans a = atividades.get(i);
            UsuarioBeans u = a.getMinistrante();
            if(u != null && !ministrantes.contains(u)){
                ministrantes.add(u);
            }
        }
        return ministrantes;
    }
    public ContasSociaisBeans adicionaContasSociais(ContasSociaisBeans contas){
        ContasSociaisDAOImpl dao = new ContasSociaisDAOImpl();
        ContasSociais contasSociais = (ContasSociais) contas.toBusiness();
        return (ContasSociaisBeans) new ContasSociaisBeans().toBeans(dao.adicionarContasSociais(contasSociais));
    }
    public void enviarEmailEvento(EventoBeans e, String assunto, String messagem, String emailDe, String nome) throws EmailException{
        Email email = new Email(assunto, emailDe+", \n"+messagem, e.getEmail(), nome);
        Evento evento = (Evento) e.toBusiness();
        evento.enviaEmailContato(email);
    }
    
    public PeriodoBeans getMenorPeriodo(EventoBeans evento){
        Evento e = (Evento) evento.toBusiness();
        return (PeriodoBeans) new PeriodoBeans().toBeans(e.getMenorPeriodo());
    }    
    public InscricaoBeans getInscricao(long codInscricao){
        InscricaoDAOImpl idao = new InscricaoDAOImpl();
        return (InscricaoBeans) new InscricaoBeans().toBeans(idao.getInscricao(codInscricao));
    }
    
    public InscricaoBeans fazerInscricaoEvento(EventoBeans evento, InscricaoBeans inscricao) throws IllegalAccessException{
        Evento e = (Evento) evento.toBusiness();
        return (InscricaoBeans) new InscricaoBeans().toBeans(e.criaInscricao((Inscricao) inscricao.toBusiness()));
    }
    
    public void removerInscricaoEvento(EventoBeans evento, InscricaoBeans inscricao) throws IllegalAccessException{
        Evento e = (Evento) evento.toBusiness();
        e.removeInscricao((Inscricao) inscricao.toBusiness(), (Usuario) usuario.toBusiness());
    }
    
    public InscricaoBeans fazerInscricaoAtividade(AtividadeBeans atividade, InscricaoBeans inscricao) throws IllegalAccessException{
        Atividade a = (Atividade) atividade.toBusiness();
        return (InscricaoBeans) new InscricaoBeans().toBeans(a.criaInscricao((Inscricao) inscricao.toBusiness()));
    }
    
    public void removerInscricaoAtividade(AtividadeBeans atividade, InscricaoBeans inscricao) throws IllegalAccessException{
        Atividade a = (Atividade) atividade.toBusiness();
        a.removeInscricao((Inscricao) inscricao.toBusiness(), (Usuario) usuario.toBusiness());
    }
    
    public List<List> buscar(String texto){
        texto = texto.replace("<", "").replace(">", "")
                .replace("\'", "").replace("\"", "")
                .replace("=", "");
        List<List> result = Collections.synchronizedList(new ArrayList<List>());
        result.add(buscarUsuarios(texto));
        result.add(buscarAtividade(texto));
        result.add(buscarEventos(texto));
        return result;
    }
    public List<UsuarioBeans> buscarUsuarios(String texto){
        UsuarioDAOImpl udao = new UsuarioDAOImpl();
        List<UsuarioBeans> ubs = Collections.synchronizedList(new ArrayList<UsuarioBeans>());
        List<Usuario> usuarios = udao.buscaUsuarios(texto);
        for(int i=0;i<usuarios.size();i++){
            ubs.add((UsuarioBeans)new UsuarioBeans().toBeans(usuarios.get(i)));
        }
        return ubs;
    }
    public List<EventoBeans> buscarEventos(String texto){
        EventoDAOImpl edao = new EventoDAOImpl();
        List<EventoBeans> ebs = Collections.synchronizedList(new ArrayList<EventoBeans>());
        List<Evento> eventos = edao.buscaEvento(texto);
        for(Evento evt : eventos){
            ebs.add((EventoBeans)new EventoBeans().toBeans(evt));
        }
        return ebs;
    }
    public List<AtividadeBeans> buscarAtividade(String texto){
        AtividadeDAOImpl adao = new AtividadeDAOImpl();
        List<AtividadeBeans> abs = Collections.synchronizedList(new ArrayList<AtividadeBeans>());
        List<Atividade> atividades = adao.buscaAtividade(texto);
        for(Atividade atv : atividades){
            abs.add((AtividadeBeans)new AtividadeBeans().toBeans(atv));
        }
        return abs;
    }
    
    
    
    
}
