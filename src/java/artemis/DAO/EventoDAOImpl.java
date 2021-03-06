/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.DAO;

import artemis.model.Evento;
import hibernate.HibernateUtil;
import java.util.Collections;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

/**
 *
 * @author Wallison
 */
public class EventoDAOImpl implements EventoDAO {
    private SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
    
    public void setSessionFactory(SessionFactory sessionFactory){
        if(sessionFactory != null)
            this.sessionFactory = sessionFactory;
        else
            throw new NullPointerException("Argumento de sessão nulo!");
    }

    @Override
    public Evento adicionarEvento(Evento evento) {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        if(evento != null){
            session.persist(evento);
            t.commit();
        }else{
            throw new NullPointerException("Evento nulo não pode ser salvo!");
        }
        session.close();
        return evento;
    }

    @Override
    public void atualizarEvento(Evento evento) {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        if(evento != null){
            session.update(evento);
            t.commit();
        }else{
            throw new NullPointerException("Evento nulo não pode ser atualizado!");
        }
        session.close();
    }


    @Override
    @SuppressWarnings("unchecked")
    public List<Evento> listaEventos() {
        Session session = this.sessionFactory.getCurrentSession();
        List<Evento> eventos = Collections.synchronizedList(session.createCriteria(Evento.class).list());
        return eventos;
    }

    @Override
    public void removerEvento(Evento evento) {
        Session session = this.sessionFactory.openSession();
        if(evento != null){
            session.delete(evento);
        }else{
            throw new NullPointerException("Evento não pode ser nulo!");
        }
    }

    @Override
    public Evento getEvento(long codEvento) {
        Session session = this.sessionFactory.openSession();
        Evento evento = (Evento) session.get(Evento.class, codEvento);
        return evento;        
    }
        
    @Override
    public List<Evento> getPrimeirosEventos(int n){
        Session session = this.sessionFactory.openSession();
        Criteria crit = session.createCriteria(Evento.class, "evento");
        crit.setFirstResult(0);
        crit.setMaxResults(n);
        return crit.list();
    }
    
}
