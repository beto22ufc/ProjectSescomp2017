/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hibernate;

import artemis.model.Atividade;
import artemis.model.Bem;
import artemis.model.CPF;
import artemis.model.ContaAtivacao;
import artemis.model.Curso;
import artemis.model.Espera;
import artemis.model.Evento;
import artemis.model.Inscricao;
import artemis.model.InscricaoAtividade;
import artemis.model.InscricaoEvento;
import artemis.model.Instituicao;
import artemis.model.Local;
import artemis.model.Localizacao;
import artemis.model.Matricula;
import artemis.model.Periodo;
import artemis.model.Reserva;
import artemis.model.ReservaBem;
import artemis.model.ReservaLocal;
import artemis.model.Usuario;
import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.boot.registry.internal.StandardServiceRegistryImpl;
import org.hibernate.cfg.Configuration;
import org.hibernate.service.ServiceRegistry;

/**
 *
 * @author Wallison
 */
public class HibernateUtil {
    private static SessionFactory sessionFactory;
    public static SessionFactory getSessionFactory(){
        if(sessionFactory == null){
            Configuration conf = new Configuration();
            conf.setProperty("hibernate.dialect", "org.hibernate.dialect.PostgreSQLDialect");
            conf.setProperty("hibernate.connection.url", "jdbc:postgresql://localhost:5432/artemis");
            conf.setProperty("hibernate.connection.driver_class", "org.postgresql.Driver");
            conf.setProperty("hibernate.connection.username", "postgres");
            conf.setProperty("hibernate.connection.password", "aqbp!@12");
            conf.addAnnotatedClass(CPF.class);
            conf.addAnnotatedClass(Curso.class);
            conf.addAnnotatedClass(Matricula.class);
            conf.addAnnotatedClass(Instituicao.class);
            conf.addAnnotatedClass(Localizacao.class);
            conf.addAnnotatedClass(Usuario.class);
            conf.addAnnotatedClass(ContaAtivacao.class);
            conf.addAnnotatedClass(Periodo.class);
            conf.addAnnotatedClass(Local.class);
            conf.addAnnotatedClass(Bem.class);
            conf.addAnnotatedClass(Reserva.class);
            conf.addAnnotatedClass(ReservaBem.class);
            conf.addAnnotatedClass(ReservaLocal.class);
            conf.addAnnotatedClass(Inscricao.class);
            conf.addAnnotatedClass(InscricaoAtividade.class);
            conf.addAnnotatedClass(InscricaoEvento.class);
            conf.addAnnotatedClass(Espera.class);
            conf.addAnnotatedClass(Atividade.class);
            conf.addAnnotatedClass(Evento.class);
            ServiceRegistry serviceRegistry = new StandardServiceRegistryBuilder().applySettings(conf.getProperties()).build();
            sessionFactory = conf.configure("hibernate/hibernate.cfg.xml").buildSessionFactory(serviceRegistry);
            return sessionFactory;
        }else{
            return sessionFactory;
        }
    }
}
