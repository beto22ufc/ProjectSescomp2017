/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.model;

import artemis.DAO.AtividadeDAOImpl;
import artemis.DAO.ContaAtivacaoDAOImpl;
import artemis.DAO.ContasSociaisDAOImpl;
import artemis.DAO.CursoDAOImpl;
import artemis.DAO.EventoDAOImpl;
import artemis.DAO.ImagemDAOImpl;
import artemis.DAO.InscricaoDAOImpl;
import artemis.DAO.InstituicaoDAOImpl;
import artemis.DAO.LocalizacaoDAOImpl;
import artemis.DAO.MatriculaDAOImpl;
import artemis.DAO.PeriodoDAOImpl;
import artemis.DAO.UsuarioDAOImpl;
import artemis.beans.*;
import artemis.service.Sign;
import hibernate.HibernateUtil;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import org.apache.commons.mail.EmailException;
import org.jdom2.JDOMException;

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
    
    public void fazerCadastro(UsuarioBeans ub) throws EmailException, IOException{
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
                            + Constantes.URL+"/"+Constantes.DIR+"/validarConta?cv="+ca.getCodigo()+""
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
            if(conta.getCodigo().replace(" ","").equalsIgnoreCase(cod.replace(" ", ""))){
                codExiste = true;
                UsuarioDAOImpl udaoi = new UsuarioDAOImpl();
                udaoi.setSessionFactory(HibernateUtil.getSessionFactory());
                if(conta.getValidade().isBefore(LocalDateTime.now())){
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
                            + Constantes.URL+"/"+Constantes.DIR+"/validarConta?cv="+conta.getCodigo()+""
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
    
    public void removePeriodoAtividade(AtividadeBeans atividade, PeriodoBeans periodo) throws IllegalAccessException{
        Atividade a = (Atividade) atividade.toBusiness();
        AtividadeProxy ap = new AtividadeProxy((Usuario) usuario.toBusiness());
        ap.removePeriodo(a, (Periodo) periodo.toBusiness());
    }
    
    public void removePeriodoEvento(EventoBeans evento, PeriodoBeans periodo) throws IllegalAccessException, EmailException{
        Evento e = (Evento) evento.toBusiness();
        EventoProxy ep = new EventoProxy((Usuario) usuario.toBusiness());
        ep.removePeriodo(e, (Periodo) periodo.toBusiness());
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
    
    public String getAtividadesEventosUsuarioJSON(UsuarioBeans usuario){
        String data = "";
        InscricaoDAOImpl idao = new InscricaoDAOImpl();
        List<Atividade> atividades = idao.listaInscricoesAtividades((Usuario)usuario.toBusiness());
        List<Evento> eventos = idao.listaInscricoesEventos((Usuario)usuario.toBusiness());
        for(int i=0;i<atividades.size();i++){
            Atividade atividade = atividades.get(i);
            for(int j=0;j<atividade.getPeriodos().size();j++){
                Periodo periodo = atividade.getPeriodos().get(j);
                data += "{title: \'"+atividade.getNome()+"\', start: \'"+periodo.getInicio().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME)+"\', "
                        + "end: \'"+periodo.getTermino().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME)+"\',"+
                        "backgroundColor: \'#00a65a\',"+ 
                        "borderColor: \'#00a65a\'}";
                if(j+1<atividade.getPeriodos().size()){
                    data += ",";
                }
            }
            if(i+1<eventos.size()){
                data += ",";
            }
        }
        if(eventos.size()>0){
            data += ",";
        }
        for(int i=0;i<eventos.size();i++){
            Evento e = eventos.get(i);
            for(int j=0;j<e.getPeriodos().size();j++){
                Periodo periodo = e.getPeriodos().get(j);
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
    
    public PeriodoBeans getMenorPeriodo(EventoBeans evento){
        Evento e = (Evento) evento.toBusiness();
        return (PeriodoBeans) new PeriodoBeans().toBeans(e.getMenorPeriodo());
    }

    public PeriodoBeans getMenorPeriodo(AtividadeBeans atividade){
        Atividade a = (Atividade) atividade.toBusiness();
        return (PeriodoBeans) new PeriodoBeans().toBeans(a.getMenorPeriodo());
    }
    
    public PeriodoBeans getMaiorPeriodo(EventoBeans evento){
        Evento e = (Evento) evento.toBusiness();
        return (PeriodoBeans) new PeriodoBeans().toBeans(e.getMaiorPeriodo());
    }

    public PeriodoBeans getMaiorPeriodo(AtividadeBeans atividade){
        Atividade a = (Atividade) atividade.toBusiness();
        return (PeriodoBeans) new PeriodoBeans().toBeans(a.getMaiorPeriodo());
    }
    
    public InscricaoBeans getInscricao(long codInscricao){
        InscricaoDAOImpl idao = new InscricaoDAOImpl();
        return (InscricaoBeans) new InscricaoBeans().toBeans(idao.getInscricao(codInscricao));
    }
    
    public PeriodoBeans getPeriodo(long codPeriodo){
        PeriodoDAOImpl pdao = new PeriodoDAOImpl();
        return (PeriodoBeans) new PeriodoBeans().toBeans(pdao.getPeriodo(codPeriodo));
    }
    
    public InscricaoBeans fazerInscricaoEvento(EventoBeans evento, InscricaoBeans inscricao) throws IllegalAccessException{
        Evento e = (Evento) evento.toBusiness();
        return (InscricaoBeans) new InscricaoBeans().toBeans(e.criaInscricao((Inscricao) inscricao.toBusiness()));
    }
    public InscricaoBeans fazerInscricaoAtividade(AtividadeBeans atividade, InscricaoBeans inscricao) throws IllegalAccessException{
        Atividade a = (Atividade) atividade.toBusiness();
        return (InscricaoBeans) new InscricaoBeans().toBeans(a.criaInscricao((Inscricao) inscricao.toBusiness()));
    }
    
    public void removerInscricaoEvento(EventoBeans evento, InscricaoBeans inscricao) throws IllegalAccessException{
        Evento e = (Evento) evento.toBusiness();
        e.removeInscricao((Inscricao) inscricao.toBusiness(), (Usuario) usuario.toBusiness());
    }
   
    public void removerInscricaoAtividade(AtividadeBeans atividade, InscricaoBeans inscricao) throws IllegalAccessException{
        Atividade a = (Atividade) atividade.toBusiness();
        a.removeInscricao((Inscricao) inscricao.toBusiness(), (Usuario) usuario.toBusiness());
    }
    
    public int quantidadeDeInscritosInternosAtividade(AtividadeBeans atividade){
        Atividade a = (Atividade) atividade.toBusiness();
        return a.inscritosInternos();
    }
    
    public void criarInstituicao(InstituicaoBeans instituicao) throws IllegalAccessException{
        //if(this.usuario.getTipo().contains("adminGeral")){
            InstituicaoDAOImpl idao = new InstituicaoDAOImpl();
            idao.adicionarInstituicao((Instituicao) instituicao.toBusiness());
        /*}else{
            throw new IllegalAccessException("Acesso negado!");
        }*/
    }
    
    public List<InstituicaoBeans> listaDeInstituicoes(){
        InstituicaoDAOImpl idao = new InstituicaoDAOImpl();
        List<Instituicao> instituicoes =  idao.listaInstituicoes();
        List<InstituicaoBeans> ibs = Collections.synchronizedList(new ArrayList<InstituicaoBeans>());
        for(int i=0;i<instituicoes.size();i++){
            ibs.add((InstituicaoBeans) new InstituicaoBeans().toBeans(instituicoes.get(i)));
        }
        return ibs;
    }
    
    public InstituicaoBeans getInstituicao(EventoBeans evento){
        InstituicaoDAOImpl idao = new InstituicaoDAOImpl();
        List<Instituicao> instituicoes =  idao.listaInstituicoes();
        InstituicaoBeans instituicao = null;
        List<InstituicaoBeans> ibs = Collections.synchronizedList(new ArrayList<InstituicaoBeans>());
        for(int i=0;i<instituicoes.size();i++){
            ibs.add((InstituicaoBeans) new InstituicaoBeans().toBeans(instituicoes.get(i)));
        }
        for(int i=0;i<ibs.size();i++){
            InstituicaoBeans ins = ibs.get(i);
            boolean encontrada = false;
            for(int j=0;j<ins.getEventos().size();j++){
                EventoBeans e = ins.getEventos().get(j);
                encontrada = e.getCodEvento() == evento.getCodEvento();
                if(encontrada){
                    break;
                }
            }
            if(encontrada){
                instituicao = ins;
                break;
            }
        }
        return instituicao;
    }
    
    public InstituicaoBeans getInstituicao(AtividadeBeans atividade){
        InstituicaoDAOImpl idao = new InstituicaoDAOImpl();
        List<Instituicao> instituicoes =  idao.listaInstituicoes();
        InstituicaoBeans instituicao = null;
        List<InstituicaoBeans> ibs = Collections.synchronizedList(new ArrayList<InstituicaoBeans>());
        for(int i=0;i<instituicoes.size();i++){
            ibs.add((InstituicaoBeans) new InstituicaoBeans().toBeans(instituicoes.get(i)));
        }
        for(int i=0;i<ibs.size();i++){
            InstituicaoBeans ins = ibs.get(i);
            boolean encontrada = false;
            for(int j=0;j<ins.getAtividades().size();j++){
                AtividadeBeans a = ins.getAtividades().get(j);
                encontrada = a.getCodAtividade()== atividade.getCodAtividade();
                if(encontrada){
                    break;
                }
            }
            if(encontrada){
                instituicao = ins;
                break;
            }
        }
        return instituicao;
    }
    
    public InstituicaoBeans getInstituicao(UsuarioBeans usuario){
        InstituicaoDAOImpl idao = new InstituicaoDAOImpl();
        List<Instituicao> instituicoes =  idao.listaInstituicoes();
        InstituicaoBeans instituicao = null;
        List<InstituicaoBeans> ibs = Collections.synchronizedList(new ArrayList<InstituicaoBeans>());
        for(int i=0;i<instituicoes.size();i++){
            ibs.add((InstituicaoBeans) new InstituicaoBeans().toBeans(instituicoes.get(i)));
        }
        for(int i=0;i<ibs.size();i++){
            InstituicaoBeans ins = ibs.get(i);
            boolean encontrada = false;
            for(int j=0;j<ins.getAssociados().size();j++){
                UsuarioBeans u = ins.getAssociados().get(j);
                encontrada = u.equals(usuario);
                if(encontrada){
                    break;
                }
            }
            if(encontrada){
                instituicao = ins;
                break;
            }
        }
        return instituicao;
    }
    
   public void atualizaInstituicao(InstituicaoBeans instituicao){
       InstituicaoDAOImpl idao = new InstituicaoDAOImpl();
       idao.atualizarInstituicao((Instituicao) instituicao.toBusiness());
   }
   
   public CursoBeans getCurso(long codCurso){
       CursoDAOImpl cdao = new CursoDAOImpl();
       return (CursoBeans) new CursoBeans().toBeans(cdao.getCurso(codCurso));
   }
   
   public EventoBeans getEventoVinculado(AtividadeBeans atividade){
       EventoDAOImpl edao = new EventoDAOImpl();
       List<Evento> eventos = edao.listaEventos();
       EventoBeans vinculado = null;
       for(Evento evento : eventos){
           for(Atividade a : evento.getAtividades()){
               if(a.getCodAtividade() == atividade.getCodAtividade()){
                   vinculado = (EventoBeans) new EventoBeans().toBeans(evento);
                   break;
               }
           }
           if(vinculado!=null){
               break;
           }
       }
       return vinculado;
   }
   
   public EventoBeans getEventoVinculado(EventoBeans evento){
       EventoDAOImpl edao = new EventoDAOImpl();
       List<Evento> eventos = edao.listaEventos();
       EventoBeans vinculado = null;
       for(Evento e : eventos){
           for(Evento event : e.getEventos()){
               if(event.getCodEvento() == evento.getCodEvento()){
                   vinculado = (EventoBeans) new EventoBeans().toBeans(evento);
                   break;
               }
           }
           if(vinculado!=null){
               break;
           }
       }
       return vinculado;
   }
   
   public List<EventoBeans> getInscricoesEvento(UsuarioBeans participante){
       InscricaoDAOImpl idao = new InscricaoDAOImpl();
       List<Evento> result = idao.listaInscricoesEventos((Usuario) participante.toBusiness());
       List<EventoBeans> eventos = Collections.synchronizedList(new ArrayList<EventoBeans>());
       Inscricao inscricao = new Inscricao();
       inscricao.setParticipante((Usuario) participante.toBusiness());
       InscricaoPredicate<Inscricao> predicate = new InscricaoPredicate<>(inscricao);
       for(int i=0;i<result.size();i++){
           result.get(i).getInscricoes().removeIf(predicate);
           eventos.add((EventoBeans) new EventoBeans().toBeans(result.get(i)));
       }
       return eventos;
   }
   
   public List<AtividadeBeans> getInscricoesAtividade(UsuarioBeans participante){
       InscricaoDAOImpl idao = new InscricaoDAOImpl();
       List<Atividade> result = idao.listaInscricoesAtividades((Usuario) participante.toBusiness());
       List<AtividadeBeans> atividades = Collections.synchronizedList(new ArrayList<AtividadeBeans>());
       Inscricao inscricao = new Inscricao();
       inscricao.setParticipante((Usuario) participante.toBusiness());
       InscricaoPredicate<Inscricao> predicate = new InscricaoPredicate<>(inscricao);
       for(int i=0;i<result.size();i++){
           result.get(i).getInscricaoAtividades().removeIf(predicate);
           atividades.add((AtividadeBeans) new AtividadeBeans().toBeans(result.get(i)));
       }
       return atividades;
   }
   
   public float getParticipacao(EventoBeans evento, UsuarioBeans participante){
       Evento e = (Evento) evento.toBusiness();
       return e.getParticipacao((Usuario) participante.toBusiness());
   }
   public ImagemBeans getImagem(long codImagem){
       ImagemDAOImpl idao = new ImagemDAOImpl();
       return (ImagemBeans) new ImagemBeans().toBeans(idao.getImagem(codImagem));
   }
   public void atualizaImagem(ImagemBeans imagem){
       ImagemDAOImpl idao = new ImagemDAOImpl();
       Imagem i = (Imagem) imagem.toBusiness();
       idao.atualizarImagem(i);
   }
   
   public void removeImagemGaleria(EventoBeans evento, ImagemBeans imagem) throws IllegalAccessException{
       Evento e = (Evento) evento.toBusiness();
       EventoProxy ep = new EventoProxy((Usuario)usuario.toBusiness());
       ep.removeImagemGaleria(e, (Imagem) imagem.toBusiness());
   }
   
   public void removeImagemSlideshow(EventoBeans evento, ImagemBeans imagem) throws IllegalAccessException{
       Evento e = (Evento) evento.toBusiness();
       EventoProxy ep = new EventoProxy((Usuario)usuario.toBusiness());
       ep.removeImagemSlideshow(e, (Imagem) imagem.toBusiness());
   }
   
   public void removeInstituicao(InstituicaoBeans instituicao) throws IllegalAccessException{
       UsuarioProxy up = new UsuarioProxy((Usuario) usuario.toBusiness());
       up.removeInstituicao((Instituicao) instituicao.toBusiness());
   }
   
   public void removeCurso(InstituicaoBeans instituicao, CursoBeans curso) throws IllegalAccessException{
       InstituicaoProxy ip = new InstituicaoProxy((Usuario) usuario.toBusiness());
       ip.removeCurso((Instituicao)instituicao.toBusiness(), (Curso) curso.toBusiness());
   }
   
   public void atualizaCurso(CursoBeans curso) throws IllegalAccessException{
       CursoProxy cp = new CursoProxy((Usuario) usuario.toBusiness());
       cp.atualizaCurso((Curso) curso.toBusiness());
   }
   
   public void marcaPresencaInscricaoAtividade(AtividadeBeans atividade, InscricaoBeans inscricao) throws IllegalAccessException{
       UsuarioProxy up = new UsuarioProxy((Usuario)usuario.toBusiness());
       up.marcaPresencaInscricao((Atividade)atividade.toBusiness(), (Inscricao) inscricao.toBusiness());
   }
   public void validaInscricaoAtividade(AtividadeBeans atividade, InscricaoBeans inscricao) throws IllegalAccessException{
       UsuarioProxy up = new UsuarioProxy((Usuario)usuario.toBusiness());
       up.validaInscricao((Atividade)atividade.toBusiness(), (Inscricao) inscricao.toBusiness());
   }
   
   public void marcaPresencaInscricaoEvento(EventoBeans evento, InscricaoBeans inscricao) throws IllegalAccessException{
       UsuarioProxy up = new UsuarioProxy((Usuario)usuario.toBusiness());
       up.marcaPresencaInscricao((Evento)evento.toBusiness(), (Inscricao) inscricao.toBusiness());
   }
   
   public void validaInscricaoEvento(EventoBeans evento, InscricaoBeans inscricao) throws IllegalAccessException{
       UsuarioProxy up = new UsuarioProxy((Usuario)usuario.toBusiness());
       up.validaInscricao((Evento)evento.toBusiness(), (Inscricao) inscricao.toBusiness());
   }
   
   public int inscritosInternos(AtividadeBeans atividade){
       Atividade a = (Atividade) atividade.toBusiness();
       return a.inscritosInternos();
   }
   
   public int inscritosExternos(AtividadeBeans atividade){
       Atividade a = (Atividade) atividade.toBusiness();
       return a.inscritosExternos();
   }
   
   public void removeEvento(EventoBeans evento) throws IllegalAccessException, EmailException{
       EventoProxy ep = new EventoProxy((Usuario) usuario.toBusiness());
       ep.removeEvento((Evento) evento.toBusiness());
   }
   
   public void removeAtividade(EventoBeans evento, AtividadeBeans atividade) throws IllegalAccessException, EmailException{
       EventoProxy ep = new EventoProxy((Usuario) usuario.toBusiness());
       Evento e = null;
       if(evento!=null){
           e = (Evento) evento.toBusiness();
       }
       ep.removeAtividade(e, (Atividade) atividade.toBusiness());
   }
   
   public List<String> getTemas() throws IOException, JDOMException, JDOMException{
       return Tema.getTemas();
   }
   
   public TemaBeans getTema(String nome) throws IOException, JDOMException{
       Tema tema = Tema.getTema(nome);
       return (TemaBeans) new TemaBeans().toBeans(tema);
   }

   public MatriculaBeans adicionaMatricula(MatriculaBeans matricula){
       MatriculaDAOImpl mdao = new MatriculaDAOImpl();
       return (MatriculaBeans) new MatriculaBeans().toBeans(mdao.adicionarMatricula((Matricula) matricula.toBusiness()));
   }
   
   public void enviaEmailContatoEvento(EventoBeans evento, String[] mail) throws EmailException{
       Evento e = (Evento) evento.toBusiness();
       e.enviaEmailContato(mail[0], mail[1], mail[2], mail[3], mail[4]);
   }
   
   public LocalizacaoBeans adicionaLocalizacao(LocalizacaoBeans localizacao){
       LocalizacaoDAOImpl ldao = new LocalizacaoDAOImpl();
       return (LocalizacaoBeans) new LocalizacaoBeans().toBeans(ldao.adicionarLocalizacao((Localizacao) localizacao.toBusiness()));
   }
   
   public void enviarEmailUsuario(UsuarioBeans usuario, String[] mail) throws EmailException{
       Email email = new Email(mail[0], "Nome: "+mail[2]+"\n E-mail: "+mail[3]+"\n Menssagem: "+mail[1], usuario.getEmail(), mail[2]);
       email.sendEmail();
   }
   
   public String getUsuarioForQRCode(UsuarioBeans usuario) throws IOException{
       Crip crip = new Crip("s3r14l724bl3U53rTeteh");
       return crip.enc(usuario.getCodUsuario()+"");
   }
   
   public UsuarioBeans getQRCodeForUsuario(String qrcode){
       Crip crip = new Crip("s3r14l724bl3U53rTeteh");
       return this.getUsuario(Long.parseLong(crip.dec(qrcode)));
   }
   
   public List<EventoBeans> getPrimeirosEventos(){
        EventoDAOImpl edao = new EventoDAOImpl();
        List<EventoBeans> ebs = Collections.synchronizedList(new ArrayList<EventoBeans>());
        List<Evento> eventos = edao.listaEventos();
        EventoBeans evento = null;
        Evento evt = null;
        if(eventos.size()>0){
            evt = eventos.get(0);
            for(int i=0;i<6;i++){
                for(Evento e : eventos){
                    if(evt.getMenorPeriodo().getInicio().isAfter(e.getMenorPeriodo().getInicio())){
                        evt = e;
                    }
                }
                ebs.add((EventoBeans) new EventoBeans().toBeans(evt));
                eventos.remove(evt);
                if(eventos.size()>0){
                    evt = eventos.get(0);
                }else{
                    break;
                }
            }
        }
        return ebs;
    }
   
   public int getInscritosAtividadeEvento(EventoBeans evento){
       int count =0;
       count = evento.getAtividades().stream().map((atividade) -> atividade.getInscricoes().size()).reduce(count, Integer::sum);
       return count;
   }
}
