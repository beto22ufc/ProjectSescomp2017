/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.DAO;

import artemis.model.ContasSociais;
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
public class ContasSociaisDAOImpl implements ContasSociaisDAO{
    private SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
   
    public void setSessionFactory(SessionFactory sessionFactory){
        if(sessionFactory != null){
            this.sessionFactory = sessionFactory;
        }else{
            throw new NullPointerException("Argumento de sessão nulo!");
        }
    }

    @Override
    public ContasSociais adicionarContasSociais(ContasSociais contasSociais) {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        if(contasSociais != null){
            session.persist(contasSociais);
            t.commit();
        }else{
            throw new NullPointerException("Atividade não pode ser nula!");
        }
        session.close();
        return contasSociais;
    }

    @Override
    public void atualizarContasSociais(ContasSociais contasSociais) {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        if(contasSociais != null){
            session.update(contasSociais);
            t.commit();
        }else{
            throw new NullPointerException("Atividade não pode ser nula!");
        }
        session.close();
    }

    @Override
    public List<ContasSociais> listaContasSociais() {
        Session session = this.sessionFactory.getCurrentSession();
        List<ContasSociais> atividades = Collections.synchronizedList(session.createCriteria(ContasSociais.class).list());
        return atividades;
    }

    @Override
    public void removerAtividade(ContasSociais contasSociais) {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        if(contasSociais != null){
            session.delete(contasSociais);
            t.commit();
        }else{
            throw new NullPointerException("Atividade não pode ser nula!");
        }
        session.close();
    }

    @Override
    public ContasSociais getContasSociais(long codContasSociais) {
        Session session = this.sessionFactory.getCurrentSession();
        ContasSociais contasSociais = (ContasSociais) session.get(ContasSociais.class, codContasSociais);
        return contasSociais;
    }
}
