/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.DAO;

import artemis.model.Matricula;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

/**
 *
 * @author Wallison
 */
public class MatriculaDAOImpl implements MatriculaDAO{

    private SessionFactory sessionFactory;
    
    public void setSessionFactory(SessionFactory sessionFactory){
        if(sessionFactory != null){
            this.sessionFactory = sessionFactory;
        }else{
            throw new NullPointerException("Argumento de sessão não pode ser nulo!");
        }
    }
    
    @Override
    public void adicionarMatricula(Matricula matricula) {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        try{
            if(matricula != null){
                session.persist(matricula);
            }else{
                throw new NullPointerException("Matricula não pode ser nula!");
            }
            t.commit();
        }catch(RuntimeException e){
            t.rollback();
        }
    }

    @Override
    public void atualizarMatricula(Matricula matricula) {
         Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        try{
            if(matricula != null){
                session.update(matricula);
            }else{
                throw new NullPointerException("Matricula não pode ser nula!");
            }
            t.commit();
        }catch(RuntimeException e){
            t.rollback();
        }
    }

    @Override
    public List<Matricula> listaMatriculas() {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        try{
            List<Matricula> matriculas = session.createCriteria(Matricula.class).list();
            t.commit();
            if(matriculas != null)
                return matriculas;
            else
                return new ArrayList<>();
        }catch(RuntimeException e){
            t.rollback();
            throw e;
        }
    }

    @Override
    public void removeMatricula(Matricula matricula) {
         Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        try{
            if(matricula != null){
                session.delete(matricula);
            }else{
                throw new NullPointerException("Matricula não pode ser nula!");
            }
            t.commit();
        }catch(RuntimeException e){
            t.rollback();
        }
    }

    @Override
    public Matricula getMatricula(long codMatricula) {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        try{
            Matricula matricula = (Matricula) session.load(Matricula.class, codMatricula);
            t.commit();
            return matricula;
        }catch(RuntimeException e){
            t.rollback();
            throw e;
        }  
    }
    
}
