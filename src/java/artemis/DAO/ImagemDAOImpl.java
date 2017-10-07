/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.DAO;

import artemis.model.Imagem;
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
public class ImagemDAOImpl implements ImagemDAO{
    
    private SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
   
    public void setSessionFactory(SessionFactory sessionFactory){
        if(sessionFactory != null){
            this.sessionFactory = sessionFactory;
        }else{
            throw new NullPointerException("Argumento de sessão nulo!");
        }
    }

    @Override
    public void adicionarImagem(Imagem imagem) {
        Session session = this.sessionFactory.getCurrentSession();
        if(imagem != null){
            session.persist(imagem);
        }else{
            throw new NullPointerException("Imagem não pode ser nula!");
        }
    }

    @Override
    public void atualizarImagem(Imagem imagem) {
        Session session = this.sessionFactory.getCurrentSession();
        if(imagem != null){
            session.update(imagem);
        }else{
            throw new NullPointerException("Imagem não pode ser nula!");
        }

    }

    @Override
    public List<Imagem> listaImagens() {
        Session session = this.sessionFactory.openSession();
        List<Imagem> imagens = Collections.synchronizedList(session.createCriteria(Imagem.class).list());
        return imagens;
    }

    @Override
    public void removerImagem(Imagem imagem) {
        Session session = this.sessionFactory.openSession();
        if(imagem != null){
            session.delete(imagem);
        }else{
            throw new NullPointerException("Imagem não pode ser nula!");
        }
    }

    @Override
    public Imagem getImagem(long codImagem) {
        Session session = this.sessionFactory.openSession();
        Imagem imagem = (Imagem) session.get(Imagem.class, codImagem);
        return imagem;
    }
    
}
