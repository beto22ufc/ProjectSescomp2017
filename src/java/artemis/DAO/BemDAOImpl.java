/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.DAO;

import artemis.model.Bem;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

/**
 *
 * @author Wallison
 */
public class BemDAOImpl implements BemDAO{
    private SessionFactory sessionFactory;
    
    public void setSessionFactory(SessionFactory sessionFactory){
        if(sessionFactory != null){
            this.sessionFactory = sessionFactory;
        }else{
            throw new NullPointerException("Argumento de sessão não pode ser nulo!");
        }
    }
    @Override
    public void adicionarBem(Bem bem) {
        Session session = this.sessionFactory.getCurrentSession();
        if(bem != null){
            session.persist(bem);
        }else{
            throw new NullPointerException("Bem não pode ser nulo!");
        }
    }

    @Override
    public void atualizarBem(Bem bem) {
        Session session = this.sessionFactory.getCurrentSession();
        if(bem != null){
            session.update(bem);
        }else{
            throw new NullPointerException("Bem não pode ser nulo!");
        }
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Bem> listaBens() {
        Session session = this.sessionFactory.getCurrentSession();
        List<Bem> bens = Collections.synchronizedList(session.createQuery("from bem").list());
        return bens;
    }

    @Override
    public void removerBem(Bem bem) {
        Session session = this.sessionFactory.getCurrentSession();
        if(bem != null){
            session.delete(bem);
        }else{
            throw new NullPointerException("Bem não pode ser nulo!");
        }
    }

    @Override
    public Bem getBem(long codBem) {
        Session session = this.sessionFactory.getCurrentSession();
        Bem bem = (Bem) session.get(Bem.class, codBem);
        return bem;
    }
    
}
