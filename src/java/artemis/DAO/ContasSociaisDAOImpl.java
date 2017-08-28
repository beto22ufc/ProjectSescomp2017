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
        Transaction t= session.beginTransaction();
        try{
            if(contasSociais != null){
                session.persist(contasSociais);
            }else{
                throw new NullPointerException("Atividade não pode ser nula!");
            }
            t.commit();
            session.clear();
            return contasSociais;
        }catch(RuntimeException e){
            t.rollback();
            throw e;
        }finally{
            session.close();
        }
    }

    @Override
    public void atualizarContasSociais(ContasSociais contasSociais) {
        Session session = this.sessionFactory.openSession();
        Transaction t= session.beginTransaction();
        try{
            if(contasSociais != null){
                session.update(contasSociais);
            }else{
                throw new NullPointerException("Atividade não pode ser nula!");
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
    public List<ContasSociais> listaContasSociais() {
        Session session = this.sessionFactory.openSession();
        Transaction t= session.beginTransaction();
        try{
            List<ContasSociais> atividades = Collections.synchronizedList(session.createCriteria(ContasSociais.class).list());
            t.commit();
            return atividades;
        }catch(RuntimeException e){
            t.rollback();
            throw e;
        }
    }

    @Override
    public void removerAtividade(ContasSociais contasSociais) {
        Session session = this.sessionFactory.openSession();
        Transaction t= session.beginTransaction();
        try{
            if(contasSociais != null){
                session.delete(contasSociais);
            }else{
                throw new NullPointerException("Atividade não pode ser nula!");
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
    public ContasSociais getContasSociais(long codContasSociais) {
        Session session = this.sessionFactory.openSession();
        Transaction t= session.beginTransaction();
        try{
            ContasSociais contasSociais = (ContasSociais) session.get(ContasSociais.class, codContasSociais);
            t.commit();
            return contasSociais;
        }catch(RuntimeException e){
            t.rollback();
            throw e;
        }
    }
}
