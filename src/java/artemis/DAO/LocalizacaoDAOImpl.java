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
    public Localizacao adicionarLocalizacao(Localizacao localizacao) {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        if(localizacao != null){
            session.persist(localizacao);
            t.commit();
        }else{
            throw new NullPointerException("Localização nula não pode ser salvo!");
        }
        session.close();
        return localizacao;
    }

    @Override
    public void atualizarLocalizacao(Localizacao localizacao) {
        Session session = this.sessionFactory.getCurrentSession();
        if(localizacao != null){
            session.update(localizacao);
        }else{
            throw new NullPointerException("Localização nula não pode ser atualizada!");
        }
    }

    @Override
    public List<Localizacao> listaLocalizacoes() {
        Session session = this.sessionFactory.getCurrentSession();
        List<Localizacao> localizacaos = Collections.synchronizedList(session.createCriteria(Localizacao.class).list());
        return localizacaos;
    }

    @Override
    public void removerLocalizacao(Localizacao localizacao) {
        Session session = this.sessionFactory.getCurrentSession();
        if(localizacao != null){
            session.delete(localizacao);
        }else{
            throw new NullPointerException("Localização nula não pode ser removida!");
        }
    }

    @Override
    public Localizacao getLocalizacao(long codLocalizacao) {
        Session session = this.sessionFactory.getCurrentSession();
        Localizacao localizacao = (Localizacao) session.get(Localizacao.class, codLocalizacao);
        return localizacao;        
    }
    
}
