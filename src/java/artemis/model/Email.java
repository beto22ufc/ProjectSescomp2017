/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.model;

import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import org.apache.commons.mail.SimpleEmail;

/**
 *
 * @author Wallison
 */
public class Email {
    
    private String hostName = "smtp.gmail.com";
    private final int port =465;
    private String fromEmail;
    private String message;
    private String assunto;
    private String user ="wallisonrocha2008";
    private String pass ="27019899316186";
    private String nomeTo;
    private HtmlEmail emailHtml = new HtmlEmail();
    public Email()
    {
        super();
    }
    public Email(String assunto, String message, String fromEmail, String nome)
    {
        this.assunto = assunto;
        this.message = message;
        this.fromEmail = fromEmail;
        this.nomeTo = nome;
    }
    public void sendEmail() throws EmailException {
        try{
            SimpleEmail email = new SimpleEmail();
            //Utilize o hostname do seu provedor de email
            email.setHostName(hostName);
            //Quando a porta utilizada n�o � a padr�o (gmail = 465)
            email.setSmtpPort(port);
            //Adicione os destinat�rios
            email.addTo(this.fromEmail, this.nomeTo);
            //Configure o seu email do qual enviar�
            email.setFrom("wallisonrocha2008@gmail.com", "Artemis");
            //Adicione um assunto
            email.setSubject(this.assunto);
            //Adicione a mensagem do email
            email.setMsg(this.message);
            //Para autenticar no servidor � necess�rio chamar os dois m�todos abaixo
            email.setSSL(true);
            email.setAuthentication(user, pass);
            email.send();
        }catch(EmailException e){
            throw new EmailException("Não foi possível enviar o email!");
	}
    }
    
    public void sendEmailHtml() throws EmailException{
        try{
            HtmlEmail email = emailHtml;
            //Utilize o hostname do seu provedor de email
            email.setHostName(hostName);
            //Quando a porta utilizada n�o � a padr�o (gmail = 465)
            email.setSmtpPort(port);
            //Adicione os destinat�rios
            email.addTo(this.fromEmail, this.nomeTo);
            //Configure o seu email do qual enviar�
            email.setFrom("wallisonrocha2008@gmail.com", "Artemis");
            //Adicione um assunto
            email.setSubject(this.assunto);
            //Adicione a mensagem do email
            email.setHtmlMsg(this.message);
            //Para autenticar no servidor � necess�rio chamar os dois m�todos abaixo
            email.setSSL(true);
            email.setAuthentication(user, pass);
            email.send();
        }catch(EmailException e){
            throw new EmailException("Não foi possível enviar o email!");
	}
    }
    
    public String getHostName() {
        return hostName;
    }

    public void setHostName(String hostName) {
        this.hostName = hostName;
    }

    public String getFromEmail() {
        return fromEmail;
    }

    public void setFromEmail(String fromEmail) {
        this.fromEmail = fromEmail;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getAssunto() {
        return assunto;
    }

    public void setAssunto(String assunto) {
        this.assunto = assunto;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public String getNomeTo() {
        return nomeTo;
    }

    public void setNomeTo(String nomeTo) {
        this.nomeTo = nomeTo;
    }

    public HtmlEmail getEmailHtml() {
        return emailHtml;
    }

    public void setEmailHtml(HtmlEmail emailHtml) {
        this.emailHtml = emailHtml;
    }
    
    

}
