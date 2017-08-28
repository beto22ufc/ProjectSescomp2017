/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.DAO;

import artemis.model.Periodo;
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
public class PeriodoDAOImpl implements PeriodoDAO{
    private SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
   
    public void setSessionFactory(SessionFactory sessionFactory){
        if(sessionFactory != null){
            this.sessionFactory = sessionFactory;
        }else{
            throw new NullPointerException("Argumento de sessão nulo!");
        }
    }
    
    @Override
    public void adicionarPeriodo(Periodo periodo) {
        Session session = this.sessionFactory.openSession();
        Transaction t= session.beginTransaction();
        try{
            if(periodo != null){
                session.persist(periodo);
            }else{
                throw new NullPointerException("Periodo não pode ser nula!");
            }
            t.commit();
            session.clear();
        }catch(RuntimeException e){
            t.rollback();
            throw e;
        }finally{
            session.close();
        }
    }

    @Override
    public void atualizarPeriodo(Periodo periodo) {
        Session session = this.sessionFactory.openSession();
        Transaction t= session.beginTransaction();
        try{
            if(periodo != null){
                session.update(periodo);
            }else{
                throw new NullPointerException("Periodo não pode ser nula!");
            }
            t.commit();
            session.clear();
        }catch(RuntimeException e){
            t.rollback();
            throw e;
        }finally{
            session.close();
        }
    }

    @Override
    public List<Periodo> listaPeriodos() {
        Session session = this.sessionFactory.openSession();
        Transaction t= session.beginTransaction();
        try{
            List<Periodo> periodos = Collections.synchronizedList(session.createCriteria(Periodo.class).list());
            t.commit();
            return periodos;
        }catch(RuntimeException e){
            t.rollback();
            throw e;
        }
    }

    @Override
    public void removerPeriodo(Periodo periodo) {
        Session session = this.sessionFactory.openSession();
        Transaction t= session.beginTransaction();
        try{
            if(periodo != null){
                session.delete(periodo);
            }else{
                throw new NullPointerException("Periodo não pode ser nula!");
            }
            t.commit();
            session.clear();
        }catch(RuntimeException e){
            t.rollback();
            throw e;
        }finally{
            session.close();
        }
    }

    @Override
    public Periodo getPeriodo(long codPeriodo) {
        Session session = this.sessionFactory.openSession();
        Transaction t= session.beginTransaction();
        try{
            Periodo periodo = (Periodo) session.get(Periodo.class, codPeriodo);
            t.commit();
            return periodo;
        }catch(RuntimeException e){
            t.rollback();
            throw e;
        }
    }
    
}
