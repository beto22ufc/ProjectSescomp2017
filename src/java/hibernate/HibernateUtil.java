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
import artemis.model.ContasSociais;
import artemis.model.Curso;
import artemis.model.Espera;
import artemis.model.Evento;
import artemis.model.Imagem;
import artemis.model.Inscricao;
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
                /*
            <hibernate-configuration>
  <session-factory>
    <property name="hibernate.show_sql">true</property>
    <property name="hibernate.current_session_context_class">thread</property>
    <property name="hibernate.query.factory_class">org.hibernate.hql.internal.classic.ClassicQueryTranslatorFactory</property>
    <property name="hibernate.hbm2ddl.auto">update</property>
    <property name="hibernate.dialect">org.hibernate.dialect.PostgreSQLDialect</property>
    <property name="hibernate.connection.driver_class">org.postgresql.Driver</property>
    <property name="hibernate.connection.url">jdbc:postgresql://200.129.62.41:5432/artemis</property>
    <property name="hibernate.connection.username">artemis</property>
    <property name="hibernate.connection.password">4rt3m15</property>
    <property name="hibernate.event.merge.entity_copy_observer">allow</property>
  </session-factory>
</hibernate-configuration>
        Configuration conf = new Configuration();
            conf.setProperty("hibernate.dialect", "org.hibernate.dialect.PostgreSQLDialect");
            conf.setProperty("hibernate.connection.url", "jdbc:postgresql://200.129.62.41:5432/artemis");
            conf.setProperty("hibernate.connection.driver_class", "org.postgresql.Driver");
            conf.setProperty("hibernate.connection.username", "artemis");
            conf.setProperty("hibernate.connection.password", "4rt3m15");
        */
        if(sessionFactory == null){
            Configuration conf = new Configuration();
            conf.setProperty("hibernate.dialect", "org.hibernate.dialect.PostgreSQLDialect");
            conf.setProperty("hibernate.connection.url", "jdbc:postgresql://localhost:5432/artemis2");
            conf.setProperty("hibernate.connection.driver_class", "org.postgresql.Driver");
            conf.setProperty("hibernate.connection.username", "postgres");
            conf.setProperty("hibernate.connection.password", "aqbp!@12");
            conf.setProperty("current_session_context_class", "thread");
            conf.addAnnotatedClass(CPF.class);
            conf.addAnnotatedClass(Curso.class);
            conf.addAnnotatedClass(Matricula.class);
            conf.addAnnotatedClass(Instituicao.class);
            conf.addAnnotatedClass(Localizacao.class);
            conf.addAnnotatedClass(ContasSociais.class);
            conf.addAnnotatedClass(Imagem.class);
            conf.addAnnotatedClass(Usuario.class);
            conf.addAnnotatedClass(ContaAtivacao.class);
            conf.addAnnotatedClass(Periodo.class);
            conf.addAnnotatedClass(Local.class);
            conf.addAnnotatedClass(Bem.class);
            conf.addAnnotatedClass(Reserva.class);
            conf.addAnnotatedClass(ReservaBem.class);
            conf.addAnnotatedClass(ReservaLocal.class);
            conf.addAnnotatedClass(Inscricao.class);
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
