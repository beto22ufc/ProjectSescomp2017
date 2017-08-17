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
        try{
            if(evento != null){
                session.persist(evento);
            }else{
                throw new NullPointerException("Evento nulo não pode ser salvo!");
            }
            t.commit();
            return evento;
        }catch(RuntimeException e){
            t.rollback();
            throw e;
        }
    }

    @Override
    public void atualizarEvento(Evento evento) {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        try{
            if(evento != null){
                session.update(evento);
            }else{
                throw new NullPointerException("Evento nulo não pode ser atualizado!");
            }
            t.commit();
        }catch(RuntimeException e){
            t.rollback();
            throw e;
        }    
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Evento> listaEventos() {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        try{
            List<Evento> eventos = Collections.synchronizedList(session.createCriteria(Evento.class).list());
            t.commit();
            return eventos;
        }catch(RuntimeException e){
            t.rollback();
            throw e;
        }
    }

    @Override
    public void removerEvento(Evento evento) {
        Session session = this.sessionFactory.openSession();
        if(evento != null){
            session.delete(evento);
        }
    }

    @Override
    public Evento getEvento(long codEvento) {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        try{
            Evento evento = (Evento) session.get(Evento.class, codEvento);
            t.commit();
            return evento;        
        }catch(RuntimeException e){
            t.rollback();
            throw e;
        }
    }
    
}
