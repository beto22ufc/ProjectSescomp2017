/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.DAO;

import artemis.model.Local;
import java.util.Collections;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

/**
 *
 * @author Wallison
 */
public class LocalDAOImpl implements LocalDAO{
    private SessionFactory sessionFactory;
    
    public void setSessionFactory(SessionFactory sessionFactory){
        if(sessionFactory != null){
            this.sessionFactory = sessionFactory;
        }else{
            throw new NullPointerException("Argumento de sessão não pode ser nulo!");
        }
    }
    
    @Override
    public void adicionarLocal(Local local) {
        Session session = this.sessionFactory.getCurrentSession();
        if(local != null){
            session.persist(local);
        }else{
            throw new NullPointerException("Local não pode ser nulo!");
        }
    }

    @Override
    public void atualizarLocal(Local local) {
        Session session = this.sessionFactory.getCurrentSession();
        if(local != null){
            session.update(local);
        }else{
            throw new NullPointerException("Local não pode ser nulo!");
        }
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Local> listaLocais() {
        Session session = this.sessionFactory.getCurrentSession();
        List<Local>  locais = Collections.synchronizedList(session.createQuery("from local").list());
        return locais;
    }

    @Override
    public void removerLocal(Local local) {
        Session session = this.sessionFactory.getCurrentSession();
        if(local != null){
            session.delete(local);
        }else{
            throw new NullPointerException("Local não pode ser nulo!");
        }
    }

    @Override
    public Local getLocal(long codLocal) {
        Session session = this.sessionFactory.getCurrentSession();
        Local local = (Local) session.get(Local.class, codLocal);
        return local;
    }
    
}
