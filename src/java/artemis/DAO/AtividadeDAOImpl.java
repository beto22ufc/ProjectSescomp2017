/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.DAO;

import artemis.model.Atividade;
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
public class AtividadeDAOImpl implements AtividadeDAO{
    private SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
   
    public void setSessionFactory(SessionFactory sessionFactory){
        if(sessionFactory != null){
            this.sessionFactory = sessionFactory;
        }else{
            throw new NullPointerException("Argumento de sessão nulo!");
        }
    }
    @Override
    public Atividade adicionarAtividade(Atividade atividade) {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        if(atividade != null){
            session.persist(atividade);
            t.commit();
        }else{
            throw new NullPointerException("Atividade não pode ser nula!");
        }
        session.close();
        return atividade;
    }

    @Override
    public void atualizarAtividade(Atividade atividade) {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        if(atividade != null){
            session.update(atividade);
            t.commit();
        }else{
            throw new NullPointerException("Atividade não pode ser nula!");
        }
        session.close();
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Atividade> listaAtividades() {
        Session session = this.sessionFactory.getCurrentSession();
        List<Atividade> atividades = Collections.synchronizedList(session.createCriteria(Atividade.class).list());
        return atividades;
    }

    @Override
    public void removerAtividade(Atividade atividade) {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        if(atividade != null){
            session.update(atividade);
            t.commit();
        }else{
            throw new NullPointerException("Atividade não pode ser nula!");
        }
        session.close();
    }

    @Override
    public Atividade getAtividade(long codAtividade) {
        Session session = this.sessionFactory.getCurrentSession();
        Atividade atividade = (Atividade) session.get(Atividade.class, codAtividade);
        return atividade;
    }
    
}
