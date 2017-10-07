/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.DAO;

import artemis.model.Curso;
import hibernate.HibernateUtil;
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
    
    private SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
    
            
    public void setSessionFactory(SessionFactory sessionFactory){
        if(sessionFactory != null)
            this.sessionFactory = sessionFactory;
    }

    @Override
    public void adicionarCurso(Curso curso) {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        if(curso != null){
            session.persist(curso);
            t.commit();
        }else{
            throw new NullPointerException("Curso não pode ser nulo!");
        }
        session.close();

    }

    @Override
    public void atualizarCurso(Curso curso) {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        if(curso != null){
            session.update(curso);
            t.commit();
        }else{
            throw new NullPointerException("Curso não pode ser nulo!");
        }
        session.close();
    }

    @Override
    public List<Curso> listaCursos() {
        Session session = this.sessionFactory.getCurrentSession();
        List<Curso> cursos = session.createCriteria(Curso.class).list();
        if(cursos != null)
            return cursos;
        else
            return new ArrayList<>();
        
    }

    @Override
    public void removerCurso(Curso curso) {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        if(curso != null){
            session.delete(curso);
            t.commit();
        }else{
            throw new NullPointerException("Curso não pode ser nulo!");
        }
        session.close();
    }

    @Override
    public Curso getCurso(long codCurso) {
        Session session = this.sessionFactory.getCurrentSession();
        Curso curso = (Curso) session.get(Curso.class, codCurso);
        return curso;
    }
    
}
