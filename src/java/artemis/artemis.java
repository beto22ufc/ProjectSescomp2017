/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis;
import artemis.model.*;
import org.hibernate.cfg.Configuration;
import org.hibernate.tool.hbm2ddl.SchemaExport;

/**
 *
 * @author Wallison
 */
public class artemis {
    public static void main(String[] args) throws Exception {

        Configuration conf = new Configuration();
	conf.configure("hibernate/hibernate.cfg.xml");
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
        SchemaExport se = new SchemaExport(conf);
	se.create(true, true);
    }
}
