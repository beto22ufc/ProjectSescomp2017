/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.DAO;

import artemis.model.Curso;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

/**
 *
 * @author Wallison
 */
public class CursoDAOImpl implements CursoDAO{
    
    private SessionFactory sessionFactory;
    
            
    public void setSessionFactory(SessionFactory sessionFactory){
        if(sessionFactory != null)
            this.sessionFactory = sessionFactory;
    }

    @Override
    public void adicionarCurso(Curso curso) {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        try{
            if(curso != null){
                session.persist(curso);
            }else{
                throw new NullPointerException("Curso não pode ser nulo!");
            }
            t.commit();
        }catch(RuntimeException e){
            t.rollback();
        }
    }

    @Override
    public void atualizarCurso(Curso curso) {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        try{
            if(curso != null){
                session.update(curso);
            }else{
                throw new NullPointerException("Curso não pode ser nulo!");
            }
            t.commit();
        }catch(RuntimeException e){
            t.rollback();
        }
    }

    @Override
    public List<Curso> listaCursos() {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        try{
            List<Curso> cursos = session.createCriteria(Curso.class).list();
            t.commit();
            if(cursos != null)
                return cursos;
            else
                return new ArrayList<>();
        }catch(RuntimeException e){
            t.rollback();
            throw e;
        }
    }

    @Override
    public void removerCurso(Curso curso) {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        try{
            if(curso != null){
                session.delete(curso);
            }else{
                throw new NullPointerException("Curso não pode ser nulo!");
            }
            t.commit();
        }catch(RuntimeException e){
            t.rollback();
        }
    }

    @Override
    public Curso getCurso(long codCurso) {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        try{
            Curso curso = (Curso) session.load(Curso.class, codCurso);
            t.commit();
            return curso;
        }catch(RuntimeException e){
            t.rollback();
            throw e;
        }
    }
    
}
