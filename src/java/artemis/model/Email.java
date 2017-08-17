package artemis.model;

import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.SimpleEmail;

public class Email {
    
    private String hostName = "smtp.gmail.com";
    private final int port =465;
    private String fromEmail;
    private String message;
    private String assunto;
    private String user ="wallisonrocha2008";
    private String pass ="27019899316186";
    private String nomeTo;
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
            System.out.println("alterando hostname...");
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
            System.out.println("autenticando...");
            email.setSSL(true);
            email.setAuthentication(user, pass);
            System.out.println("enviando...");
            email.send();
            System.out.println("Email enviado!");
        }catch(EmailException e){
            throw new EmailException("Não foi possível enviar o email!");
	}
   }
   
}
