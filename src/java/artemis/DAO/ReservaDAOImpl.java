/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.DAO;

import artemis.model.Reserva;
import java.util.Collections;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

/**
 *
 * @author Wallison
 */
public class ReservaDAOImpl implements ReservaDAO{
    
    private SessionFactory sessionFactory;
    
    public void setSessionFactory(SessionFactory sessionFactory){
        if(sessionFactory != null)
            this.sessionFactory = sessionFactory;
        else
            throw new NullPointerException("Argumento de sessão nulo!");
    }

    @Override
    public void adicionarReserva(Reserva reserva) {
        Session session = this.sessionFactory.getCurrentSession();
        if(reserva != null){
            session.persist(reserva);
        }else{
            throw new NullPointerException("Reserva não pode ser nulo!");
        }
    }

    @Override
    public void atualizarReserva(Reserva reserva) {
        Session session = this.sessionFactory.getCurrentSession();
        if(reserva != null){
            session.update(reserva);
        }else{
            throw new NullPointerException("Reserva não pode ser nulo!");
        }
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Reserva> listaReservas() {
        Session session = this.sessionFactory.getCurrentSession();
        List<Reserva> reservas = Collections.synchronizedList(session.createQuery("from reservas").list());
        return reservas;
    }

    @Override
    public void removerReserva(Reserva reserva) {
        Session session = this.sessionFactory.getCurrentSession();
        if(reserva != null){
            session.delete(reserva);
        }else{
            throw new NullPointerException("Reserva não pode ser nulo!");
        }
    }

    @Override
    public Reserva getReserva(long codReserva) {
        Session session = this.sessionFactory.getCurrentSession();
        Reserva reserva = (Reserva) session.get(Reserva.class, codReserva);
        return reserva;
    }
    
}
