/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.DAO;

import artemis.model.Inscricao;
import java.util.Collections;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

/**
 *
 * @author Wallison
 */
public class InscricaoDAOImpl implements InscricaoDAO{
    SessionFactory sessionFactory = null;
    
    public void setSessionFactory(SessionFactory sessionFactory){
        if(sessionFactory != null){
            this.sessionFactory = sessionFactory;
        }else{
            throw new NullPointerException("Argumento de sessão não pode ser nulo!");
        }
    }
    
    @Override
    public void adicionarInscricao(Inscricao inscricao) {
        Session session = this.sessionFactory.getCurrentSession();
        if(inscricao != null){
            session.persist(inscricao);
        }else{
            throw new NullPointerException("Inscrição não pode ser nula!");
        }
    }

    @Override
    public void atualizarInscricao(Inscricao inscricao) {
        Session session = this.sessionFactory.getCurrentSession();
        if(inscricao != null){
            session.update(inscricao);
        }else{
            throw new NullPointerException("Inscrição não pode ser nula!");
        }
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Inscricao> listaInscricoes() {
        Session session = this.sessionFactory.getCurrentSession();
        List<Inscricao> inscricoes = Collections.synchronizedList(session.createQuery("from inscricao").list());
        return inscricoes;
    }

    @Override
    public void removerInscricao(Inscricao inscricao) {
        Session session = this.sessionFactory.getCurrentSession();
        if(inscricao != null){
            session.delete(inscricao);
        }else{
            throw new NullPointerException("Inscrição não pode ser nula");
        }
    }

    @Override
    public Inscricao getInscricao(long codInscricao) {
        Session session = this.sessionFactory.getCurrentSession();
        Inscricao inscricao = (Inscricao) session.get(Inscricao.class, codInscricao);
        return inscricao;
    }
        
}
