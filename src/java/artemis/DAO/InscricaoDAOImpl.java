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
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
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
        Session session = this.sessionFactory.getCurrentSession();
        Transaction t = session.beginTransaction();
        if(inscricao != null){
            session.persist(inscricao);
            t.commit();
            return inscricao;
        }else{
            t.rollback();
            throw new NullPointerException("Inscrição não pode ser nula!");
        }
    }

    @Override
    public void atualizarInscricao(Inscricao inscricao) {
        Session session = this.sessionFactory.getCurrentSession();
        Transaction t = session.beginTransaction();
        if(inscricao != null){
            session.update(inscricao);
            t.commit();
        }else{
            t.rollback();
            throw new NullPointerException("Inscrição não pode ser nula!");
        }
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Inscricao> listaInscricoes() {
        Session session = this.sessionFactory.getCurrentSession();
        Transaction t = session.beginTransaction();
        List<Inscricao> inscricoes = Collections.synchronizedList(session.createQuery("from inscricao").list());
        t.commit();
        return inscricoes;
    }

    @Override
    public void removerInscricao(Inscricao inscricao) {
        Session session = this.sessionFactory.getCurrentSession();
        Transaction t = session.beginTransaction();
        if(inscricao != null){
            session.delete(inscricao);
            t.commit();
        }else{
            t.rollback();
            throw new NullPointerException("Inscrição não pode ser nula");
        }
    }

    @Override
    public Inscricao getInscricao(long codInscricao) {
        Session session = this.sessionFactory.getCurrentSession();
        Transaction t = session.beginTransaction();
        Inscricao inscricao = (Inscricao) session.get(Inscricao.class, codInscricao);
        t.commit();
        return inscricao;
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Evento> listaInscricoesEventos(Usuario participante) {
        Session session = this.sessionFactory.getCurrentSession();
        Transaction t = session.beginTransaction();
        Criteria crit = session.createCriteria(Evento.class).createAlias("inscricao","i").createAlias("evento","e")
            .createAlias("usuario", "u").createAlias("inscricoes_evento", "ie")
            .add(Restrictions.conjuction(Restrictions.eqProperty("i.participante", participante.getCodUsuario()))
            .add(Restrictions.conjuction(Restrictions.eqProperty("ie.evento","e.codEvento")))
            .add(Restrictions.conjuction(Restrictions.eqProperty("i.codInscricao","ie.inscricao")));
         
        List results = crit.list();
    
        return results;
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Atividade> listaInscricoesAtividades(Usuario participante) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
        
}
