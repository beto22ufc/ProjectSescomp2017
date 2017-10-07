/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.DAO;

import artemis.model.Atividade;
import artemis.model.Evento;
import artemis.model.Inscricao;
import artemis.model.Usuario;
import hibernate.HibernateUtil;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import org.hibernate.sql.JoinType;

/**
 *
 * @author Wallison
 */
public class InscricaoDAOImpl implements InscricaoDAO{
    SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
    
    public void setSessionFactory(SessionFactory sessionFactory){
        if(sessionFactory != null){
            this.sessionFactory = sessionFactory;
        }else{
            throw new NullPointerException("Argumento de sessão não pode ser nulo!");
        }
    }
    
    @Override
    public Inscricao adicionarInscricao(Inscricao inscricao) {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        if(inscricao != null){
            session.persist(inscricao);
            t.commit();
            session.close();
            return inscricao;
        }else{
            throw new NullPointerException("Inscrição não pode ser nula!");
        }
    }

    @Override
    public void atualizarInscricao(Inscricao inscricao) {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        if(inscricao != null){
            session.update(inscricao);
            t.commit();
        }else{
            throw new NullPointerException("Inscrição não pode ser nula!");
        }
        session.close();
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Inscricao> listaInscricoes() {
        Session session = this.sessionFactory.getCurrentSession();
        List<Inscricao> inscricoes = Collections.synchronizedList(session.createQuery("from inscricao").list());
        return inscricoes;
    }

    @Override
    public void removerInscricao(Inscricao inscricao) {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        if(inscricao != null){
            session.delete(inscricao);
            t.commit();
        }else{
            throw new NullPointerException("Inscrição não pode ser nula");
        }
        session.close();
    }

    @Override
    public Inscricao getInscricao(long codInscricao) {
        Session session = this.sessionFactory.getCurrentSession();
        Inscricao inscricao = (Inscricao) session.get(Inscricao.class, codInscricao);
        return inscricao;
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Evento>listaInscricoesEventos(Usuario participante) {
        Session session = this.sessionFactory.openSession();
        Criteria crit = session.createCriteria(Evento.class, "e")
                .createAlias("e.inscricoes","ie", JoinType.INNER_JOIN)
                .createAlias("ie.participante", "p", JoinType.INNER_JOIN)
                .add(Restrictions.eq("p.codUsuario", participante.getCodUsuario()));
        List<Evento> results = crit.list();    
        return results;
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Atividade> listaInscricoesAtividades(Usuario participante) {
       Session session = this.sessionFactory.openSession();
        Criteria crit = session.createCriteria(Atividade.class, "a")
                .createAlias("a.inscricaoAtividades","ia", JoinType.INNER_JOIN)
                .createAlias("ia.participante", "p", JoinType.INNER_JOIN)
                .add(Restrictions.eq("p.codUsuario", participante.getCodUsuario()));
        List<Atividade> results = crit.list();
        return results;
    }
        
}
