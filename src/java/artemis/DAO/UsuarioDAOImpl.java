/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.DAO;

import artemis.model.CPF;
import artemis.model.Usuario;
import hibernate.HibernateUtil;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Wallison
 */
@Repository
public class UsuarioDAOImpl implements UsuarioDAO{    
    private SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
            
    public void setSessionFactory(SessionFactory sessionFactory){
        if(sessionFactory != null)
            this.sessionFactory = sessionFactory;
    }
    
    @Override
    public void adicionarUsuario(Usuario usuario) {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        if(usuario != null){
            session.persist(usuario);
            t.commit();
        }else{
            throw new NullPointerException("Usuário não pode ser nulo!");
        }
        session.close();
    }

    @Override
    public void atualizarUsuario(Usuario usuario) {
        Session session = this.sessionFactory.openSession();
        //atualizaCPF(usuario.getCpf());
        Transaction t = session.beginTransaction();
        if(usuario != null){
            session.update(usuario);
            t.commit();
        }else{
            throw new NullPointerException("Usuário não pode ser nulo!");
        }
        session.close();
    }
    @SuppressWarnings("unchecked")
    @Override
    public List<Usuario> listaUsuarios() {
        Session session = this.sessionFactory.getCurrentSession();
        List<Usuario> usuarios = session.createCriteria(Usuario.class).list();
        if(usuarios != null)
            return usuarios;
        else
            return new ArrayList<>();
    }

    @Override
    public void removeUsuario(Usuario usuario) {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        if(usuario != null){
            session.delete(usuario);
            t.commit();
        }else{
            throw new NullPointerException("Usuário não pode ser nulo!");
        }
        session.close();
    }

    @Override
    public Usuario getUsuario(long codUsuario) {
        Session session = this.sessionFactory.getCurrentSession();
        try{
            Usuario usuario = (Usuario) session.get(Usuario.class, codUsuario);
            return usuario;
        }catch(RuntimeException e){
            throw e;
        }  
        
    }

    @Override
    public void adicionaCPF(CPF cpf) {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        if(cpf != null){
            session.persist(cpf);
            t.commit();
        }else{
            throw new NullPointerException("CPF não pode ser nulo!");
        }
        session.close();
    }

    @Override
    public void atualizaCPF(CPF cpf) {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        if(cpf != null){
            session.update(cpf);
            t.commit();
        }else{
            throw new NullPointerException("CPF não pode ser nulo!");
        }
        session.close();
    }

    @Override
    public Usuario getUsuarioFromEmail(String email) {
        Session session = this.sessionFactory.getCurrentSession();
        Usuario usuario = null;
        if(email != null){
            usuario = (Usuario) session.createCriteria(Usuario.class, "u").add(Restrictions.eq("u.email", email)).uniqueResult();
        }else{
            throw new NullPointerException("E-mail não pode ser nulo!");
        }
        return usuario;
    }
}
