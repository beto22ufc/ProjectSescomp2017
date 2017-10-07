/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis;
import artemis.model.*;
import java.io.File;
import java.time.LocalDate;
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
        SchemaExport se = new SchemaExport(conf);
	se.create(true, true);
        /*File file  = new File("web/theme/sistema/email/confirm/index.html");
            File image01  = new File("web/theme/sistema/email/confirm/images/image01.png");
            File image02  = new File("web/theme/sistema/email/confirm/images/image02.png");
            File image03  = new File("web/theme/sistema/email/confirm/images/image03.png");
            File image04  = new File("web/theme/sistema/email/confirm/images/image04.png");
            if(file.exists()){
            String html = Email.fileToString(file);
                html = html.replace("#{keywords}", "Sistema de gerenciamento de eventos Artemis Events")
                        .replace("#{image01}", ImageManipulation.encodeImage(image01))
                        .replace("#{image02}", ImageManipulation.encodeImage(image02))
                        .replace("#{image03}", ImageManipulation.encodeImage(image03))
                        .replace("#{image04}", ImageManipulation.encodeImage(image04))
                        .replace("#{linkConfirmaConta}", "http://localhost:8084/ArtemisTCC/validarConta?cv="+conta.getCodigo()+"")
                        .replace("#{data}", ""+LocalDate.now().getYear());
                System.out.println(html);
            }else{
                System.out.println("Arquivo não encontrado");
            }*/
    }
}
