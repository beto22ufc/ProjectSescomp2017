/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.DAO;

import artemis.model.Localizacao;
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
public class LocalizacaoDAOImpl implements LocalizacaoDAO{

    private SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
    
    public void setSessionFactory(SessionFactory sessionFactory){
        if(sessionFactory != null)
            this.sessionFactory = sessionFactory;
        else
            throw new NullPointerException("Argumento de sessão nulo!");
    }
    
    @Override
    public void adicionarLocalizacao(Localizacao localizacao) {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        try{
            if(localizacao != null){
                session.persist(localizacao);
            }else{
                throw new NullPointerException("Localização nula não pode ser salvo!");
            }
            t.commit();
        }catch(RuntimeException e){
            t.rollback();
            throw e;
        }
    }

    @Override
    public void atualizarLocalizacao(Localizacao localizacao) {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        try{
            if(localizacao != null){
                session.update(localizacao);
            }else{
                throw new NullPointerException("Localização nula não pode ser atualizada!");
            }
            t.commit();
        }catch(RuntimeException e){
            t.rollback();
            throw e;
        }
    }

    @Override
    public List<Localizacao> listaLocalizacoes() {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        try{
            List<Localizacao> localizacaos = Collections.synchronizedList(session.createCriteria(Localizacao.class).list());
            t.commit();
            return localizacaos;
        }catch(RuntimeException e){
            t.rollback();
            throw e;
        }
    }

    @Override
    public void removerLocalizacao(Localizacao localizacao) {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        try{
            if(localizacao != null){
                session.delete(localizacao);
            }else{
                throw new NullPointerException("Localização nula não pode ser removida!");
            }
            t.commit();
        }catch(RuntimeException e){
            t.rollback();
            throw e;
        }
    }

    @Override
    public Localizacao getLocalizacao(long codLocalizacao) {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        try{
            Localizacao localizacao = (Localizacao) session.get(Localizacao.class, codLocalizacao);
            t.commit();
            return localizacao;        
        }catch(RuntimeException e){
            t.rollback();
            throw e;
        }
    }
    
}
