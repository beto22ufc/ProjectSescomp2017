/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.DAO;

import artemis.model.Instituicao;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @author Wallison
 */
public class InstituicaoDAOImpl implements InstituicaoDAO{
    private SessionFactory sessionFactory;
    
            
    public void setSessionFactory(SessionFactory sessionFactory){
        if(sessionFactory != null)
            this.sessionFactory = sessionFactory;
    }

    @Override
    public void adicionarInstituicao(Instituicao instituicao) {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        try{
            if(instituicao != null){
                session.persist(instituicao);
            }else{
                throw new NullPointerException("Instituição não pode ser nula!");
            }
            t.commit();
        }catch(RuntimeException e){
            t.rollback();
            session.close();
            throw e;
        }
    }

    @Override
    public void atualizarInstituicao(Instituicao instituicao) {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        try{
            if(instituicao != null){
                session.update(instituicao);
            }else{
                throw new NullPointerException("Instituição não pode ser nula!");
            }
            t.commit();
        }catch(RuntimeException e){
            t.rollback();
            throw e;
        }
    }

    @Override
    public List<Instituicao> listaInstituicoes() {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        try{
            List<Instituicao> instituicoes = session.createCriteria(Instituicao.class).list();
            t.commit();
            if(instituicoes != null)
                return instituicoes;
            else
                return new ArrayList<>();
        }catch(RuntimeException e){
            t.rollback();
            throw e;
        }
    }

    @Override
    public void removerInstituicao(Instituicao instituicao) {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        try{
            if(instituicao != null){
                session.delete(instituicao);
            }else{
                throw new NullPointerException("Instituição não pode ser nula!");
            }
            t.commit();
        }catch(RuntimeException e){
            t.rollback();
            throw e;
        }
    }

    @Override
    public Instituicao getInstituicao(long codInstituicao) {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        try{
            Instituicao instituicao = (Instituicao) session.load(Instituicao.class, codInstituicao);
            t.commit();
            return instituicao;
        }catch(RuntimeException e){
            t.rollback();
            throw e;
        }
    }
    
}
