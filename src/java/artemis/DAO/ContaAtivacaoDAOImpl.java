/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.DAO;

import artemis.model.ContaAtivacao;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

/**
 *
 * @author Wallison
 */
public class ContaAtivacaoDAOImpl implements ContaAtivacaoDAO{
    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) {
        if(sessionFactory != null)
            this.sessionFactory = sessionFactory;
        else
            throw new NullPointerException("Sessão factory não pode ser nulo!");
    }
    
    
    @Override
    public void adicionarContaAtivacao(ContaAtivacao ca) {
        Session session = sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        try{
            if(ca != null){
                session.persist(ca);
            }else{
                throw new NullPointerException("Conta ativação não pode ser nula!");
            }
            t.commit();
        }catch(RuntimeException e){
            t.rollback();
            throw e;
        }
    }

    @Override
    public void atualizarContaAtivacao(ContaAtivacao ca) {
        Session session = sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        try{
            if(ca != null){
                session.update(ca);
            }else{
                throw new NullPointerException("Conta ativação não pode ser nula!");
            }
            t.commit();
        }catch(RuntimeException e){
            t.rollback();
            throw e;
        }
    }

    @Override
    public List<ContaAtivacao> listaContasAtivacao() {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        try{
            List<ContaAtivacao> contas = (session.createCriteria(ContaAtivacao.class).list());
            t.commit();
            if(contas != null)
                return contas;
            else
                return new ArrayList<>();
        }catch(RuntimeException e){
            t.rollback();
            throw e;
        }    
    }

    @Override
    public void removerContaAtivacao(ContaAtivacao ca) {
        Session session = sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        try{
            if(ca != null){
                session.delete(ca);
            }else{
                throw new NullPointerException("Conta ativação não pode ser nula!");
            }
            t.commit();
        }catch(RuntimeException e){
            t.rollback();
            throw e;
        }
    }

    @Override
    public ContaAtivacao getContaAtivacao(long codContaAtivacao) {
        Session session = this.sessionFactory.openSession();
        Transaction t  = session.beginTransaction();
        try{
            ContaAtivacao conta = (ContaAtivacao) session.get(ContaAtivacao.class, codContaAtivacao);
            t.commit();
            return conta;
        }catch(RuntimeException e){
            t.rollback();
            throw e;
        }
    }
    
}
