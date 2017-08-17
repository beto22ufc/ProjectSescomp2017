/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.model;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author Wallison
 */
public class EmailValidator {
        private Pattern pattern;
	private Matcher matcher;
        private static EmailValidator emailValidator;
	private static final String EMAIL_PATTERN =
		"^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@"
		+ "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";

	private EmailValidator() {
		pattern = Pattern.compile(EMAIL_PATTERN);
	}
        public static EmailValidator getInstance(){
            if(emailValidator == null){
               emailValidator = new EmailValidator();
            }
            return emailValidator;
        }
	/**
	 * Validar expressão de email
	 *
	 * @param email
	 *            email para validação
	 * @return true email válido , false email inválido
	 */
	public  boolean validate(final String email) {
            matcher = pattern.matcher(email);
            return matcher.matches();
	}
}
