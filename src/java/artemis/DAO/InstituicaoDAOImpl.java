/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.DAO;

import artemis.model.Instituicao;
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
public class InstituicaoDAOImpl implements InstituicaoDAO{
    private SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
    
            
    public void setSessionFactory(SessionFactory sessionFactory){
        if(sessionFactory != null)
            this.sessionFactory = sessionFactory;
    }

    @Override
    public void adicionarInstituicao(Instituicao instituicao) {
        Session session = this.sessionFactory.getCurrentSession();
        if(instituicao != null){
            session.persist(instituicao);
        }else{
            throw new NullPointerException("Instituição não pode ser nula!");
        }
    }

    @Override
    public void atualizarInstituicao(Instituicao instituicao) {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        if(instituicao != null){
            session.update(instituicao);
            t.commit();
        }else{
            throw new NullPointerException("Instituição não pode ser nula!");
        }
        session.close();
    }

    @Override
    public List<Instituicao> listaInstituicoes() {
        Session session = this.sessionFactory.getCurrentSession();
        List<Instituicao> instituicoes = session.createCriteria(Instituicao.class).list();
        if(instituicoes != null)
            return instituicoes;
        else
            return new ArrayList<>();
    }

    @Override
    public void removerInstituicao(Instituicao instituicao) {
        Session session = this.sessionFactory.getCurrentSession();
        if(instituicao != null){
            session.delete(instituicao);
        }else{
            throw new NullPointerException("Instituição não pode ser nula!");
        }
    }

    @Override
    public Instituicao getInstituicao(long codInstituicao) {
        Session session = this.sessionFactory.getCurrentSession();
        Instituicao instituicao = (Instituicao) session.load(Instituicao.class, codInstituicao);
        return instituicao;
    }
    
}
