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
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Wallison
 */
@Repository
public class UsuarioDAOImpl implements UsuarioDAO{    
    private SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
    private static final Logger logger = LoggerFactory.getLogger(UsuarioDAOImpl.class);
            
    public void setSessionFactory(SessionFactory sessionFactory){
        if(sessionFactory != null)
            this.sessionFactory = sessionFactory;
    }
    
    @Override
    public void adicionarUsuario(Usuario usuario) {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        try{
            if(usuario != null){
                session.persist(usuario);
            }else{
                throw new NullPointerException("Usuário não pode ser nulo!");
            }
            t.commit();
        }catch(RuntimeException e){
            t.rollback();
        }
        logger.info("Usuário cadastrado com sucesso!");
    }

    @Override
    public void atualizarUsuario(Usuario usuario) {
        Session session = this.sessionFactory.openSession();
        //atualizaCPF(usuario.getCpf());
        Transaction t  = session.beginTransaction();
        try{
            if(usuario != null){
                session.update(usuario);
                logger.info("Usuario atualizado com sucesso!");
            }else{
                throw new NullPointerException("Usuário não pode ser nulo!");
            }
            t.commit();
        }catch(RuntimeException e){
            t.rollback();
            throw e;
        }
    }
    @SuppressWarnings("unchecked")
    @Override
    public List<Usuario> listaUsuarios() {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        try{
            List<Usuario> usuarios = session.createCriteria(Usuario.class).list();
            t.commit();
            if(usuarios != null)
                return usuarios;
            else
                return new ArrayList<>();
        }catch(RuntimeException e){
            t.rollback();
            throw e;
        }
    }

    @Override
    public void removeUsuario(Usuario usuario) {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        try{
            if(usuario != null){
                session.delete(usuario);
            }else{
                throw new NullPointerException("Usuário não pode ser nulo!");
            }
            t.commit();
        }catch(RuntimeException e){
            t.rollback();
            throw e;
        }
    }

    @Override
    public Usuario getUsuario(long codUsuario) {
        Session session = this.sessionFactory.openSession();
        Transaction t = session.beginTransaction();
        try{
            Usuario usuario = (Usuario) session.load(Usuario.class, codUsuario);
            t.commit();
            return usuario;
        }catch(RuntimeException e){
            t.rollback();
            throw e;
        }    
    }

    @Override
    public void adicionaCPF(CPF cpf) {
        Session session = this.sessionFactory.getCurrentSession();
        Transaction t = session.beginTransaction();
        try{
            if(cpf != null){
                session.persist(cpf);
            }else{
                throw new NullPointerException("CPF não pode ser nulo!");
            }
            t.commit();
        }catch(RuntimeException e){
            t.rollback();
        }
    }

    @Override
    public void atualizaCPF(CPF cpf) {
        Session session = this.sessionFactory.getCurrentSession();
        Transaction t = session.beginTransaction();
        try{
            if(cpf != null){
                session.update(cpf);
            }else{
                throw new NullPointerException("CPF não pode ser nulo!");
            }
            t.commit();
        }catch(RuntimeException e){
            t.rollback();
            throw e;
        }
    }
}
